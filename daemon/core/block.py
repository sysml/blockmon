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

class BlockInfo(object):
    """\brief Container class for describing a block to the outside world.
    """

    def __init__(self, type, invocation, gates, params_schema, params_example,\
                 variables, human_desc, short_desc, thread_exclusive=False):
        """\brief Initializes class
        \param type             (\c string)             The block's type (e.g., PFQSource)
        \param invocation       (\c string)             indirect|direct|async|both (both=indirect|direct)
        \param gates            (\c list[GateInfo])     The block's gates
        \param params_schema    (\c string)             The block's parameters
        \param params_example   (\c string)             Example parameters XML
        \param variables        (\c list[VariableInfo]) The block's variables
        \param human_desc       (\c string)             A human-readable version of what the block does
        \param short_desc       (\c string)             One-line description of block
        \param thread_exclusive (\c bool)               Whether the block needs its own thread pool
        """
        self.__type = type
        self.__invocation = invocation
        self.__gates = gates
        self.__params_schema = params_schema
        self.__params_example = params_example
        self.__variables = variables
        self.__human_desc = human_desc
        self.__short_desc = short_desc
        self.__thread_exclusive = thread_exclusive

    def has_variable(self, var_name, access_type):
        for v in self.__variables:
            if v.get_name() == var_name and v.get_access_type() == access_type:
                return True
        return False

    def get_type(self):
        return self.__type

    def get_invocation(self):
        return self.__invocation

    def get_gates(self):
        return self.__gates

    def get_params_schema(self):
        return self.__params_schema

    def get_params_example(self):
        return self.__params_example

    def get_variables(self):
        return self.__variables

    def get_human_desc(self):
        return self.__human_desc

    def get_short_desc(self):
        return self.__short_desc

    def is_thread_exclusive(self):
        return self.__thread_exclusive

    def __str__(self):
        string = "BlockInfo: type=" + str(self.get_type()) + ", " + \
                            "invocation=" + str(self.get_invocation()) + ", " + \
                            "is_thread_exclusive=" + str(self.is_thread_exclusive())

        string += "\n"

        for gate in self.get_gates():
            string += "\n" + str(gate)

        string += "\n"

        for var in self.get_variables():
            string += "\n" + str(var)

        string += "\nHuman Description:\n" + str(self.get_human_desc()) + \
                  "\nShort Description:\n" + str(self.get_short_desc()) + \
                  "\nParams Example:\n" + str(self.get_params_example()) + \
                  "\nParams Schema:\n" + str(self.get_params_schema())
        
        return string

class GateInfo(object):
    """\brief Container class for describing a gate to the outside world
    """

    TYPE = ["input", "output"]

    def __init__(self, type, name, msg_type, multiplicity):
        """\brief Initializes class
        \param type         (\c GateInfo.TYPE) The gate's type (e.g., input)
        \param name         (\c string)        The gate's name (e.g., MyInputGate)
        \param msg_type     (\c string)        The gate's message type (e.g., Packet)
        \param multiplicity (\c IntegerRange)  Indicates configurable numbers of gates
        """
        self.__type = type
        self.__name = name
        self.__msg_type = msg_type
        self.__multiplicity = multiplicity

    def get_type(self):
        return self.__type

    def get_name(self):
        return self.__name

    def get_msg_type(self):
        return self.__msg_type

    def get_multiplicity(self):
        return self.__multiplicity

    def __str__(self):
        return "GateInfo: type=" + str(self.get_type()) + ", " + \
                         "name=" + str(self.get_name()) + ", " + \
                         "msg_type=" + str(self.get_msg_type()) + ", " + \
                         "multiplicity=" + str(self.get_multiplicity())


