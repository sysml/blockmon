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

class ReturnValue(object):
    """\brief Container for a return value for a daemon task or command. If the
              the code is set to 0 the operation succeeded and the return value is
              available. Any other code indicates an error.
              [NOTE: we need to define other values, ala HTTP]
    """
    CODE_SUCCESS = 0
    CODE_FAILURE = -1
    SIMPLE_STR_VARS = ["code", "msg", "value"]

    def __init__(self, code=None, msg=None, value=None):
        """\brief Initializes class
        \param code  (\c int)    The numeric code
        \param msg   (\c string) The message, useful in case of error
        \param value (\c void)   The actual return value
        """
        self.__code = code
        self.__msg = msg
        self.__value = value

    def get_code(self):
        """\brief Retrieves the numeric code
        \return (\c int) The numeric code
        """
        return self.__code

    def get_msg(self):
        """\brief Retrieves the message
        \return (\c string) The message
        """
        return self.__msg

    def get_value(self):
        """\brief Retrieves the actual return value
        \return (\c void) The actual return value
        """
        return self.__value

    def __str__(self):
        string = str(self.__class__.__name__) + ": "
        for str_var in self.SIMPLE_STR_VARS:
            string += str_var + "=" + str(eval('self.get_' + str_var)()) + ","
        string = string[:len(string) - 1]
        return string
