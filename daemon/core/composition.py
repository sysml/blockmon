# Copyright (c) 2011, NEC Europe Ltd, Consorzio Nazionale 
# Interuniversitario per le Telecomunicazioni, Institut 
# Telecom/Telecom Bretagne, ETH Zuerich, INVEA-TECH a.s. All rights reserved.
#
# Redistribution and use in source and binary forms, with or without 
# modification, are permitted provided that the following conditions are met:
#    * Redistributions of source code must retain the above copyright
#      notice, this list of conditions and the following disclaimer.
#    * Redistributions in binary form must reproduce the above copyright
#      notice, this list of conditions and the following disclaimer in the
#      documentation and/or other materials provided with the distribution.
#    * Neither the names of NEC Europe Ltd, Consorzio Nazionale 
#      Interuniversitario per le Telecomunicazioni, Institut Telecom/Telecom 
#      Bretagne, ETH Zuerich, INVEA-TECH a.s. nor the names of its contributors 
#      may be used to endorse or promote products derived from this software 
#      without specific prior written permission.
# 
# THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS 
# "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT 
# LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR 
# A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL <COPYRIGHT 
# HOLDERBE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, 
# EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, 
# PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR 
# PROFITS; OR BUSINESS
# INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER 
# IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR 
# OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF 
# ADVISED OF THE POSSIBILITY OF SUCH DAMAGE
#

import os

from threadpool import ThreadPool
from block import Block, Connection
from blockinfo import block_infos
from core.returnvalue import *
from symbol import except_clause

class CompositionManager:

    """\brief Manages a blockmon composition
    """

    def __init__(self, comp_id, blockmon, bm_logger):
        """\brief Initializes class
        \param comp_id   (\c string)         The composition id
        \param blockmon  (\c module)         The blockmon executable module
        \param bm_logger (\c logging.logger) The logger
        """
        self.__logger = bm_logger
        self.__comp_id = str(comp_id)
        self.__blocks = {}         # dict block id -> Block
        self.__thread_pools = {}   # dict pool id  -> ThreadPool
        self.__blockmon = blockmon
        self.__blockmon.add_composition(self.__comp_id)

    def install(self, xmlnode):
        """\brief Installs a blockmon composition
        \param xmlnode (\c xml.dom.Node) The blockmon composition
        """
        
        generalXML = xmlnode.getElementsByTagName("general")
        if not generalXML:
            print "error, composition has no 'general' tag"
            os._exit(1)
        self.__process_general(generalXML[0])
            
        for n in xmlnode.getElementsByTagName("threadpool"):
            self.__create_pool(n)

        for n in xmlnode.getElementsByTagName("block"):
            self.__create_block(n)

        for n in xmlnode.getElementsByTagName("connection"):
            self.__create_connection(n)

        self.__blockmon.init_composition(self.__comp_id)
        
        self.__logger.info(self.__comp_id + ' : installed')
           
    def reconfigure(self, xmlnodes):
        """\brief Reconfigures a blockmon composition
        \param xmlnodes (\c xml.dom.Node) The blockmon composition
        """
        for xmlnode in xmlnodes.getElementsByTagName("delete"):
            for n in xmlnode.getElementsByTagName("connection"):
                self.__delete_connection(n)

            for n in xmlnode.getElementsByTagName("block"):
                self.__delete_block(n)

            for n in xmlnode.getElementsByTagName("threadpool"):
                self.__delete_pool(n)

        for xmlnode in xmlnodes.getElementsByTagName("add"):
            for n in xmlnode.getElementsByTagName("threadpool"):
                self.__create_pool(n)

            for n in xmlnode.getElementsByTagName("block"):
                self.__create_block(n)

            for n in xmlnode.getElementsByTagName("connection"):
                self.__create_connection(n)

        for xmlnode in xmlnodes.getElementsByTagName("reconf"):
            
            for n in xmlnode.getElementsByTagName("block"):
                self.__update_block(n)

        self.__logger.info(self.__comp_id + ' : updated')

    def remove(self):
        """\brief Removes the currently installed blockmon composition
        """
        for i in self.__blocks.values():
            i.remove()

        for t in self.__thread_pools.values():
            self.__blockmon.remove_thread_pool(t.name)

        self.__blockmon.delete_composition(self.__comp_id)

    def read_block_var(self, var_info):
        """\brief Reads a block variable's value
        \param var_info  (\c VariableInfo) The variable to read
        \return         (\c ReturnValue)  The result of the operation
        """
        blockname = var_info.get_block_name()
        varname = var_info.get_name()
        if not self.__blocks.has_key(blockname):
            return ReturnValue(ReturnValue.CODE_FAILURE, "block id " + blockname + " does not exist", None)
        block = self.__blocks[blockname]
