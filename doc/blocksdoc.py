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
import sys
import commands

class BlocksdocGenerator:

    """\brief Generates HTML-based documentation for blockmon blocks. The
              information about blocks is assumed to be in:
              
              daemon/core/blockinfo.py 

              If the file does not exist and you have access to the block's
              source files, you can generate the file by running:

              python core/blockinfoparser.py config
              
              To see the documentation open:

              doc/blocks/index.html              
    """

    def __init__(self, doc_dir, doc_home, block_infos):
        """\brief Initializes class
        \param doc_dir     (\c string)      Where the html files should reside
        \param doc_home    (\c string)      Which file to set as home page (index.html)
        \param block_infos (\c [BlockInfo]) The block info to generate html from
        """
        self.__doc_dir = doc_dir
        self.__doc_home = doc_home
        self.__block_infos = block_infos
        self.__title = "Blockmon Blocks Documentation"
        self.__html_hdr = '<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">\n<html lang="en">\n<head>\n\t<meta http-equiv="content-type" content="text/html; charset=utf-8">\n\t<link rel="stylesheet" type="text/css" href="../blocks.css" />\n\t<title>' + self.__title + '</title>\n</head>\n\n<body>\n\t<img width="50%" src="../blockmonlogo.png"><br><br>\n\n\n'

    def generate_docs(self):
        """\brief Generate HTML files for the blocks' documentation
        """
        (status, output) = commands.getstatusoutput("mkdir -p " + self.__doc_dir)
        if status != 0:
            print "error while creating doc dir: " + output
            return

        index_str = self.__html_hdr + \
                    '\t<table class="reference">\n' + \
                    '\t\t<tr>\n' + \
                    '\t\t\t<th align="left" width="20%">Block Type</th>\n' + \
                    '\t\t\t<th align="left" width="80%">Short Description</th>\n' + \
                    '\t\t</tr>\n'

        for key in sorted(self.__block_infos.iterkeys()):
            block = self.__block_infos[key]
            blockref = block.get_type().lower() + ".html"
            index_str += '\t\t<tr>\n' + \
                         '\t\t\t<td><a href="' + blockref + '">' + str(block.get_type()) + '</a></td>\n' + \
                         '\t\t\t<td>' + str(block.get_short_desc()) + '</td>\n' + \
                         '\t\t<tr>\n'
            self.__generate_blockpage(block)

        index_str += '\n\t<table>\n</body>\n</html>\n'

        f = open(self.__doc_home, "w")
        f.write(index_str)
        f.close()

        print "created blocks documentation under " + self.__doc_home

    def __remove_xml_tags(self, string, tags):
        new_string = string
        for tag in tags:
            new_string = new_string.replace("<" + tag + ">", "").replace("</" + tag + ">", "")
        return new_string

    def __generate_blockpage(self, block):
        """\brief Generates an HTML documentation page for the given block
        \param block (\c BlockInfo) The block information
        """
        blockref = block.get_type().lower() + ".html"
        hd = block.get_human_desc()
        
        pe = block.get_params_example()
        pe = self.__remove_xml_tags(pe, ["paramsexample", "params"])
        pe = self.__escape_html(pe).replace('\n', '<br>')

        ps = block.get_params_schema()
        ps = self.__remove_xml_tags(ps, ["paramsschema"])
        ps = self.__escape_html(ps).replace('\n', '<br>')

        gi = self.__generate_gates_info(block.get_gates())
        vi = self.__generate_variables_info(block.get_variables())
        st = '\t\t' + str(block.get_invocation())
        te = '\t\t' + str(block.is_thread_exclusive())
                                
        block_str = self.__html_hdr + \
                    self.__get_section_hdr(block.get_type()) + hd + \
                    self.__get_section_hdr("Parameters Schema") + ps + \
                    self.__get_section_hdr("Parameters Example") + pe
        if gi:
            block_str += self.__get_section_hdr("Gates") + gi

        block_str += self.__get_section_hdr("Variables") + vi + \
                     self.__get_section_hdr("Invocation") + st + \
                     self.__get_section_hdr("Thread Exclusive") + te

        block_str += '\n\t</body>\n</html>\n'
        f = open(self.__doc_dir + blockref, "w")
        f.write(block_str)
        f.close()

    def __generate_gates_info(self, gates):
        """\brief Generates a string representing gate information in HTML format
        \param gates (\c [GateInfo]) The gate information
        \return      (\c string)     The HTML documentation
        """
        if not gates:
            return

        info = ''
        for gate in gates:
            info += '\t\t<h2>gate: ' + gate.get_name() + '</h2>\n' + \
                    '\t\t<b>type: </b>' + gate.get_type() + '<br>\n' + \
                    '\t\t<b>message type: </b>' + gate.get_msg_type() + '<br>\n' + \
                    '\t\t<b>multiplicity: </b>' + str(gate.get_multiplicity()) + '<br><br>\n'
        return info

    def __generate_variables_info(self, variables):
        """\brief Generates a string representing variables information in HTML format
        \param variables (\c [VariableInfo]) The variables information
        \return          (\c string)         The HTML documentation
        """
        info = ''
        for var in variables:
            info += '\t\t<h2>variable: ' + var.get_name() + '</h2>\n' + \
                    '\t\t<b>description: </b>' + var.get_human_desc() + '<br>\n' + \
                    '\t\t<b>access type: </b>' + var.get_access_type() + '<br><br>\n'
                    
        return info

    def __get_section_hdr(self, title):
        """\brief Generates an HTML string for a header section and a line
        \param title (\c string) The section's title
        \return      (\c string) The HTML string
        """
        return '\n\t<h1>' + title + '</h1>\n\t<hr />\n'

    def __escape_html(self, string):
        """\brief Replaces "<" and ">" characters in the given string with 
                  "&lt;" and "&gt;"
        \param string (\c string) The string to replace from
        \return       (\c string) The string with the characters replaced
        """
        string = string.replace(">", "&gt;")
        return string.replace("<", "&lt;")


base_path = os.getcwd() + "/../"
doc_dir = base_path + "doc/blocks/"
doc_home = doc_dir + "index.html"
daemon_dir = base_path + "daemon/"

from core.blockinfo import block_infos
try:
    from core.blockinfo import block_infos
except:
    print "Error while retrieving block information. If the " \
          "file daemon/core/blockinfo.py does not exist, please " \
          "generate it with 'python core/blockinfoparser.py config'." \
          "Also, make sure that your PYTHONPATH is set to node/daemon."
    os._exit(1)

gen = BlocksdocGenerator(doc_dir, doc_home, block_infos)
gen.generate_docs()
