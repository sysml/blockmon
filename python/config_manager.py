#Copyright (c) 2011, NEC Europe Ltd, Consorzio Nazionale 
#Interuniversitario per le Telecomunicazioni, Institut 
#Telecom/Telecom Bretagne, ETH Zürich, INVEA-TECH a.s. All rights reserved.
#
#Redistribution and use in source and binary forms, with or without 
#modification, are permitted provided that the following conditions are met:
#   * Redistributions of source code must retain the above copyright
#     notice, this list of conditions and the following disclaimer.
#   * Redistributions in binary form must reproduce the above copyright
#     notice, this list of conditions and the following disclaimer in the
#     documentation and/or other materials provided with the distribution.
#   * Neither the names of NEC Europe Ltd, Consorzio Nazionale 
#     Interuniversitario per le Telecomunicazioni, Institut Telecom/Telecom 
#     Bretagne, ETH Zürich, INVEA-TECH a.s. nor the names of its contributors 
#     may be used to endorse or promote products derived from this software 
#     without specific prior written permission.
#
#THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS 
#"AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT 
#LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR 
#A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL <COPYRIGHT 
#HOLDERBE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, 
#EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, 
#PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR 
#PROFITS; OR BUSINESS
#INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER 
#IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR 
#OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF 
#ADVISED OF THE POSSIBILITY OF SUCH DAMAGE

#@ authors
#Andrea Di Pietro <andrea.dipietro@for.unipi.it> 



import xml.dom.minidom

import imp

blockmon=imp.load_dynamic('blockmon','../libblockmon.so')

class CM:
        ConfigManager={}

class ThreadPool:
        def __init__(self,poolnode):
                self.blocks=[]
                self.name=  str(poolnode.attributes['id'].value)
                self.nthreads= poolnode.attributes['num_threads'].value
                blockmon.add_thread_pool(str(poolnode.toxml()))



        def add_block(self,composition, name):
                self.blocks.append((composition,name))
                blockmon.add_block_to_thread_pool(composition,name,self.name)

        def remove_block(self,composition,  name):
                self.blocks.remove((composition,name))
                blockmon.remove_block_from_thread_pool(composition,name,self.name)

        def __del__(self):
                if(len(self.blocks)>0):
                        raise Exception('removing thread pool having assigned tasks')
                blockmon.remove_thread_pool(self.name)





class Block:
        def __init__(self,name,btype,composition,ts,active,params,tpool):
                self.name=str(name)
                self.btype=str(btype)
                self.active=active
                self.ts=ts
                self.tpool=str(tpool)
                self.composition=str(composition)
                self.connections=[]
                self.params=str(params)
                self.ingates={}
                self.outgates={}   
                blockmon.create_block(self.composition,self.name,self.btype,self.ts,self.active,self.params)
                if(active):
                        CM.ConfigManager[self.composition].thread_pools[self.tpool].add_block(self.composition,self.name)



        def phy_delete(self):
                if(self.active):
                        CM.ConfigManager[self.composition].thread_pools[self.tpool].remove_block(self.composition,self.name)
                
                for (gname, neigh) in self.outgates.items():
                        for n in neigh:
                                blockmon.delete_link(self.composition,self.name,gname,n[0],n[1],n[2])

                for (gname, neigh) in self.ingates.items():
                        for n in neigh:
                                blockmon.delete_link( n[0],n[1],n[2],self.composition,self.name,gname)
                
                blockmon.delete_block(self.composition,self.name)


        def phy_restore(self):
                blockmon.create_block(self.composition,self.name,self.btype,self.ts,self.active,self.params)
                if(self.active):
                        CM.ConfigManager[self.composition].thread_pools[self.tpool].add_block(self.composition,self.name)
                for (gname, neigh) in self.outgates.items():
                        for n in neigh:
                                blockmon.create_link(self.composition,self.name,gname,n[0],n[1],n[2])

                for (gname, neigh) in self.ingates.items():
                        for n in neigh:
                                blockmon.create_link( n[0],n[1],n[2],self.composition,self.name,gname)
        
        def add_connection(self,mygate,otherblock,othergate,direction):
                d=self.ingates if (direction=='in') else self.outgates
                if(mygate not in d):d[mygate]=[]
                d[mygate].append((otherblock.composition,otherblock.name,othergate))

        def remove_connection(self,mygate,otherblock,othergate,direction):
                d=self.ingates if (mygate in self.ingates.keys()) else self.outgates
                d[mygate].remove((otherblock.composition,otherblock.name,othergate))

        def add_gate(self,name,direction):
                d=self.ingates if (direction=='in') else self.outgates
                if(name not in d):
                        d[name]=[]

        def remove_gate(self,name,direction):
                d=self.ingates if (direction=='in') else self.outgates
                del d[name]


        def update(self,ts,active,params,tpool):
                self.params=params
                self.ts=ts
                self.active=active
                if(active and (tpool!=self.tpool)):
                        CM.ConfigManager[self.composition].thread_pools[self.tpool].add_block(self.composition,self.name)
                        self.tpool=tpool
                        CM.ConfigManager[self.composition].thread_pools[self.tpool].remove_block(self.composition,self.name)
                
                if(blockmon.update_block(self.composition,self.name,self.ts,self.active,self.params)<0):
                        print 'warning: cannot reconfigure block ' +self.composition+':'+ self.name +' deleting and rebulding'
                        self.phy_delete()
                        self.phy_restore()

        def remove(self):
                self.phy_delete()
                for (mygate,neighbors) in self.ingates.items():
                        for other in neighbors:
                                CM.ConfigManager[other[0]].blocks[other[1]].remove_connection(other[2],self,mygate,'out')

                for (mygate,neighbors) in self.outgates.items():
                        for other in neighbors:
                                CM.ConfigManager[other[0]].blocks[other[1]].remove_connection(other[2],self,mygate,'in')

        def read_var(self,varname):
                ret=blockmon.read_block_variable(self.composition,self.name,varname)
                if(len(ret)==0):
                        print 'warning: read is not supported'
                return ret

        def write_var(self,varname,val):
                ret=blockmon.write_block_variable(self.composition,self.name,varname,val)
                if(ret==-1):
                        print 'warning: write is not supported'

        @staticmethod
        def connect_blocks(b1,g1,b2,g2):
                blockmon.create_link(b1.composition,b1.name,g1,b2.composition,b2.name,g2)
                b1.add_connection(g1,b2,g2,'out')
                b2.add_connection(g2,b1,g1,'in')

        @staticmethod
        def disconnect_blocks(b1,g1,b2,g2):
                blockmon.delete_link(b1.composition,b1.name,g1,b2.composition,b2.name,g2)
                b1.remove_connection(g1,b2,g2,'out')
                b2.remove_connection(g2,b1,g1,'in')





