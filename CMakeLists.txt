cmake_minimum_required(VERSION 2.8)
project(BlockMon)  

#############################################################
# File scan
#############################################################
file(GLOB BASE_OBJ base/*.cpp)
file(GLOB EXT_OBJ lib/external/*.cpp)
file(GLOB LIB_OBJ lib/*.cpp)
file(GLOB LIB_OBJ_D lib/*/*.cpp)
file(GLOB LIB_HASH_C lib/hash/C/*.c)
file(GLOB MES_OBJ  base/*/*.cpp)
file(GLOB USR_OBJ usr/*/blocks/*.cpp)
file(GLOB USR_INCL usr/*/blocks/)
file(GLOB USR_MES_INCL usr/*/messages/)
file(GLOB PYTHON_BINDINGS python_bindings/*.cpp)

#############################################################
# Optional packages
#############################################################
if(WITH_PFRING)
  message(STATUS "pfring: ON")
  add_definitions(-DPFRING_BLOCK)
  list(APPEND TARGET_LINK_LIBS pfring)
else(WITH_PFRING)
  message(STATUS "pfring: OFF")
endif()

if(WITH_IPFIX)
   message(STATUS "ipfix: ON")
   list(APPEND INCLUDE_DIRS lib/fc)
else(WITH_IPFIX)
   message( STATUS "ipfix: OFF" )

   # exclude any paths to ipfix files
   set(TMP_LIST "")
   foreach(arg ${USR_INCL})
     string(REGEX REPLACE ".*ipfix_ep.*" "" arg ${arg})
     list(APPEND TMP_LIST ${arg})
   endforeach(arg ${USR_INCL})
   set(USR_INCL ${TMP_LIST})
	
   set(TMP_LIST "")
   foreach(arg ${USR_OBJ})
     string(REGEX REPLACE ".*ipfix_ep.*" "" arg ${arg})
     list(APPEND TMP_LIST ${arg})
   endforeach(arg ${USR_OBJ})
   set(USR_OBJ ${TMP_LIST})	

   set(TMP_LIST "")
   foreach(arg ${LIB_OBJ_D})
     string(REGEX REPLACE ".*/lib/fc/.*" "" arg ${arg})
     list(APPEND TMP_LIST ${arg})
   endforeach(arg ${LIB_OBJ_D})
   set(LIB_OBJ_D ${TMP_LIST})	

endif()

# INVEA-TECH HW acceleration system libraries
if(WITH_COMBO)
   message(STATUS "COMBO(sze2): ON")
  list(APPEND TARGET_LINK_LIBS sze2)
  list(APPEND TARGET_LINK_LIBS commlbr)
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


# For debug purposes
#message (STATUS "INCLUDE_DIRS: " ${INCLUDE_DIRS})
#message (STATUS "USR_INCL: " ${USR_INCL})
#message (STATUS "USR_MES_INCL: " ${USR_MSG_INCL})

#message (STATUS "BASE_OBJ: " ${BASE_OBJ})
#message (STATUS "MES_OBJ: " ${MES_OBJ})
#message (STATUS "EXT_OBJ: " ${EXT_OBJ})
#message (STATUS "LIB_OBJ_D: " ${LIB_OBJ_D})
#message (STATUS "LIB_OBJ: " ${LIB_OBJ})
#message (STATUS "USR_OBJ: " ${USR_OBJ})
#message (STATUS "LIB_HASH_C: " ${LIB_HASH_C})

#message (STATUS "TARGET_LINK_LIBS: " ${TARGET_LINK_LIBS})



#############################################################
# Build
#############################################################
list(APPEND TARGET_LINK_LIBS  pcap pthread)
list(APPEND INCLUDE_DIRS lib lib/pfq lib/external lib/hash base base/messages base/composition base/scheduler ${USR_MES_INCL} ${USR_INCL} )
include_directories( ${INCLUDE_DIRS} )       
set (CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -O3 -march=native  -Wall -std=c++0x")
add_definitions(-D_GLIBCXX_USE_SCHED_YIELD -D_GLIBCXX_USE_NANOSLEEP)
#add_definitions(-D_GLIBCXX_DEBUG_PEDANTIC )



add_executable(blockmonnaked ${BASE_OBJ} ${MES_OBJ} ${EXT_OBJ} ${LIB_OBJ_D} ${LIB_OBJ} ${USR_OBJ} ${LIB_HASH_C})
target_link_libraries(blockmonnaked ${TARGET_LINK_LIBS})

if(WITH_PYTHON)
LINK_LIBRARIES(boost_python)
find_package(PythonLibs REQUIRED)
include_directories(${PYTHON_INCLUDE_DIRS})
link_directories(${PYTHON_LIBRARIES})
ADD_LIBRARY(blockmon SHARED ${BASE_OBJ} ${MES_OBJ} ${EXT_OBJ} ${LIB_OBJ_D} ${LIB_OBJ} ${USR_OBJ} ${LIB_HASH_C} ${PYTHON_BINDINGS})
target_link_libraries(blockmon ${TARGET_LINK_LIBS})
endif()
