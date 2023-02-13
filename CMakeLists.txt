cmake_minimum_required (VERSION 2.8)    #cmake的最低版本要求

#--------------------------------------------
# load configuration
#--------------------------------------------
INCLUDE(../cmake/utils.cmake)
decode_base_info()

# 处理云平台服务器编译失败
if (POLICY CMP0048)
  cmake_policy(SET CMP0048 NEW)
endif (POLICY CMP0048)

#--------------------------------------------
# compile pre config
#--------------------------------------------
# 指定项目版本 版本号 等等
PROJECT(BaiZe VERSION ${BAIZE_BASE_VERSION})

# Debug 打印
MESSAGE(INFO "--------------------------------")
MESSAGE(STATUS "Build BaiZe Ver: ${BAIZE_BASE_VERSION}") # 输出前缀为—-的信息
MESSAGE(INFO "--------------------------------")
MESSAGE(STATUS "operation system is ${CMAKE_SYSTEM}")

#--------------------------------------------
# compile config
#--------------------------------------------

#--------------------------------------------
# Add application
#--------------------------------------------
ADD_SUBDIRECTORY(code)