class Composition:
        def __init__(self,name):
                self.name=str(name)
                self.blocks={}
                self.ingates={}
                self.outgates={}
                self.thread_pools={}
                blockmon.add_config(self.name)

        def install(self,xmlnode):

                for n in xmlnode.getElementsByTagName("threadpool"):
                        self.create_pool(n)

                for n in xmlnode.getElementsByTagName("block"):
                        self.create_block(n)
                
                for n in xmlnode.getElementsByTagName("connection"):
                        self.create_link(n)

                for n in xmlnode.getElementsByTagName("ext_gate"):
                        self.expose_gate(n)
                
                for n in xmlnode.getElementsByTagName("ext_connection"):
                        self.inter_link(n,'add')

                print self.name + ' :installed'


        def reconfigure(self,xmlnodes):
                for xmlnode in xmlnodes.getElementsByTagName("delete"):

                        
                        for n in xmlnode.getElementsByTagName("connection"):
                                self.delete_link(n)
                        
                        for n in xmlnode.getElementsByTagName("ext_connection"):
                                self.inter_link(n,'delete')

                        for n in xmlnode.getElementsByTagName("ext_gate"):
                                extname= str(n.attributes['ext_name'].value)
                                self.delete_exposed_gate(extname)
                        
                        for n in xmlnode.getElementsByTagName("block"):
                                self.delete_block(n)
                        for n in xmlnode.getElementsByTagName("threadpool"):
                                self.delete_pool(n)
                
                for xmlnode in xmlnodes.getElementsByTagName("add"):

                        for n in xmlnode.getElementsByTagName("block"):
                                self.create_block(n)
                        for n in xmlnode.getElementsByTagName("ext_gate"):
                                self.expose_gate(n)
                        
                        for n in xmlnode.getElementsByTagName("connection"):
                                self.create_link(n)
                        
                        for n in xmlnode.getElementsByTagName("ext_connection"):
                                self.inter_link(n,'add')

                        
                        for n in xmlnode.getElementsByTagName("threadpool"):
                                self.create_pool(n)
                                


                for xmlnode in xmlnodes.getElementsByTagName("reconf"):

                        for n in xmlnode.getElementsByTagName("block"):
                                self.update_block(n)

                        for n in xmlnode.getElementsByTagName("ext_gate"):
                                self.update_exposed_gate(n)
                print 'update done'

        def update_block(self,blocknode):
                bname=blocknode.attributes['id'].value
                ts=False
                active=False
                tpool=''
                if blocknode.attributes.has_key('sched_type'):
                        active=True if (blocknode.attributes['sched_type'].value=='active') else False
                        tpool=blocknode.attributes['threadpool'].value

                if blocknode.attributes.has_key('thread_safe'):
                        ts=True if (blocknode.attributes['thread_safe'].value=='off') else False
                
                params=blocknode.getElementsByTagName('params')
                params=str(params[0].toxml())
                self.blocks[bname].update(ts,active,params,tpool)

                

        def update_exposed_gate(self,exposenode):
                block=str(exposenode.attributes['block'].value)
                locname=str(exposenode.attributes['gate'].value)
                extname=str(exposenode.attributes['ext_name'].value)
                direction=exposenode.attributes['direction'].value
                d=self.ingates if(direction=='in') else self.outgates
                oldpeers=d[extname][1]
                if( d[extname][0][1] in self.blocks): 
                        self.delete_exposed_gate(extname)
                else:
                        del d[extname]
                self.expose_gate(exposenode)
                for p in oldpeers:
                        if(direction=='in'):
                                self.add_inter_link(p[0],p[1],self.name,extname)
                        elif(direction=='out'):
                                self.add_inter_link(self.name,extname,p[0],p[1])


        def create_pool(self,poolnode):
                self.thread_pools[poolnode.attributes['id'].value]=ThreadPool(poolnode)
                
        def delete_pool(self,poolnode):
                del self.thread_pools[poolnode.attributes['id'].value]
        
        def delete_block(self,blocknode):
                bname=blocknode.attributes['id'].value
                self.blocks[bname].remove()
                del self.blocks[bname]

        def create_block(self,blocknode):
                bname=blocknode.attributes['id'].value
                btype=blocknode.attributes['type'].value
                ts=False
                active=False
                tpool=''
                if blocknode.attributes.has_key('sched_type'):
                        active=True if (blocknode.attributes['sched_type'].value=='active') else False
                        tpool=blocknode.attributes['threadpool'].value

                if blocknode.attributes.has_key('thread_safe'):
                        ts=True if (blocknode.attributes['thread_safe'].value=='off') else False
                params=blocknode.getElementsByTagName('params')
                params=params[0].toxml()
                self.blocks[bname]=Block(bname,btype,self.name,ts,active,params,tpool)
                

        def create_link(self,linknode):
                bsource=str(linknode.attributes['src_block'].value)
                gsource=str(linknode.attributes['src_gate'].value)
                bdst=str(linknode.attributes['dst_block'].value)
                gdst=str(linknode.attributes['dst_gate'].value)
                Block.connect_blocks(self.blocks[bsource],gsource,self.blocks[bdst],gdst)
                        
        def delete_link(self,linknode):
                bsource=str(linknode.attributes['src_block'].value)
                gsource=str(linknode.attributes['src_gate'].value)
                bdst=str(linknode.attributes['dst_block'].value)
                gdst=str(linknode.attributes['dst_gate'].value)
                Block.disconnect_blocks(self.blocks[bsource],gsource,self.blocks[bdst],gdst)
        
        
        def expose_gate(self,exposenode):
                block=str(exposenode.attributes['block'].value)
                locname=str(exposenode.attributes['gate'].value)
                extname=str(exposenode.attributes['ext_name'].value)
                direction=exposenode.attributes['direction'].value
                d=self.ingates if (direction=='in') else self.outgates
                d[extname]=((block,locname),[])
                self.blocks[block].add_gate(locname,direction)
        
        def delete_exposed_gate(self,extname):
                if extname in self.ingates:
                        for todel in self.ingates[extname][1]:
                                self.delete_inter_link(todel[0],todel[1],self.name,extname)
                        del self.ingates[extname]
                elif extname in self.outgates:
                        for todel in self.outgates[extname][1]:
                                self.delete_inter_link(self.name,extname,todel[0],todel[1])
                        del self.outgates[extname]

        def read_block_var(self,blockname,varname):
                return self.blocks[blockname].read_var(varname)


        def write_block_var(self,blockname,varname,val):
                self.blocks[blockname].write_var(varname,val)
                



        def remove(self):
                for i in self.blocks.values():
                        i.remove()
                blockmon.delete_config(self.name)
                                     
        @staticmethod
        def add_inter_link(src_conf,src_gate,dst_conf,dst_gate):
                def find_actual(config,name,direction):
                        if (direction=='dst'): return CM.ConfigManager[config].ingates[name][0]
                        elif (direction=='src'): return CM.ConfigManager[config].outgates[name][0]
                (bs,gs)=find_actual(src_conf,src_gate,'src')
                (bd,gd)=find_actual(dst_conf,dst_gate,'dst')
                Block.connect_blocks(CM.ConfigManager[src_conf].blocks[bs],gs,CM.ConfigManager[dst_conf].blocks[bd],gd)
                CM.ConfigManager[src_conf].outgates[src_gate][1].append((dst_conf,dst_gate))
                CM.ConfigManager[dst_conf].ingates[dst_gate][1].append((src_conf,src_gate))

        @staticmethod
        def delete_inter_link(src_conf,src_gate,dst_conf,dst_gate):
                def find_actual(config,name,direction):
                        if (direction=='dst'): return CM.ConfigManager[config].ingates[name][0]
                        elif (direction=='src'): return CM.ConfigManager[config].outgates[name][0]
                (bs,gs)=find_actual(src_conf,src_gate,'src')
                (bd,gd)=find_actual(dst_conf,dst_gate,'dst')
                Block.disconnect_blocks(CM.ConfigManager[src_conf].blocks[bs],gs,CM.ConfigManager[dst_conf].blocks[bd],gd)
                CM.ConfigManager[src_conf].outgates[src_gate][1].remove((dst_conf,dst_gate))
                CM.ConfigManager[dst_conf].ingates[dst_gate][1].remove((src_conf,src_gate))


        @staticmethod
        def inter_link(elinknode,action):
                cs=str(elinknode.attributes['src_composition'].value)
                cd=str(elinknode.attributes['dst_composition'].value)
                gs=str(elinknode.attributes['src_gate'].value)
                gd=str(elinknode.attributes['dst_gate'].value)
                if(action=='add'):
                        Composition.add_inter_link(cs,gs,cd,gd)
                elif(action=='delete'):
                        Composition.delete_inter_link(cs,gs,cd,gd)
                else:
                        raise Exception('value not allowed')




