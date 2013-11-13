cmake_minimum_required(VERSION 2.8)
project(BlockMon)  

#############################################################
# File scan
#############################################################
# core
file(GLOB_RECURSE CORE_OBJ core/*.cpp)

# libs
file(GLOB_RECURSE LIB_OBJ_CPP lib/*.cpp)
file(GLOB_RECURSE LIB_OBJ_HPP lib/*.hpp)
file(GLOB_RECURSE LIB_OBJ_C lib/*.c)
list(APPEND LIB_OBJ ${LIB_OBJ_CPP} ${LIB_OBJ_HPP} ${LIB_OBJ_C})

# blocks
file(GLOB BLOCKS_OBJ blocks/*.cpp)

# messages
file(GLOB MSG_OBJ messages/*.cpp)

# ipfix bridge
file(GLOB IPFIX_OBJ ipfix/*.cpp)

# user files
#file(GLOB USR_OBJ usr/*/blocks/*.cpp)
#file(GLOB USR_INCL usr/*/blocks/)
#file(GLOB USR_MGS_INCL usr/*/messages/)
file(GLOB_RECURSE USR_CPP usr/*.cpp)
file(GLOB_RECURSE USR_HPP usr/*.hpp)
file(GLOB_RECURSE USR_H usr/*.h)
list(APPEND USR_OBJ ${USR_CPP} ${USR_HPP})
list(APPEND USR_INCL_FILES ${USR_H} ${USR_HPP})
# find unique directories of files in USR_INCL_FILES
    set(USR_INCL "")
    foreach(file_path ${USR_INCL_FILES})
        get_filename_component(dir_path ${file_path} PATH)
        set(USR_INCL ${USR_INCL} ${dir_path})
    endforeach()
    LIST(REMOVE_DUPLICATES USR_INCL)

# daemon: c++ to python bindings
file(GLOB DAEMON_BINDINGS daemon/*.cpp)

#############################################################
# Remove any test dirs from the lib objects
#############################################################
set(TMP_LIST "")
foreach(arg ${LIB_OBJ})
  string(REGEX REPLACE ".*test.*" "" arg ${arg})
  list(APPEND TMP_LIST ${arg})
endforeach(arg ${LIB_OBJ})
set(LIB_OBJ ${TMP_LIST})


#############################################################
# Remove not-needed pugixml files
#############################################################
set(TMP_LIST "")
foreach(arg ${LIB_OBJ})
  string(REGEX REPLACE ".*pugixml.*docs.*" "" arg ${arg})
  list(APPEND TMP_LIST ${arg})
endforeach(arg ${LIB_OBJ})
set(LIB_OBJ ${TMP_LIST})

#############################################################
# Optional packages
#############################################################
if(WITH_PFQ)
  message(STATUS "pfq (WITH_PFQ): ON")
  add_definitions(-DPFQ_BLOCK)
  list(APPEND INCLUDE_DIRS lib/external/pfq)
else(WITH_PFQ)
  message(STATUS "pfq (WITH_PFQ): OFF")

   # exclude pfq block
   set(TMP_LIST "")
   foreach(arg ${BLOCKS_OBJ})
     string(REGEX REPLACE "PFQSource.cpp" "" arg ${arg})
     list(APPEND TMP_LIST ${arg})
   endforeach(arg ${BLOCKS_OBJ})
   set(BLOCKS_OBJ ${TMP_LIST})

endif()

if(USE_SLICED_PACKET)
    message(STATUS "packet (USE_SLICED_PACKET=on): SLICED")
    add_definitions(-DUSE_SLICED_PACKET)
else()
    if(USE_SIMPLE_PACKET)
        message(STATUS "packet (USE_SIMPLE_PACKET=on): SIMPLE")
        add_definitions(-DUSE_SIMPLE_PACKET)
    endif()
endif()

if(NOT USE_SIMPLE_PACKET AND NOT USE_SLICED_PACKET)
    message(STATUS "packet (neither USE_SIMPLE_PACKET nor USE_SLICED_PACKET set): using old packet")
endif()

if(USE_PACKET_TAG)
    message(STATUS "packet tag (USE_PACKET_TAG=on): ENABLED")
    add_definitions(-DUSE_PACKET_TAG)
else()
    message(STATUS "packet tag (USE_PACKET_TAG=off): DISABLED")
endif()

if(USE_PACKET_FLOW)
    message(STATUS "packet flow (USE_PACKET_FLOW=on): ENABLED")
    add_definitions(-DUSE_PACKET_FLOW)
else()
    message(STATUS "packet flow (USE_PACKET_FLOW=off): DISABLED")
endif()

if(BLOCKING_QUEUE)
    message(STATUS "InGate queue (BLOCKING_QUEUE=on): BLOCKING")
    add_definitions(-DBLOCKING_QUEUE)
else()
    message(STATUS "InGate queue (BLOCKING_QUEUE=off): DROPPING (i.e., non-blocking)")
endif()


list(APPEND INCLUDE_DIRS lib/fc)

# INVEA-TECH HW acceleration system libraries
if(WITH_COMBO)
   message(STATUS "COMBO(sze2): ON")
  list(APPEND BLOCKMON_LINK_LIBS combo)
  list(APPEND BLOCKMON_LINK_LIBS sze2)
  list(APPEND BLOCKMON_LINK_LIBS commlbr)
  add_definitions(-D_COMPILE_COMBO_BLOCK_)
else(WITH_COMBO)
   message(STATUS "COMBO(sze2): OFF")

   # exclude any paths to sze2 dependent files
   set(TMP_LIST "")
   foreach(arg ${USR_INCL})
     string(REGEX REPLACE ".*/usr/combo/.*" "" arg ${arg})
     list(APPEND TMP_LIST ${arg})
   endforeach(arg ${USR_INCL})
   set(USR_INCL ${TMP_LIST})

   set(TMP_LIST "")
   foreach(arg ${USR_OBJ})
     string(REGEX REPLACE ".*/usr/combo/.*" "" arg ${arg})
     list(APPEND TMP_LIST ${arg})
   endforeach(arg ${USR_OBJ})
   set(USR_OBJ ${TMP_LIST})

endif()

if(WITH_TWITTERTRENDING)
   message(STATUS "TWITTERTRENDING(jsmn): ON")
  list(APPEND INCLUDE_DIRS lib/jsmn)
  add_definitions(-D_USE_JSMN_LIBRARY)
endif()

# For debug purposes
#message (STATUS "INCLUDE_DIRS: " ${INCLUDE_DIRS})

#############################################################
# Build
#############################################################
list(APPEND BLOCKMON_LINK_LIBS pcap pthread)
list(APPEND INCLUDE_DIRS lib/external/pugixml/src lib lib/external/factory lib/external/more lib/external/ lib/hash lib/cusum lib/bloom core messages blocks ipfix core/block core/message core/composition core/scheduler core/time ${USR_INCL} )

include_directories( ${INCLUDE_DIRS} )
set (CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -O3 -march=native -Wall -g -std=c++0x")
add_definitions(-D_GLIBCXX_USE_SCHED_YIELD -D_GLIBCXX_USE_NANOSLEEP)

add_library(blockmoncore SHARED ${CORE_OBJ} ${MSG_OBJ} ${IPFIX_OBJ} ${LIB_OBJ} ${BLOCKS_OBJ} ${USR_OBJ})
target_link_libraries(blockmoncore ${BLOCKMON_LINK_LIBS})

add_executable(blockmon bin/blockmon.cpp)
target_link_libraries(blockmon blockmoncore ${BLOCKMON_LINK_LIBS})

if (WITH_DAEMON)
  message(STATUS "daemon (WITH_DAEMON): ON")
  find_package(PythonLibs REQUIRED)
  include_directories(${PYTHON_INCLUDE_DIRS})
  link_directories(${PYTHON_LIBRARIES})
  add_library(blockmonpy SHARED ${DAEMON_BINDINGS})
  target_link_libraries(blockmonpy blockmoncore boost_python)
else(WITH_DAEMON)
  message(STATUS "daemon (WITH_DAEMON): OFF")  
endif()




