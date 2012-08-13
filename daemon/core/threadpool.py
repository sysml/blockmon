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

class ThreadPool:

    """\brief Container class for a thread pool
    """
    
    def __init__(self, poolnode, blockmon):
        """\brief Initializes class, adding a thread pool to the blockmon executable.
        \param poolnode (\c Node)   An xml node list representing the thread pool info
        \param blockmon (\c module) The module for the blockmon executable
        """
        self.blocks = []
        self.__blockmon = blockmon
        self.name = str(poolnode.attributes['id'].value)
        self.nthreads = poolnode.attributes['num_threads'].value
        self.__blockmon.add_thread_pool(str(poolnode.toxml()))

    def add_block(self, comp_id, name):
        """\brief Adds a block to the thread pool
        \param comp_id (\c string) The composition id
        \param name    (\c string) The block's name
        """
        self.blocks.append((comp_id, name))
        self.__blockmon.add_block_to_thread_pool(comp_id, name, self.name)

    def remove_block(self, comp_id, name):
        """\brief Removes a block from the thread pool
        \param comp_id (\c string) The composition id
        \param name    (\c string) The block's name
        """
        self.blocks.remove((comp_id, name))
        self.__blockmon.remove_block_from_thread_pool(comp_id, name, self.name)

    def __del__(self):
        """\brief Removes itself from the blockmon executable
        """
        if(len(self.blocks) > 0):
            raise Exception('removing thread pool having assigned tasks')
        self.__blockmon.remove_thread_pool(self.name)