class BM:
        running=False

        @staticmethod
        def start(): 
                if (BM.running):
                        raise Exception('blockmon already running')
                else:
                        BM.running=True
                blockmon.start_schedulers()
                blockmon.start_timer()

        @staticmethod
        def stop():
                if (BM.running):
                        blockmon.stop_schedulers()
                        blockmon.stop_timer()
                BM.running=False


import sys
import time


class systemvars:
        instances={}



def install(filename):
        dom = xml.dom.minidom.parse(filename)
        for c in dom.getElementsByTagName('composition'):
                cname= c.attributes['id'].value
                for inst in  dom.getElementsByTagName('install'):
                        print 'installing composition '+cname
                        CM.ConfigManager[cname]=Composition(cname)
                        CM.ConfigManager[cname].install(inst)

def update(filename):
        dom = xml.dom.minidom.parse(filename)
        for c in dom.getElementsByTagName('composition'):
                cname= c.attributes['id'].value
                for inst in  dom.getElementsByTagName('update'):
                        print 'updating composition '+cname
                        CM.ConfigManager[cname].reconfigure(inst)


cmd=None
args=[]

import os

for plug in os.listdir('./pluginrw'):
        if(plug.split('.')[1]!='py'):
                continue
        modname='./pluginrw/'+plug
        plugmod=imp.load_source('module.name',modname)
        systemvars.instances[plugmod.name]=(plugmod.readfunc,plugmod.writefunc)


