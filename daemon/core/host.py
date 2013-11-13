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

import xml.dom.minidom
import commands
import math

class HostSpecsManager:

    """\brief Retrieves hardware specs from the local host
    """

    def __init__(self):
        pass

    def get_host_specs(self):
        """\brief Parses lshw output for the local host and populates a 
                  HostSpecsInfo object with the information.
        \return   (\c HostSpecsInfo) The host's specs, or None if error
        """
        (status, output) = commands.getstatusoutput('lshw -xml 2>/dev/null')
        if (status):
            print "host::get_host_specs: error while running lshw"
            return None
        
        dom = self.__get_DOM(output, False)
        if (dom == None):
            print "host::get_host_specs: error while getting DOM object"
            return None

        nodes = dom.getElementsByTagName("node")
        n_cpus = 0
        cpu_type = None
        nics = []
        nic_macs = []
        for node in nodes:
            if node.hasAttributes():
                node_class = self.__get_text(node.attributes['class'].childNodes)
                if node_class == "network":
                    nic = self.__parse_lshw_nic(node)
                    if nic != None and nic.get_mac() not in nic_macs:
                        nics.append(nic)
                        nic_macs.append(nic.get_mac())

        cpu_type = self.__get_cpu_type()
        n_cpus = self.__get_n_cpus()
        cores_per_cpu = self.__get_cores_per_cpu()
        memory = self.__get_sys_memory()
        return HostSpecsInfo(nics, cpu_type, n_cpus, cores_per_cpu, memory)

    def __get_cpu_type(self):
        """\brief Gets the host's CPU type
        \return (\c string) The CPU type
        """
        (status, output) = commands.getstatusoutput('cat /proc/cpuinfo 2>/dev/null')
        if (status):
            print "host::__get_cores_per_cpu: error while getting cpuinfo"
            return None

        # e.g., model name: Intel(R) Core(TM)2 Duo CPU     T8300  @ 2.40GHz
        for line in output.splitlines():
            if line.find("model name") != -1:
                return line.split(":")[1].strip()

    def __get_n_cpus(self):
        """\brief Gets the number of CPUs on the host
        \return (\c int) The number of CPUs
        """
        cmd = 'cat /proc/cpuinfo | grep processor | wc -l'
        (status, output) = commands.getstatusoutput(cmd)
        if (status):
            print "host::__get_num_cores: error while getting cpuinfo"
            return None
        
        return int(output)

    def __get_cores_per_cpu(self):
        """\brief Gets the number of cores per cpu
        \return (\c int) The number of cores per cpu
        """
        (status, output) = commands.getstatusoutput('cat /proc/cpuinfo 2>/dev/null')
        if (status):
            print "host::__get_cores_per_cpu: error while getting cpuinfo"
            return None

        # e.g., cpu cores: 2
        for line in output.splitlines():
            if line.find("cpu cores") != -1:
                return int(line.split(":")[1].strip())

    def __get_sys_memory(self):
        """\brief Gets the total system memory in GB
        \return (\c int) The total system memory in GB
        """
        (status, output) = commands.getstatusoutput('cat /proc/meminfo 2>/dev/null')
        if (status):
            print "host::__get_cores_per_cpu: error while getting cpuinfo"
            return None

        # e.g., MemTotal:        2018656 kB
        for line in output.splitlines():
            if line.find("MemTotal") != -1:
                l = line.split(":")[1].strip()
                return int(math.ceil(float(l[:len(l) - 3]) / float(1048576)))

    def __parse_lshw_nic(self, node):
        """\brief Parses an xml node to see whether it is an interface. If
                  is, it returns an Interface object, otherwise None is returned
        \param node (\c minidom.Node) The xml node
        \return     (\c Interface)    The parsed interface, or None if the node was not an interface
        """
	try: model = self.__get_text(node.getElementsByTagName("product")[0].childNodes)
	except IndexError: model = ""
        try: mac = self.__get_text(node.getElementsByTagName("serial")[0].childNodes)
	except IndexError: mac = ""
        try: name = self.__get_text(node.getElementsByTagName("logicalname")[0].childNodes)
	except IndexError: name = ""

        # dirty hack
        speed = 1000
        if model.find("10 Gigabit") != 0:
            speed *= 10

        return NICInfo(model, speed, mac, name)

    def __get_text(self, nodelist):
        """\brief Concatenates text data from a list of xml nodes
        \param nodelist (\c minidom.Node[]) The nodes
        \return         (\c string)         The concatenated text
        """
        text = ""
        for node in nodelist:
            if node.nodeType == node.TEXT_NODE:
                text += node.data
        return text

    def __get_DOM(self, desc, file=True):
        """\brief Turns an xml file into a DOM object. If the file parameter is set to
                  true, desc should be the path to the xml file to read. Otherwise, desc
                  is a string containing xml to turn into a DOM object.
        \param desc  (\c string)  Path to an xml file or a string containing xml
        \param file  (\c bool)    Whether desc is a file or an xml string (default is true)
        \return      (\c xml.dom.minidom.Document) The DOM object
        """
        dom = None
        try:
            if file:
                dom = xml.dom.minidom.parse(desc)
            else:
                dom = xml.dom.minidom.parseString(desc)
        except Exception, e:
            print "Error getting dom " + str(e)
            return None
        return dom

    def __get_label(self, key, xml_object):
        """\brief Given an xml object and a key, returns the value matching that key
                  (a string) or None if nothing matches the key.
        \param key        (\c string)        The key to search for
        \param xml_object (\c minidom.Node)  The xml object to search for the key in
        \return           (\c string)        The value found or None if no value was found for the given key
        """
        if xml_object.attributes.has_key(key):
            return xml_object.attributes[key].value
        else:
            return None


