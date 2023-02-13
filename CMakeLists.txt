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
# Build application
#--------------------------------------------
# 代表头文件所在的路径
include_directories(code/inc)

# 文件夹Func2别名为SRC_LIST2
aux_source_directory(code/src SRC)

# 生成可执行文件，编译辅助源文件目录SRC下面的文件夹
add_executable(main ${SRC})
#add_executable(main main.c) #main 生成bin名成  main.c为源码

# 设定可执行文件输出目录是在工程根目录下的bin文件夹
set(EXECUTABLE_OUTPUT_PATH ${PROJECT_SOURCE_DIR}/out/bin) 