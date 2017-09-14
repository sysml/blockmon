BLOCKMON INSTALLATION INSTRUCTIONS
==============================================
To compile blockmon you will need gcc version 4.6 or higher (earlier
versions might work but have not be tested) as well as
cmake 2.8 or higher. In addition, you will need several external libraries
(see below) which need to be installed into the `lib/external` directory.

Python 2.5 or higher is required for using the blockmon CLI. The daemon and
CLI further require the [twisted json-rpc package](http://pypi.python.org/pypi/txJSON-RPC/)
, the [json pickle package](http://pypi.python.org/pypi/jsonpickle) and
the [Twisted](https://pypi.python.org/pypi/Twisted).

For more information on the CLI and daemon please check the [README](https://github.com/sysml/blockmon/blob/master/README.md).

EXTERNAL LIBRARIES
------------------
Several external libraries have to be installed into the `lib/external`
directory. Follow the steps listed here to do so.

1. Crypto-Pan
   ```
   mkdir lib/external/crypto
   cd lib/external/crypto
   wget http://www.cc.gatech.edu/computing/Networking/projects/cryptopan/Crypto-PAn.1.0.tar.gz
   tar xzf Crypto-PAn.1.0.tar.gz
   mv Crypto-PAn.1.0/* .
   mv sample.cpp sample.cpp.exclude
   rmdir Crypto-PAn.1.0
   cd ../../..
   ```

2. PugiXML
   ```
   mkdir lib/external/pugixml
   cd lib/external/pugixml
   wget http://pugixml.googlecode.com/files/pugixml-1.2.tar.gz
   tar xzf pugixml-1.2.tar.gz
   cd ../../..
   ```

3. libfc (you need GIT installed for this)
   ```
   cd lib
   git clone git://github.com/britram/libfc.git fc
   cd fc
   git checkout af3065e37cdadabf00ed170c9830cfde57708b05
   mv ipfix2csv.cpp ipfix2csv.cpp.exclude
   mv fcprof.cpp fcprof.cpp.exclude
   cd ../..
   ```

PORTABILITY
-------------
In theory should build on various systems including Linux and Windows, though
so far this has only been tested on the former.

PFQ
--------------
Blockmon supports [PFQ](http://www.pfq.io/), an
accelerated packet capture engine designed for multi-core architectures.
By default, PFQ's source block will not be built; to enable it
provide the -DWITH_PFQ=ON option to cmake (see below).

Please note that before running cmake with -DWITH_PFQ=ON, PFQ must be installed on the system.
The PFQ source code is available at its [public github repository](https://github.com/pfq/PFQ) and, at this moment, Blockmon is compatible with version [1.4.3](https://github.com/pfq/PFQ/tree/v1.4.3) of PFQ, which is also the version of PFQ fully compatible with Debian Jessie (3.16 kernel). Please checkout the correct version of PFQ and then follow its instructions to install it before building Blockmon with PFQ support.

Once PFQ is installed in the system, place the user-level PFQ header file
in the Blockmon build tree:
```
cp [PFQDIR]/user/C++/pfq.hpp [BLOCKMONDIR]/lib/external/pfq/
```

If the directory `[BLOCKMONDIR]/lib/external/pfq/` does not exist, create it.

IPFIX
--------------
Blockmon supports [IPFIX](http://datatracker.ietf.org/wg/ipfix/charter/) through a block
called IPFIXExporter. In order to build it, you will need to have the [boost](http://www.boost.org/) libraries
installed.

COMBO SZE2
--------------
Blockmon supports SZE2 interface for high speed data transfer from [INVEA-TECH](http://www.invea-tech.com/)
hardware acceleratorion cards COMBO. In order to build it, you will need to have
the [NetCOPE development platform](http://www.invea-tech.com/products-and-services/netcope-fpga-platform)
and [COMBO card](http://www.invea-tech.com/products-and-services/combo-fpga-boards) installed, and you will
need to run cmake with -DWITH_COMBO=ON (see below).

TSTAT
--------------
Blockmon has a block which calls the tstat library.
Once tstat is installed in the system, place the following files in the
Blockmon build tree:
```
cp [TSTATDIR]/include/libtstat.h [BLOCKMONDIR]/lib/external/tstat/
ln -s [TSTATDIR]/libtstat/.libs [BLOCKMONDIR]/lib/external/tstat/libtstatdir
```

and compile Blockmon with -DWITH_TSTAT option.

INSTALL
--------------
On the main directory type
```
cmake .
```
If you would like to build optional features (or remove them) the syntax is
```
cmake -D<feature>=ON|OFF
```
Currently supported features are:

* WITH_PFQ: Support for PFQ-based capture block
* WITH_COMBO: Support for COMBO acceleration cards
* WITH_DAEMON: Support for a json-rpc, python-based control daemon plus the CLI
	     (if you specify WITH_DAEMON=OFF the txJSON-RPC library is not required)

Furthermore you can chose between different implementations of the Packet class:
* USE_SIMPLE_PACKET: Use new implementation of Packet class with simple memory allocator
* USE_SLICED_PACKET: Use new implementation of Packet class with memory slice-allocator
If none of the above features is specified, the old Packet implementation is used (quite similar to SimplePacket).

The queueing behavior of InGates can also be specified using the BLOCKING_QUEUE feature:
* BLOCKING_QUEUE=ON allows configuration of queueing behavior for each
block individually in the XML composition. Since each
block can be configured differently, a small overhead is introduced
even when queues are not full. If maximum message
processing performance is required (and messages may be dropped), BLOCKING_QUEUE
should be set to OFF.

Note that options passed with -D will persist across independent runs of cmake. For
instance, if you first run cmake with -DWITH_PFQ=ON and then run it without it,
the second run will also have -DWITH_PFQ=ON even if not explicitly given on the
command line. To revert this you would have to run cmake with -DWITH_PFQ=OFF;
subsequent runs will keep this value implicitly.

When cmake is finished, type:
```
make
```
That's it!

ERRORS
--------------
If you get the error:
```
Could NOT find PythonLibs (missing: PYTHON_LIBRARIES PYTHON_INCLUDE_DIRS)
```

please install the `python-dev` package. Under a Debian-based system:
```
sudo apt-get install python-dev
```
If you're building blockmon with the daemon and cli and you get a link error
at the end of the build you may be missing the python boost libraries. Install
them with:
```
  apt-get install libboost-python1.42.0 libboost-python1.42-dev
```