class VariableInfo(object):

    """\brief Container class for accessing block variables to/from the outside world
    """
    ACCESS_TYPE = ["read", "write"]

    def __init__(self, block_name, name, human_desc, access_type, value=None):
        """\brief Initializes class
        \param block_name  (\c string) The parent block (e.g., MyPFQSource)
        \param name        (\c string) The variable's name
        \param human_desc  (\c string) Verbal description of what the value contains
        \param access_type (\c VariableInfo.ACCESS_TYPE) Either read or write
        \param value       (\c void *) The variable's value
        """
        self.__block_name = block_name
        self.__name = name
        self.__type = type
        self.__access_type = access_type
        self.__value = value
        self.__human_desc = human_desc

    def get_block_name(self):
        return self.__block_name

    def get_name(self):
        return self.__name
    
    def get_human_desc(self):
        return self.__human_desc

    def get_access_type(self):
        return self.__access_type

    def get_value(self):
        return self.__value

    def set_value(self, v):
        self.__value = v

    def __str__(self):
        return "VariableInfo: block_name=" + str(self.get_block_name()) + ", " + \
                             "name=" + str(self.get_name()) + ", " + \
                             "human_desc=" + str(self.get_human_desc()) + ", " + \
                             "access_type=" + str(self.get_access_type()) + ", " + \
                             "value=" + str(self.get_value())


class IntegerRange(object):

    """\brief Simple container class for an integer range
    """

    def __init__(self, begin, end):
        """\brief Initializes class
        \param begin (\c int) The range's beginning
        \param end   (\c int) The range's end
        """
        self.__begin = begin
        self.__end = end

    def get_begin(self):
        return self.__begin

    def get_end(self):
        return self.__end

    def __str__(self):
        return "IntegerRange: " + str(self.get_begin()) + "-" + str(self.get_end())

class Connection:
    
    def __init__(self, src_gate, dst_block, dst_gate):
        self.src_gate = src_gate
        self.dst_block = dst_block
        self.dst_gate = dst_gate
        
    def __str__(self):
        return "src_gate=" + str(self.src_gate) + \
               ",dst_block=" + str(self.dst_block.name) + \
               ",dst_gate=" + str(self.dst_gate)
    

