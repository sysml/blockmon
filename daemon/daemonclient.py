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

from twisted.internet import reactor
from txjsonrpc.web.jsonrpc import Proxy
import jsonpickle
import sys
import os
import time

DAEMON_PORT = 7080

def print_results(value):
    r = jsonpickle.decode(value)
    print str(r)

def print_readvar_results(value):
    r = jsonpickle.decode(value)
    total = 0

    for v in r.get_value():
        var = v.get_value()
        print str(var)

def print_error(error):
    print 'error', error

def shut_down(data):
    reactor.stop()


bm_daemon = Proxy('http://127.0.0.1:' + str(DAEMON_PORT) + '/')

if len(sys.argv) < 2:
    print "usage: daemonclient.py [operation] [params]"
    print "operations:"
    print "========================="
    print "start: installs a composition"
    print "read:  reads a set of variables from a block"
    print "stop:  uninstalls a composition"
    os._exit(1)

op = sys.argv[1]

if op == "start":
    if len(sys.argv) < 3:
        print "usage: daemonclient.py start [composition]"
        os._exit(1)    
    f = open(sys.argv[2], "r")
    c = f.read()
    f.close()
    d = bm_daemon.callRemote('start_composition', c)
    d.addCallback(print_results).addErrback(print_error).addBoth(shut_down)

elif op == "stop":   
    if len(sys.argv) < 3:
        print "usage: daemonclient.py stop [composition id]"
        os._exit(1) 
    d = bm_daemon.callRemote('stop_composition', sys.argv[2])
    d.addCallback(print_results).addErrback(print_error).addBoth(shut_down)

elif op == "read":
    if len(sys.argv) < 5:
        print "usage:   daemonclient.py read [composition id] [blockname] [variables...]"
        print "example: daemonclient.py read mycomp counter pktcnt bytecnt"
        os._exit(1) 

    comp_id = sys.argv[2]
    blockname = sys.argv[3]
    variables = []

    for x in range(4, len(sys.argv)):
        variables.append([blockname, sys.argv[x], "", "read"])

    d = bm_daemon.callRemote('read_variables', comp_id, variables)
    d.addCallback(print_readvar_results).addErrback(print_error).addBoth(shut_down)

else:
    print "unknown operation"
    os._exit()

reactor.run()