#        if not block_infos.has_key(block.block_type):
#            return ReturnValue(ReturnValue.CODE_FAILURE, "no block of type "+block.block_type+" exists", None)
#        if not block_infos[block.block_type].has_variable(varname, "read"):
#            return ReturnValue(ReturnValue.CODE_FAILURE, "block has no read variable " + varname, None)
        try:
            value = block.read_var(varname)
        except RuntimeError, e:
            return ReturnValue(ReturnValue.CODE_FAILURE, "An exception occurred: '" + str(e)+"'", None)
        
        var_info.set_value(value)
        return ReturnValue(ReturnValue.CODE_SUCCESS, "", var_info)

    def write_block_var(self, var_info):
        """\brief Writes a value to a block variable
        \param var_info  (\c VariableInfo) The variable to write to
        \return         (\c ReturnValue)  The result of the operation
        """
        blockname = var_info.get_block_name()
        varname = var_info.get_name()
        value = var_info.get_value()
        if not self.__blocks.has_key(blockname):
            return ReturnValue(ReturnValue.CODE_FAILURE, "block id " + blockname + " does not exist", None)
        block = self.__blocks[blockname]
#        if not block_infos.has_key(block.block_type):
#            return ReturnValue(ReturnValue.CODE_FAILURE, "no block of that type exists", None)
#        if not block_infos[block.block_type].has_variable(varname, "write"):
#            return ReturnValue(ReturnValue.CODE_FAILURE, "block has no write variable " + varname, None)
        try:
            if self.__blocks[blockname].write_var(varname, value):
                return ReturnValue(ReturnValue.CODE_SUCCESS, "", None)
        except RuntimeError, e:
            return ReturnValue(ReturnValue.CODE_FAILURE, "An exception occurred: '" + str(e)+"'", None)
        
        return ReturnValue(ReturnValue.CODE_FAILURE, "error while writing to variable", None)

    def __process_general(self, xmlnode):
        """\brief Processes parameters under the 'general' tag
        \param xmlnode (\c xml.dom.Node) The XML for the general tag
        """
        clockXML = xmlnode.getElementsByTagName("clock")        
        clock_type = "WALL"
        if (clockXML and len(clockXML) > 0):
            clock_type = clockXML[0].attributes['type'].value
        self.__select_clock(str(clock_type))
        
    def __select_clock(self, clock_type):
        """\brief Sets the clock type (PACKET or WALL, case insensitive)
        \param clock_type (\c string)      The clock type
        \return           (\c ReturnValue) The result of the operation
        """
        clock_type = clock_type.upper()
        if clock_type == "WALL" or clock_type == "PACKET":
            self.__blockmon.select_clock(clock_type)
            return ReturnValue(ReturnValue.CODE_SUCCESS, "", None)
        return ReturnValue(ReturnValue.CODE_FAILURE, "invalid value for clock type", None)
    
    def __create_block(self, blocknode):
        """\brief Creates a block
        \param blocknode (\c xml.dom.Node) The block in xml form
        """
        block_name = blocknode.attributes['id'].value
        block_type = blocknode.attributes['type'].value
        
        invocation = "direct"
        tpool_id = ""
        tpool = None
                
