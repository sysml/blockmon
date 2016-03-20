#!/usr/bin/env python
#NOTE: must u+x this file for things to work with the bm daemon!!!!

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

import os, sys
BASE_PATH = reduce (lambda l,r: l + os.path.sep + r, os.path.dirname( os.path.realpath( __file__ ) ).split( os.path.sep )[:-1] )
sys.path.append(os.path.abspath(BASE_PATH +"/"))
import xml.dom.minidom
from SimpleXMLRPCServer import SimpleXMLRPCServer
from core.returnvalue import *
from bmparser import CompositionParser
from composition import CompositionManager
from bmlogging import setup_logging

import pickle

import imp

# load the c++ library (from backend_glue.cpp)
blockmon = imp.load_dynamic('blockmon','../libblockmonpy.so')

class BMProcessManager:

    """\brief Controls a running blockmon process. Note that this class/file can be
              used directly as an executable (the method used by the blockmon daemon
              to spawn blockmon processes) or by creating an instance of the class
              (the method used for the blockmon CLI). For the former, the manager runs
              an XML-RPC server which the blockmon daemon uses to communicate with it.
              Further note that all xml-rpc operations return a pickled ReturnValue object.
    """
    bm_running = False

    def __init__(self, comp=None, bm_logger=None, port=None, is_comp_str=False):
        """\brief Initializes class
        \param comp       (\c string)         The composition
        \param bm_logger  (\c logging.logger) The bm logger
        \param port       (\c string)         The port to run the xml-rpc server on
        \parm is_comp_str (\c bool)           Whether the composition or a file path
        """
        self.__composition = comp
        if comp and not is_comp_str:
            f = open(comp, "r")
            self.__composition = f.read()
            f.close()

        self.__logger = bm_logger
        self.__port = None
        if port:
            self.__port = int(port)
        self.__server = None

    def set_composition(self, comp):
        self.__composition = comp

    def set_logger(self, logger):
        self.__logger = logger

    def serve(self):
        """\brief Starts up a composition as well as the xml-rpc server
        """
        self.start_composition()
        self.__server = SimpleXMLRPCServer(("localhost", self.__port))
        self.__server.register_function(self.update_composition, "update_composition")
        self.__server.register_function(self.stop_composition, "stop_composition")
        self.__server.register_function(self.read_variable, "read_variable")
        self.__server.register_function(self.write_variable, "write_variable")
        self.__logger.info("Starting Blockmon process with pid=" + str(os.getpid()) +\
                           " and listening on localhost:" + str(self.__port))
        self.__server.serve_forever()

    def start_composition(self, comp=None):
        """\brief Starts up a composition
        \param comp (\c string)      The composition. If None self.__composition is used
        \return     (\c ReturnValue) The result of the operation
        """
        if comp:
            self.__composition = comp
        self.__parser = CompositionParser(self.__composition)
        self.__comp_id = self.__parser.parse_comp_id()
        self.__comp_mngr = CompositionManager(self.__comp_id, blockmon, self.__logger)
        self.__comp_mngr.install(xml.dom.minidom.parseString(self.__composition))
        self.start_bm()
        return ReturnValue(ReturnValue.CODE_SUCCESS, "", None)

    def update_composition(self, comp):
        """\brief Updates up a composition
        \param comp (\c string)      The composition
        \return     (\c ReturnValue) The result of the operation
        """
        self.stop_bm()
        self.__composition = comp
        self.__comp_mngr.reconfigure(xml.dom.minidom.parseString(comp))
        self.start_bm()
        r = ReturnValue(ReturnValue.CODE_SUCCESS, "", None)
        if self.__server:
            return pickle.dumps(r)
        return r

    def is_running(self):
        return self.bm_running

    def stop_composition(self):
        """\brief Stops the composition
        \return     (\c ReturnValue) The result of the operation
        """
        self.stop_bm()
        self.__comp_mngr.remove()
        r = ReturnValue(ReturnValue.CODE_SUCCESS, "", None)
        if self.__server:
            return pickle.dumps(r)
        return r

    def read_variable(self, variable):
        """\brief Reads a variable from a block
        \param variable (\c VariableInfo) The variable to read, pickled.
        \return         (\c ReturnValue) The result of the operation
        """
        if self.__server:
            variable = pickle.loads(variable)
        r = self.__comp_mngr.read_block_var(variable)
        if self.__server:
            return pickle.dumps(r)
        return r

    def select_clock(self, clock_type):
        """\brief Sets the clock type (PACKET or WALL, case insensitive)
        \param clock_type (\c string)      The clock type
        \return           (\c ReturnValue) The result of the operation
        """
        clock_type = clock_type.upper()
        if clock_type == "WALL" or clock_type == "PACKET":
            blockmon.select_clock(clock_type)
            return ReturnValue(ReturnValue.CODE_SUCCESS, "", None)
        return ReturnValue(ReturnValue.CODE_FAILURE, "invalid value for clock type", None)

    def write_variable(self, variable):
        """\brief Writes a value to a block variable
        \param variable (\c VariableInfo) The variable to write to, pickled.
        \return         (\c ReturnValue)  The result of the operation
        """
        if self.__server:
            variable = pickle.loads(variable)
        r = self.__comp_mngr.write_block_var(variable)
        if self.__server:
            return pickle.dumps(r)
        return r

    def get_blocks(self):
        return self.__comp_mngr.get_blocks()

    @staticmethod
    def start_bm():
        """\brief Starts all blockmon schedulers and timers
        """
        if (BMProcessManager.bm_running):
            raise Exception('blockmon already running')
        else:
            BMProcessManager.bm_running = True
        blockmon.start_schedulers()
        blockmon.start_timer()

    @staticmethod
    def stop_bm():
        """\brief Stops all blockmon schedulers and timers
        """
        if (BMProcessManager.bm_running):
            blockmon.stop_schedulers()
            blockmon.stop_timer()
        BMProcessManager.bm_running = False


class BMProcessInfo:

    """\brief Convenience class for storing information about a running blockmon process
    """

    def __init__(self, proc, comp, logfile, port=None):
        """\brief Initializes class
        \param proc    (\c subprocess.Popen) The process
        \param comp    (\c string)           The composition XML
        \param logfile (\c string)           The path to the process' log file
        \param port    (\c int)        The port the process' json-rpc server is running on
        """
        self.__proc = proc
        self.__comp = comp
        self.__logfile = logfile
        self.__port = port

    def get_pid(self):
        if not self.__proc:
            return None
        return self.__proc.pid

    def get_comp(self):
        return self.__comp

    def get_port(self):
        return self.__port

    def set_port(self, p):
        self.__port = p

    def get_logfile(self):
        return self.__logfile

    def get_proc(self):
        return self.__proc

    def __str__(self):
        return "BMProcessInfo: pid=" + str(self.get_pid()) + \
                              "port=" + str(self.get_port()) + \
                              "logfile=" + str(self.get_logfile()) + \
                              "\n\tcomposition:\n" + str(self.get_comp())



########################################################################
# MAIN EXECUTION
########################################################################
if __name__ == "__main__":
    if (len(sys.argv) < 3):
        os._exit(1)

    # Setup manager
    compfile = sys.argv[1]
    logfile = sys.argv[2]
    process_port = sys.argv[3]

    setup_logging(logfile)
    from bmlogging import bm_logger

    # Start server
    mngr = BMProcessManager(compfile, bm_logger, process_port)
    mngr.serve()