class Block:

    """\brief The main interface to block-related operations on the blockmon executable.
    """

    def __init__(self, name, block_type, comp_id, invocation, params,\
                       tpool_id, tpool, blockmon, bm_logger):
        """\brief Initializes class, creating a block in the blockmon executable.
        \param name       (\c string)         The block's name
        \param block_type (\c string)         The block's type
        \param comp_id    (\c string)         The composition id
        \param invocation (\c string)         Invocation type (direct, indirect, async)
        \param params     (\c xml.dom.Node)   The block's parameters
        \param tpool_id   (\c string)         The block's thread pool id if indirect or async
        \param tpool      (\c ThreadPool)     The block's thread pool if indirect or async
        \param bm_logger  (\c logging.logger) The bm logger
        """
        self.__logger = bm_logger
        self.name = str(name)
        self.block_type = str(block_type)
        self.invocation = invocation
        self.tpool_id = str(tpool_id)
        self.tpool = tpool
        self.comp_id = str(comp_id)
        self.connections = []
        self.params = str(params)
        self.ingates = {}
        self.outgates = {}
        self.connections = []
        self.blockmon = blockmon
        
        inv = self.blockmon.to_invoc_type("direct")
        if invocation == "indirect":
            inv = self.blockmon.to_invoc_type("indirect")
        elif invocation == "async":
            inv = self.blockmon.to_invoc_type("async")
        self.inv = inv   
        self.blockmon.create_block(self.comp_id, \
                                   self.name,\
                                   self.block_type, \
                                   inv,\
                                   self.params)

        if invocation == "indirect" or invocation == "async": 
            self.tpool.add_block(self.comp_id, self.name)
                    
    def update(self, invocation, params, tpool_id, tpool):
        """\brief Updates a block
        \param invocation (\c string)         Invocation type (direct, indirect, async)
        \param params     (\c xml.dom.Node)   The block's parameters
        \param tpool_id   (\c string)         The block's thread pool id if indirect or async
        \param tpool      (\c ThreadPool)     The block's thread pool if indirect or async
        """
        inv = self.blockmon.to_invoc_type("direct")
        if invocation == "indirect":
            inv = self.blockmon.to_invoc_type("indirect")
        elif invocation == "async":
            inv = self.blockmon.to_invoc_type("async")
                    
        self.params = params
        self.invocation = invocation
        self.inv = inv
        
        if ( (invocation == "indirect" or invocation == "async") and (tpool_id != self.tpool_id) ):
            self.tpool.add_block(self.comp_id, self.name)
            self.tpool_id = tpool_id
            self.tpool = tpool
            self.tpool.remove_block(self.comp_id, self.name) 
            
        if (not self.blockmon.update_block(self.comp_id,\
                                           self.name,\
                                           inv,\
                                           self.params)):

            self.__logger.info("warning: cannot reconfigure block " + \
                               self.comp_id + ":" + self.name + \
                               ", deleting and rebuilding")
            self.remove()
            self.restore() 
                              
    def remove(self):
        """\brief Deletes this block from a composition and its thread pool if indirect or async
        """
        if self.invocation == "indirect" or self.invocation == "async":
            self.tpool.remove_block(self.comp_id, self.name)
        self.blockmon.delete_block(self.comp_id, self.name)

    def restore(self):
        """\brief Re-creates the block and re-adds it to the thread pool if indirect or async.
                  This function also re-generates any connection that the Block had. This 
                  information is saved in self.connections during the creation of the original
                  connections (see CompositionManager::__connect_blocks).
        """    
        self.blockmon.create_block(self.comp_id,\
                                   self.name,\
                                   self.block_type,\
                                   self.inv,\
                                   self.params)

        # re-create connections               
        for c in self.connections:        
            self.blockmon.create_connection(self.comp_id,\
                                            self.name,\
                                            c.src_gate,\
                                            c.dst_block.comp_id,\
                                            c.dst_block.name,\
                                            c.dst_gate)
                
        if self.invocation == "indirect" or self.invocation == "async":
            self.tpool.add_block(self.comp_id, self.name)


    def add_connection(self, mygate, otherblock, othergate, direction):
        """\brief Creates a connection between blocks
        \param mygate     (\c string) The source gate
        \param otherblock (\c Block)  The destination block
        \param othergate  (\c string) The destination gate
        \param direction  (\c string) Either in or out
        """
        d = self.ingates if (direction == 'in') else self.outgates
        if (mygate not in d):
            d[mygate] = []
        d[mygate].append((otherblock.comp_id, otherblock.name, othergate))

    def remove_connection(self, mygate, otherblock, othergate, direction):
        """\brief Removes a connection between blocks
        \param mygate     (\c string) The source gate
        \param otherblock (\c Block)  The destination block
        \param othergate  (\c string) The destination gate
        \param direction  (\c string) Either in or out
        """
        d = self.ingates if (mygate in self.ingates.keys()) else self.outgates
        d[mygate].remove((otherblock.comp_id, otherblock.name, othergate))

    def read_var(self, varname):
        """\brief Reads a variable's value
        \param varname (\c string) The variable's name
        \return        (\c string) The variable's value
        """
        ret = self.blockmon.read_block_variable(self.comp_id, self.name, varname)
        if (len(ret) == 0):
            self.__logger.info("warning: read is not supported")
        return ret

    def write_var(self, varname, val):
        """\brief Writes to a variable
        \param varname (\c string) The variable's name
        \param val     (\c string) The value to write
        """
        return self.blockmon.write_block_variable(self.comp_id, self.name, str(varname), str(val))

    def list_vars(self):
        """\brief Returns the variable list of the block"""
        ret = self.blockmon.list_variables(self.comp_id, self.name)
        if (len(ret) == 0):
            self.__logger.info("warning: list_vars is not supported")
        return ret
