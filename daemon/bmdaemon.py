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

from txjsonrpc.web import jsonrpc
from twisted.web import server
from twisted.internet import reactor, defer, threads, task
import xmlrpclib, pickle
import os
import sys
import ConfigParser
from core.returnvalue import *
from core.host import HostSpecsManager
from core.bmprocess import BMProcessInfo
from core.spawner import ProcessSpawner
from core.bmparser import CompositionParser
import core.block
import jsonpickle
import json
import logging
import commands
import random

from pickle import *

from txjsonrpc.web.jsonrpc import Proxy
import socket, fcntl, struct

class BMDaemon(jsonrpc.JSONRPC):

	"""\brief Uses a json-rpc server on a well-known port to present a
			  Blockmon API to the outside world (json is also used for 
			  marshalling and demarshalling objects). All calls return a 
			  core.returnvalue.ReturnValue object. Note that function
			  documentation will list ReturnValue as the return type, but
			  the human-readable description refers to ReturnValue.value.
			  Run as root/sudo.

			  The daemon works by spawning processes each running a separate
			  instance of blockmon. In order to communicate with these, the
			  BMDaemon uses xml-rpc and pickle. Note that core/bmprocess.py
			  must be executable (u+x) in order for things to work.
	"""

	def __init__(self, config):
		"""\brief Initializes class
		\param config (\c string) The path to the daemon's configuration file
		"""
		self.__bm_processes = {}	# [string]->BMProcessInfo (string: composition id)
		self.__config = config
		self.__parser = CompositionParser()
		self.__listening_port = None
		self.__bm_proc_exec = None
		self.__block_ext = None
		self.__blocks_path = None
		self.__logging_dir = None
		self.__bm_base_path = None
		self.__tmp_dir = None
		self.__logger = None
		
		self.__bc_ipaddr = None
		self.__bc_listening_port = None
		self.__bc_connected = False
		self.__local_ip = None

		self.__parse_config()
		self.__init_logging()
		self.__spawn_proc_id = 1
		self.__logger.info("starting bm daemon on port %s", str(self.__listening_port))
		
		TIMEOUT = 3
		self.__MAX_ATTEMPTS = 5
		self.__attempts = 0 
		self.__registration_loop = task.LoopingCall(self.__registration)
		self.__registration_loop.start(TIMEOUT)

	def jsonrpc_get_blocks_list(self):
		"""\brief Gets a list of the block types currently installed on the local host
		\return (\c ReturnValue) The block types (list[string])
		"""
		f = None
		try:
			f = open(self.__bm_base_path + "/daemon/core/blockinfo.py")
		except IOError as e:
			msg = "No blockinfo.py file available, please run the " + \
				  "blockinfoparser.py script to generate this file"
			r = ReturnValue(ReturnValue.CODE_FAILURE, msg, None)
			return jsonpickle.encode(r)
		
		f.close()
		
		from core.blockinfo import block_infos
		r = ReturnValue(ReturnValue.CODE_SUCCESS, "", block_infos.keys())
		return jsonpickle.encode(r)

	def jsonrpc_get_hw_specs(self):
		"""\brief Gets a description of the local host's hardware specs
		\return (\c ReturnValue) The specs (HostSpecsInfo)
		"""
		mngr = HostSpecsManager()
		r = ReturnValue(ReturnValue.CODE_SUCCESS, "", mngr.get_host_specs())
		return jsonpickle.encode(r)

	def jsonrpc_get_blocks_info(self, block_types):
		"""\brief Gets ful information about the given set of blocks
		\param  block_types (\c list[string]) The block types (e.g., ["PFQSource"])
		\return			 (\c ReturnValue)  The information (list[BlockInfo])
		"""
		f = None
		try:
			f = open(self.__bm_base_path + "/daemon/core/blockinfo.py")
		except IOError as e:
			msg = "No blockinfo.py file available, please run the " + \
				  "blockinfoparser.py script to generate this file"
			r = ReturnValue(ReturnValue.CODE_FAILURE, msg, None)
			return jsonpickle.encode(r)
		
		f.close()
		
		from core.blockinfo import block_infos
		blocks = []
		not_found = []
		for block_type in block_types:
			if block_infos.has_key(block_type):
				blocks.append(block_infos[block_type])
			else:
				not_found.append(block_type)

		msg = ""
		if len(not_found) > 0:
			msg = "not found:" + str(not_found)

		r = ReturnValue(ReturnValue.CODE_SUCCESS, msg, blocks)
		return jsonpickle.encode(r)

	@defer.inlineCallbacks
	def jsonrpc_start_composition(self, comp, datafiles = []):
		"""\brief Starts a new Blockmon instance based on the given 
				  composition XML. The instance will run in a newly
				  spawned process.
		\param  comp (\c string)	  The composition XML
		\param  datafiles (\c list)	  The datafile to be used
		\return	  (\c ReturnValue) Value member is empty
		"""
		self.__parser.set_comp(comp)
		comp_id = self.__parser.parse_comp_id()

		if self.__bm_processes.has_key(comp_id):
			self.__logger.info("tried to start already running composition (id=" + comp_id + ")")
			r = ReturnValue(ReturnValue.CODE_SUCCESS, "composition already running", None)
			defer.returnValue(jsonpickle.encode(r))

		bmproc_id = "bmprocess" + str(self.__spawn_proc_id)
		logfile = self.__logging_dir + "/" + bmproc_id + ".log"
		compfile = self.__tmp_dir + "/" + bmproc_id + ".xml"
		commands.getstatusoutput("mkdir -p " + self.__tmp_dir)

		if len(datafiles):
			for (fname,fbin) in datafiles:
				isSaved = yield threads.deferToThread(self.__save_datafile, fname, fbin)
				if isSaved: comp = comp.replace(fname,self.__tmp_dir + "/" + fname)

		f = open(compfile, "w")
		f.write(comp)
		f.close()

		portno = yield threads.deferToThread(self.__find_open_port)
		port = str(portno)
		args = [compfile, logfile, port]
		try:
			proc = yield threads.deferToThread(ProcessSpawner.spawn,self.__bm_proc_exec, args)
		except OSError as err:
			# handle error (see below)
			print("Failure when starting composition. Ensure that core/bmprocess.py is set to executable (u+x)." + err)
			r = ReturnValue(ReturnValue.CODE_FAILURE, "error while starting composition", None)
			defer.returnValue(jsonpickle.encode(r))
		info = BMProcessInfo(proc, comp, logfile, port)
		self.__bm_processes[comp_id] = info
		self.__spawn_proc_id += 1
		r = ReturnValue(ReturnValue.CODE_SUCCESS, "", None)

		self.__logger.info("spawned bm process on port " + port)
		print "spawned bm process on port " + port
		defer.returnValue(jsonpickle.encode(r))

	def jsonrpc_update_composition(self, comp):
		"""\brief Updates a Blockmon instance based on the given 
				  composition XML. 
		\param  comp (\c string)	  The composition XML
		\return	  (\c ReturnValue) Value member is empty
		"""
		self.__parser.set_comp(comp)
		comp_id = self.__parser.parse_comp_id()
		port = self.__bm_processes[comp_id].get_port()
		url = "http://localhost:" + str(port) + "/"
		proxy = xmlrpclib.ServerProxy(url)
		r = pickle.loads(proxy.update_composition(comp))
		return jsonpickle.encode(r)		

	def jsonrpc_stop_composition(self, comp_id):
		"""\brief Stops a Blockmon instance identified by the given 
				  composition id.
		\param  (\c string)	  The composition's id
		\return (\c ReturnValue) Value member is empty
		"""
		if not self.__bm_processes.has_key(comp_id):
			msg = "no composition with the given id exists, can't stop"
			r = ReturnValue(ReturnValue.CODE_SUCCESS, msg, None)
			return jsonpickle.encode(r)
		port = self.__bm_processes[comp_id].get_port()
		url = "http://localhost:" + str(port) + "/"
		proxy = xmlrpclib.ServerProxy(url)
		r = pickle.loads(proxy.stop_composition())
		self.__bm_processes[comp_id].get_proc().kill()
		del self.__bm_processes[comp_id]
		self.__logger.info("killed bm process for composition " + comp_id)
		print "killed bm process for composition " + comp_id
		return jsonpickle.encode(r)
 
	def jsonrpc_get_composition_ids(self):
		"""\brief Gets the ids of all compositions currently running
		\return (\c ReturnValue) The ids (list[string])
		"""
		r = ReturnValue(ReturnValue.CODE_SUCCESS, "", self.__bm_processes.keys())
		return jsonpickle.encode(r)

	def jsonrpc_get_running_compositions(self, comp_ids):
		"""\brief Gets the composition XML for the given ids
		\param comp_ids (\c list[string]) The ids
		\return		 (\c ReturnValue)  The compositions' XML (list[string])
		"""
		comps = []
		for comp_id in comp_ids:
			if self.__bm_processes.has_key(comp_id):
				comps.append(self.__bm_processes[comp_id].get_comp())
		r = ReturnValue(ReturnValue.CODE_SUCCESS, "", comps)
		return jsonpickle.encode(r)		

	def jsonrpc_read_variables(self, comp_id, json_variables):
		"""\brief Reads a set of block variables. Each VariableInfo object
				  needs to have the name of the block and the variable name
				  set. The access_type member should be set to "read". The
				  function returns the same list, this time with the "value"
				  member filled out.
		\param comp_id		(\c string)			 The composition id
		\param json_variables (\c list[VariableInfo]) Json-encode variables
		\return			   (\c ReturnValue)		The values (list[VariableInfo])
		"""
		if not self.__bm_processes.has_key(comp_id):
			msg = "no composition with the given id exists, can't read variables"
			return jsonpickle.encode(ReturnValue(ReturnValue.CODE_FAILURE, msg, None))

		variables = []
		try:
			variables = jsonpickle.decode(json_variables)
		except:
			# Non-jsonpickle encoding, supports non-python clients (assumes
			# a list of lists)
			for v in json_variables:
				variables.append(core.block.VariableInfo(str(v[0]), str(v[1]), str(v[2]), str(v[3])))

		port = self.__bm_processes[comp_id].get_port()
		url = "http://localhost:" + str(port) + "/"
		proxy = xmlrpclib.ServerProxy(url)

		results = []
		for variable in variables:
			result = pickle.loads(proxy.read_variable(pickle.dumps(variable)))
			results.append(result)
		r = ReturnValue(ReturnValue.CODE_SUCCESS, "", results)
		return jsonpickle.encode(r)

	def jsonrpc_write_variables(self, comp_id, json_variables):
		"""\brief Writes to a set of block variables. Each VariableInfo object
				  needs to have the name of the block, the variable name and the
				  value set. The access_type member should be set to "write". 
		\param comp_id		(\c string)			 The composition id
		\param json_variables (\c list[VariableInfo]) Json-encode variables
		\return		  (\c ReturnValue)		Value member is empty
		"""
		if not self.__bm_processes.has_key(comp_id):
			msg = "no composition with the given id exists, can't write variables"
			return ReturnValue(ReturnValue.CODE_FAILURE, msg, None)

		variables = []
		try:
			variables = jsonpickle.decode(json_variables)
		except:
			# Non-jsonpickle encoding, supports non-python clients (assumes
			# a list of lists)
			for v in json_variables:
				variables.append(core.block.VariableInfo(v[0], v[1], v[2], v[3], v[4]))

		port = self.__bm_processes[comp_id].get_port()
		url = "http://localhost:" + str(port) + "/"
		proxy = xmlrpclib.ServerProxy(url)

		results = []
		for variable in variables:
			result = pickle.loads(proxy.write_variable(pickle.dumps(variable)))
			results.append(result)
		r = ReturnValue(ReturnValue.CODE_SUCCESS, "", results)
		return jsonpickle.encode(r)

	def __save_datafile(self, fname, fbin):
		import base64
		data = base64.b64decode(fbin)
		f = open(self.__tmp_dir +'/'+fname,'w')
		try: f.write(data) 
		except: return False
		f.close()
		return True

	@defer.inlineCallbacks
	def jsonrpc_save_datafile(self, fname, fbin):
		isSaved = yield threads.deferToThread(self.__save_datafile, fname, fbin)
		if isSaved: r = ReturnValue(ReturnValue.CODE_SUCCESS, "datafile saved successfully", None)
		else: r = ReturnValue(ReturnValue.CODE_FAILURE, "error while saving datafile", None)
		defer.returnValue(jsonpickle.encode(r))

	def get_listening_port(self):
		return self.__listening_port

	def __find_open_port(self):
		port = None
		while(1):
			port = random.randint(40000, 65535)
			cmd = "netstat -lant | grep " + str(port) + " | wc -l"

			if int(commands.getstatusoutput(cmd)[1]) == 0:
				return port

	def __parse_config(self):
		cp = ConfigParser.ConfigParser()		
		cp.read(self.__config)
		self.__logging_dir = cp.get('MAIN', 'logging_dir')		
		self.__tmp_dir = cp.get('MAIN', 'tmp_dir')		
		self.__listening_port = int(cp.get('NETWORK', 'listening_port'))
		try:
			self.__bc_ipaddr = cp.get('NETWORK', 'bc_ipaddr')
			self.__bc_listening_port = int(cp.get('NETWORK', 'bc_listening_port'))
			iface = cp.get('NETWORK', 'iface')
			self.__local_ip = self.__get_ip_address(iface) 
		except ConfigParser.NoOptionError: pass
		self.__block_ext = cp.get('BLOCKS', 'block_ext')
		self.__blocks_path = cp.get('BLOCKS', 'blocks_path')
		self.__bm_proc_exec = cp.get('MAIN', 'bm_process_exec')
		self.__bm_base_path = cp.get('DEFAULT', 'bm_basepath')

	def __init_logging(self):
		self.__logger = logging.getLogger()
		if not os.path.isdir(self.__logging_dir):
			try:
				commands.getstatusoutput("mkdir -p " + self.__logging_dir)
			except:
				print "error while trying to initialize logging!"
				return

		hdlr = logging.FileHandler(self.__logging_dir + "/bmdaemon.log")
		formatter = logging.Formatter('%(asctime)s %(levelname)s %(message)s')
		hdlr.setFormatter(formatter)
		self.__logger.addHandler(hdlr)
		self.__logger.setLevel(logging.INFO)	   

	def __registration_results(self, value):
		r = jsonpickle.decode(value)
		self.__bc_connected = (True if r.get_code() is ReturnValue.CODE_SUCCESS else False)
		self.__attempts = 0 

	def __registration_error(self, error):
		self.__bc_connected = False
		self.__attempts += 1
		if self.__attempts == self.__MAX_ATTEMPTS: 
			print "giving up registering to BC"
			self.__registration_loop.stop()

	def __get_ip_address(self, ifname):
		s = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
		return socket.inet_ntoa(fcntl.ioctl(s.fileno(),0x8915,struct.pack('256s', ifname[:15]))[20:24])

	def __registration(self):
		port = self.__listening_port
		if ((self.__bc_ipaddr == None) or \
			(self.__bc_listening_port == None)):
			print "no BC ip or port specified, skipping registration"
			self.__registration_loop.stop()
			return
		bc_register = Proxy('http://%s:%d/' % (self.__bc_ipaddr,self.__bc_listening_port))
		if self.__bc_connected:
			d = bc_register.callRemote('keepalive', self.__local_ip, port)
		else:
			host_specs = HostSpecsManager().get_host_specs()
			specs = jsonpickle.encode(host_specs)
			from core.blockinfo import block_infos
			blocks =  block_infos.keys()
			blocks_descr = [block_infos[b] for b in blocks] 
			descr = jsonpickle.encode(blocks_descr)
			#blocks_descr = [str(block_infos[b]) for b in blocks] 
			#d = bc_register.callRemote('register', self.__local_ip, port, specs, blocks)
			#d = bc_register.callRemote('register', self.__local_ip, port, specs, blocks, blocks_descr)
			d = bc_register.callRemote('register', self.__local_ip, port, specs, blocks, descr)
		d.addCallback(self.__registration_results).addErrback(self.__registration_error)

########################################################################
#
# MAIN EXECUTION
#
########################################################################
if __name__ == "__main__":
	if len(sys.argv) < 2:
		print "usage: bmdaemon.py [config]"
		os._exit(1)

	config = sys.argv[1]
	bmd = BMDaemon(config)
	port = bmd.get_listening_port()

	reactor.listenTCP(port, server.Site(bmd))
	
	print "starting bm daemon on port " + str(port)
	
	reactor.run()
