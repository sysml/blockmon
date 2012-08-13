/* Copyright (c) 2011, NEC Europe Ltd, Consorzio Nazionale 
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

/* -----------------------------------------------------------------------
--
--   Company: INVEA-TECH a.s.
--
--   Project: NetCOPE
--
-- -----------------------------------------------------------------------
--
--   (c) Copyright 2011 INVEA-TECH a.s.
--   All rights reserved.
--
--   Please review the terms of the license agreement before using this
--   file. If you are not an authorized user, please destroy this
--   source code file and notify INVEA-TECH a.s. immediately that you
--   inadvertently received an unauthorized copy.
--
-- -----------------------------------------------------------------------

*/

#include <stdio.h>
#include <pcap.h>
#include <string.h>

void got_packet(u_char *args, const struct pcap_pkthdr *header, const u_char *packet) {

	FILE* f;
	char c;
	int i;
	char buf[10];
	char tmp[3];
	int offset;

	if (header->caplen != header->len) {
		printf("Incomplete packet\n");	
		return;
	}

	if ((f = fopen("sze2packet.txt", "w")) != NULL) {
//		f= stdout;
		fprintf(f, "%08X\n", (0xC << 16) + header->len + 16);
		fprintf(f, "%08X\n", 0);
		fprintf(f, "%08X\n", 0);
		fprintf(f, "%08X\n", 0);
		fprintf(f, "$", 0);

		memset(buf, 0x0, 10);
		for  (i = 0; i < header->len; i++) {
//			printf("%d\n", i);
			if ((i % 4) == 0 && i != 0) {
				fprintf(f, "\n%s", buf);
//				fprintf(f, "%#x %#x %#x %#x\n", buf[0], buf[1], buf[2], buf[3]);
				memset(buf, 0x0, 10);
			}
			offset = (3 - (i % 4)) * 2;
			snprintf(tmp, 3, "%02X", *(packet+i));
			buf[offset] = tmp[0];
			buf[offset + 1] = tmp[1];

//			fprintf(f, "%02X", *(packet+i));
		}

		i = 0;
		while (buf[i] == 0) {
			buf[i] = '0';
			i++;
		}
		fprintf(f, "\n%s\n#", buf);
//*/
	}
	fclose(f);

}

int main(int argc, char *argv[])
{
	char *dev, errbuf[PCAP_ERRBUF_SIZE];

	pcap_t *pcap_handler;

	if (argc < 2) {
		fprintf(stderr, "Missing file\n");
		return (2);
	}

	pcap_handler = pcap_open_offline(argv[1], errbuf);

	if (pcap_handler == NULL) {
		fprintf(stderr, "Unable to open trace file: %s\n", errbuf);
		return (2);
	}

	pcap_loop(pcap_handler,1, got_packet, NULL);

	return(0);
}
