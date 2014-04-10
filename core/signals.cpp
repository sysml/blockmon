/* Copyright (c) 2011-2012, NEC Europe Ltd, Consorzio Nazionale 
* Interuniversitario per le Telecomunicazioni, Institut 
* Telecom/Telecom Bretagne, ETH Zürich, INVEA-TECH a.s. All rights reserved.
*
* Redistribution and use in source and binary forms, with or without 
* modification, are permitted provided that the following conditions are met:
*    * Redistributions of source code must retain the above copyright
*      notice, this list of conditions and the following disclaimer.
*    * Redistributions in binary form must reproduce the above copyright
*      notice, this list of conditions and the following disclaimer in the
*      documentation and/or other materials provided with the distribution.
*    * Neither the names of NEC Europe Ltd, Consorzio Nazionale 
*      Interuniversitario per le Telecomunicazioni, Institut Telecom/Telecom 
*      Bretagne, ETH Zürich, INVEA-TECH a.s. nor the names of its contributors 
*      may be used to endorse or promote products derived from this software 
*      without specific prior written permission.
*
* THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS 
* "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT 
* LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR 
* A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL <COPYRIGHT 
* HOLDERBE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, 
* EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, 
* PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR 
* PROFITS; OR BUSINESS
* INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER 
* IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR 
* OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF 
* ADVISED OF THE POSSIBILITY OF SUCH DAMAGE
*/

#include "signals.hpp"
#include <signal.h>
#include <vector>
#include <iostream>
#include <cerrno>
#include <cstring>

namespace blockmon {

    static int didQuit = 0;

    bool did_quit() {
        return didQuit > 0;
    }

    void do_quit(int zero) {
        didQuit++;
    }

    void init_quit_signal() {
        struct sigaction sa, osa;

        std::vector<int> sigvec;

        sigvec.push_back(SIGINT);
        sigvec.push_back(SIGTERM);
        sigvec.push_back(SIGHUP);

        for (unsigned i = 0; i < sigvec.size(); i++) {

            sa.sa_handler = do_quit;
            sigemptyset(&sa.sa_mask);
            sa.sa_flags = sigvec[i];
            if (sigaction(SIGINT,&sa,&osa)) {
                std::cerr << "sigaction() failed" << strerror(errno);
                exit(1);
            }
        }
    }
}