#        params = blocknode.getElementsByTagName('params')
        #params = params[0].toxml()
        
        if blocknode.attributes.has_key('invocation'):
            invocation = blocknode.attributes['invocation'].value

        if invocation == "indirect" or invocation == "async":
            tpool_id = blocknode.attributes['threadpool'].value
            tpool = self.__thread_pools[str(tpool_id)]
        
        self.__blocks[block_name] = Block(block_name,\
                                          block_type,\
                                          self.__comp_id,\
                                          invocation,\
                                          blocknode.toxml(),\
                                          tpool_id,\
                                          tpool,\
                                          self.__blockmon,\
                                          self.__logger)

    def __delete_block(self, blocknode):
        """\brief Deletes a block
        \param blocknode (\c xml.dom.Node) The block in xml form
        """
        block_name = blocknode.attributes['id'].value
        self.__blocks[block_name].remove()
        del self.__blocks[block_name]

    def __update_block(self, blocknode):
        """\brief Updates a block
        \param blocknode (\c xml.dom.Node) The block in xml form
        """
        block_name = blocknode.attributes['id'].value
        
        params = blocknode.getElementsByTagName('params')
        params = str(params[0].toxml())
        
        invocation = "direct"
        tpool_id = ""
        tpool = None
        #active = False
 
        if blocknode.attributes.has_key('invocation'):
            invocation = blocknode.attributes['invocation'].value
        
        if invocation == "indirect" or invocation == "async":
            tpool_id = blocknode.attributes['threadpool'].value
            tpool = self.__thread_pools[str(tpool_id)]
            
        self.__blocks[block_name].update(invocation, params, tpool_id, tpool)
#        if blocknode.attributes.has_key('sched_type'):
#            active = True if (blocknode.attributes['sched_type'].value == 'active') else False
#            tpool_id = blocknode.attributes['threadpool'].value
#
#        if (active):
#            tpool = self.__thread_pools[str(tpool_id)]
#        self.__blocks[block_name].update(active, params, tpool_id, tpool)

    def __create_pool(self, poolnode):
        """\brief Creates a thread pool
        \param poolnode (\c xml.dom.Node) The thread pool in xml form
        """
        self.__thread_pools[poolnode.attributes['id'].value] = ThreadPool(poolnode,\
                                                                          self.__blockmon)
    def __delete_pool(self, poolnode):
        """\brief Deletes a thread pool
        \param poolnode (\c xml.dom.Node) The thread pool in xml form
        """
        del self.__thread_pools[poolnode.attributes['id'].value]

    def __create_connection(self, connection_node):
        """\brief Creates a connection between two blocks
        \param connection_node (\c xml.dom.Node) The connection in xml form
        """
        bsource = str(connection_node.attributes['src_block'].value)
        gsource = str(connection_node.attributes['src_gate'].value)
        bdst = str(connection_node.attributes['dst_block'].value)
        gdst = str(connection_node.attributes['dst_gate'].value)
        self.__connect_blocks(self.__blocks[bsource], gsource, self.__blocks[bdst], gdst)

    def __delete_connection(self, connection_node):
        """\brief Deletes a connection between two blocks
        \param connection_node (\c xml.dom.Node) The connection in xml form
        """
        bsource = str(connection_node.attributes['src_block'].value)
        gsource = str(connection_node.attributes['src_gate'].value)
        bdst = str(connection_node.attributes['dst_block'].value)
        gdst = str(connection_node.attributes['dst_gate'].value)
        self.__disconnect_blocks(self.__blocks[bsource], gsource, self.__blocks[bdst], gdst)

    def __connect_blocks(self, b1, g1, b2, g2):
        """\brief Connects two blocks
        \param b1  (\c Block)  The source block
        \param g1  (\c string) The source gate
        \param b2  (\c Block)  The destination block
        \param g2  (\c string) The destination gate
        """
        self.__blockmon.create_connection(b1.comp_id,\
                                          b1.name,\
                                          g1,\
                                          b2.comp_id,\
                                          b2.name,\
                                          g2)
        b1.add_connection(g1, b2, g2, 'out')
        b2.add_connection(g2, b1, g1, 'in')
        b1.connections.append(Connection(g1, b2, g2))
        b2.connections.append(Connection(g2, b1, g1))

    def __disconnect_blocks(self, b1, g1, b2, g2):
        """\brief Disconnects two blocks
        \param b1  (\c Block)  The source block
        \param g1  (\c string) The source gate
        \param b2  (\c Block)  The destination block
        \param g2  (\c string) The destination gate
        """
        self.__blockmon.delete_connection(b1.comp_id, \
                                          b1.name, \
                                          g1, \
                                          b2.comp_id, \
                                          b2.name, \
                                          g2)
        b1.remove_connection(g1, b2, g2, 'out')
        b2.remove_connection(g2, b1, g1, 'in')

    def get_blocks(self):
        return self.__blocks