while (1):

        if(cmd is None):
                cmd='install'
                for c in sys.argv[1:]:
                        args.append(c)
                if (len(args)==0): continue
        else:
                inp=raw_input('BM shell :')
                cmds=inp.split()
                cmd=cmds[0]
                if(len(cmds)>1):
                        args=cmds[1:]
        
        if(cmd=='exit'):
                if(BM.running): BM.stop
                break
        elif(cmd=='install'):
                if(BM.running):
                        print 'stop blockmon first'
                else:
                        for a in args:
                                install(a)
        elif(cmd=='start'):
                BM.start()

        elif(cmd=='stop'):
                BM.stop()
        elif(cmd=='update'):
                BM.stop()
                for a in args:
                        update(a)
                #BM.start()
        elif(cmd=='read'):
                try:
                        if(len(args)==3):
                                if (args[0]=='system'):
                                        print systemvars.instances[args[1]][0](CM.ConfigManager,args[2])
                                else:
                                        print CM.ConfigManager[args[0]].read_block_var(args[1], args[2])
                        else:
                                print 'wrong number of args'
                except:
                        print 'wrong args'

        elif(cmd=='write'):
                try:
                        if(len(args)==4):
                                if (args[0]=='system'):
                                        systemvars.instances[args[1]][1](CM.ConfigManager,args[2],args[3])
                                else:
                                        CM.ConfigManager[args[0]].write_block_var(args[1], args[2],args[3])
                        else:
                                print 'wrong number of args'
                except:
                        print 'wrong args'
        elif(cmd=='varlist'):
                varlist=blockmon.list_variables(args[0],args[1])
                varlist=varlist.split(';')
                for v in varlist:
                        if(len(v)==0): continue
                        tokens=v.split(',')
                        name = tokens[0]
                        read='read' in tokens
                        write='write' in tokens
                        print 'name: ' + name + ' write: ' + str(write) + ' read: '+ str(read)

        else:
                print cmd + ': command unknown'






for d in CM.ConfigManager.keys():
        CM.ConfigManager[d].remove()

                

                









                

