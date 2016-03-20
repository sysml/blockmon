#!/usr/bin/env python

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

"""\brief Blockmon's CLI, run it with: sudo python cli.py. At the prompt type
          help for a list of commands.
"""
import os
import sys
from core.bmprocess import BMProcessManager
from core.returnvalue import *
from core.block import *
from core.bmlogging import setup_logging
setup_logging(os.getcwd() + "/cli.log")
from core.bmlogging import bm_logger
import re
import readline

COMMANDS = ['start', 'stop', 'update', 'read', 'write', 'help', 'exit', 'selectclock']
RE_SPACE = re.compile('.*\s+$', re.M)

class Completer(object):
    def _listdir(self, root):
        res = []
        for name in os.listdir(root):
            path = os.path.join(root, name)
            if os.path.isdir(path):
                name += os.sep
            res.append(name)
        return res

    def _complete_path(self, path=None):
        if not path:
            return self._listdir('.')
        dirname, rest = os.path.split(path)
        tmp = dirname if dirname else '.'
        res = [os.path.join(dirname, p)
                for p in self._listdir(tmp) if p.startswith(rest)]
        # more than one match, or single match which does not exist (typo)
        if len(res) > 1 or not os.path.exists(path):
            return res
        # resolved to a single directory, so return list of files below it
        if os.path.isdir(path):
            return [os.path.join(path, p) for p in self._listdir(path)]
        # exact file match terminates this completion
        return [path + ' ']

    def _complete_block_name(self, block_name=None):
        res = []
        if not block_name:
            return mngr.get_blocks().keys()

        for p in mngr.get_blocks().keys():
            if p.startswith(block_name):
               res.append(p + ' ')
        return res

    def _complete_var_name(self, n_args, var_name, block_name, read):
        res = []
        tmp = mngr.get_blocks()[block_name].list_vars().split(';')
        tmp.pop()
        for p in tmp:
            if p.endswith('read' if read else 'write') & p.startswith(var_name):
                res.append(p.split(',')[0] + ' ')
        return res

    def complete_update(self, args):
        if len(args) > 1:
            return
        if not args:
            return self._complete_path('.')
        # treat the last arg as a path and complete it
        return self._complete_path(args[-1])

    def complete_start(self, args):
        if len(args) > 1:
            return
        if not args:
            return self._complete_path('.')
        # treat the last arg as a path and complete it
        return self._complete_path(args[-1])

    def complete_read(self, args):
        if not args:
            return self._complete_block_name()
        elif len(args) < 2:
            return self._complete_block_name(args[-1])
        else:
            return self._complete_var_name(len(args), args[-1], args[0], 1)

    def complete_write(self, args):
        if not args:
            return self._complete_block_name()
        elif len(args) < 2:
            return self._complete_block_name(args[-1])
        elif len(args) < 3:
            return self._complete_var_name(len(args), args[-1], args[0], 0)
        else:
            return []

    def complete(self, text, state):
        buffer = readline.get_line_buffer()
        line = readline.get_line_buffer().split()
        # show all commands
        if not line:
            return [c + ' ' for c in COMMANDS][state]
        # account for last argument ending in a space
        if RE_SPACE.match(buffer):
            line.append('')
        # resolve command to the implementation function
        cmd = line[0].strip()
        if cmd in COMMANDS:
            impl = getattr(self, 'complete_%s' % cmd)
            args = line[1:]
            if args:
                return (impl(args) + [None])[state]
            return [cmd + ' '][state]
        results = [c + ' ' for c in COMMANDS if c.startswith(cmd)] + [None]
        return results[state]

comp = Completer()
readline.set_completer_delims(' \t\n;')
readline.parse_and_bind("tab: complete")
readline.set_completer(comp.complete)

cmd = None
args = []
mngr = BMProcessManager(bm_logger=bm_logger)
is_running = False
starting = True
while (1):
    if(starting):
        cmds = sys.argv[1:]
        starting = False
    else:
        inp = raw_input('BM shell:')
        cmds = inp.split()
    if len(cmds) < 1: continue
    cmd = cmds[0]
    if(len(cmds) > 1):
        args = cmds[1:]

    if(cmd == 'exit'):
        if is_running:
            print "stopping composition"
            r = mngr.stop_composition()
            if r.get_code() != ReturnValue.CODE_SUCCESS:
                print 'error while stopping: ' + str(r.get_msg())
        break

    elif(cmd == 'start'):
        if (mngr.is_running()):
            print 'uninstall blockmon first'
        else:
            try:
                f = open(args[0], "r")
                comp = f.read()
                f.close()
            except:
                print 'error while trying to open file'
                continue

            r = mngr.start_composition(comp)
            if r.get_code() == ReturnValue.CODE_SUCCESS:
                is_running = True
                print 'successfully started composition'
            else:
                print 'error while starting composition: ' + str(r.get_msg())

    elif(cmd == 'stop'):
        if not is_running:
            print 'no composition is running'
            continue
        print 'stopping composition'
        r = mngr.stop_composition()
        if r.get_code() == ReturnValue.CODE_SUCCESS:
            is_running = False
            print 'done.'
        else:
            print 'error while stopping: ' + str(r.get_msg())

    elif(cmd == 'update'):
        if not is_running:
            print 'no composition is running, cannot update'
            continue
        try:
            f = open(args[0], "r")
            comp = f.read()
            f.close()
        except:
            print 'error while trying to open file'
            continue
        r = mngr.update_composition(comp)
        if r.get_code() == ReturnValue.CODE_SUCCESS:
            print 'successfully updated ' + str(args[0])
        else:
            print 'error while updating ' + str(args[0])

    elif(cmd == 'read'):
        if not is_running:
            print 'no composition is running'
            continue

        if(len(args) > 1):
            block_name = args[0]
            var_names = args[1:]

            results = ""
            for var_name in var_names:
                r = mngr.read_variable(VariableInfo(block_name, var_name, "", "read"))
                results += var_name + ": "
                if r.get_code() == ReturnValue.CODE_SUCCESS:
                    results += r.get_value().get_value()
                else:
                    results += r.get_msg()
                results += "\n"
            print results
        else:
                print 'wrong number of args'

    elif(cmd == 'write'):
        if not is_running:
            print 'no composition is running'
            continue
        if(len(args) == 3):
            block_name = args[0]
            var_name = args[1]
            var_value = args[2]
            var_info = VariableInfo(block_name, var_name, None, "write", var_value)
            r = mngr.write_variable(var_info)
            if r.get_code() == ReturnValue.CODE_SUCCESS:
                print "successfully wrote to variable " + var_name
            else:
                print "error: " + r.get_msg()
        else:
                print 'wrong number of args'
    elif (cmd == 'selectclock'):
        #if not is_running:
        #    print 'no composition is running'
        #    continue
        if(len(args) > 0):
            clock_type = args[0]
            r = mngr.select_clock(clock_type)
            if r.get_code() == ReturnValue.CODE_SUCCESS:
                print 'successfully set the clock to ' + str(clock_type)
            else:
                print 'error while setting the clock to ' + str(clock_type)
        else:
            print 'wrong number of args'

    elif (cmd == 'help'):
        print "usage: commands [arguments]\n"
        print "start\t[path to composition]"
        print "update\t[path to composition]"
        print "read\t[blockname] [varname1] [varname2]..."
        print "write\t[blockname] [varname] [varvalue]"
        print "stop"
        print "exit\n"

    else:
        print cmd + ': command unknown'