class HostSpecsInfo(object):

    """\brief Container class for describing a computer's hardware specs
    """

    def __init__(self, nics, cpu_type, n_cpus, cores_per_cpu, memory):
        """\brief Initializes class

        \param nics          (\c list[NICInfo]) The computer's network interfaces
        \param cpu_type      (\c string)        The CPU type (e.g., Intel Xeon 5655)
        \param n_cpus        (\c int)           The number of cpus
        \param cores_per_cpu (\c int)           The number of cores per cpu
        \param memory        (\c int)           The amount of memory in GB
        """
        self.__nics = nics
        self.__cpu_type = cpu_type
        self.__n_cpus = n_cpus
        self.__cores_per_cpu = cores_per_cpu
        self.__memory = memory

    def get_nics(self):
        return self.__nics

    def get_cpu_type(self):
        return self.__cpu_type

    def get_n_cpus(self):
        return self.__n_cpus

    def get_cores_per_cpu(self):
        return self.__cores_per_cpu

    def get_memory(self):
        return self.__memory
        
    def __str__(self):
        string = "HostSpecsInfo: cpu_type=" + str(self.get_cpu_type()) + "," \
                              "n_cpus=" + str(self.get_n_cpus()) + "," \
                              "cores_per_cpu=" + str(self.get_cores_per_cpu()) + "," \
                              "memory=" + str(self.get_memory()) + "\n"

        for n in self.get_nics():
            string += str(n) + "\n"
        return string


class NICInfo(object):

    """\brief Container class for a NIC's information
    """

    def __init__(self, model, speed, mac, name, traffic_info=None):
        """\brief
        \param model        (\c string)      The NIC's model (e.g., Intel 82571EB)
        \param speed        (\c int)         The NIC's speed in Mbits/s (e.g., 10000)
        \param mac          (\c string)      The NIC's mac address
        \param name         (\c string)      The NIC's name (e.g., "eth0")
        \param traffic_info (\c TrafficInfo) Which traffic the NIC sees
        """
        self.__model = model
        self.__speed = speed
        self.__mac = mac
        self.__name = name
        self.__traffic_info = traffic_info

    def get_model(self):
        return self.__model

    def get_speed(self):
        return self.__speed

    def get_mac(self):
        return self.__mac

    def get_name(self):
        return self.__name

    def get_traffic_info(self):
        return self.__traffic_info
                             
    def set_traffic_info(self, traffic_info):
        self.__traffic_info = traffic_info

    def __str__(self):
        return "NICInfo: model=" + str(self.get_model()) + "," \
                        "speed=" + str(self.get_speed()) + "," \
                        "mac=" + str(self.get_mac()) + "," \
                        "name=" + str(self.get_name()) + "," \
                        "traffic_info=" + str(self.get_traffic_info())

class TrafficInfo(object):

    """\brief Class for describing the traffic that a NIC sees
    """

    # "in" means in from the Internet, unk=unknown
    DIRECTION = ["in", "out", "bi", "unk"]

    def __init__(self, prefix, direction):
        """\brief
        \param prefix    (\c string)                The prefix the NIC sees (e.g., 128.16.6/24)
        \param direction (\c TrafficInfo.DIRECTION) Which direction the traffic's flowing
        """
        self.__prefix = prefix
        self.__direction = direction

    def get_prefix(self):
        return self.__prefix

    def get_direction(self):
        return self.__direction

    def __str__(self):
        return "TrafficInfo: prefix=" + str(self.get_prefix()) + "," + \
                             "direction=" + str(self.get_direction())
