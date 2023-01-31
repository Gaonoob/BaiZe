cmake_minimum_required (VERSION 2.8)    #cmake的最低版本要求

# project (demo)                          #工程名叫demo
# include_directories(inc)                #代表头文件所在的路径
# aux_source_directory (src SRC)          #辅助源文件夹Func2别名为SRC_LIST2
# #add_executable(main main.c)
# add_executable(${SRC})                  #生成可执行文件，编译辅助源文件目录SRC下面的文件夹
# set (EXECUTABLE_OUTPUT_PATH ${PROJECT_SOURCE_DIR}/bin) #设定可执行文件输出目录是在工程根目录下的bin文件夹

#--------------------------------------------
# Project setting
#--------------------------------------------
INCLUDE(./dependencies.cmake)
HELLO_APP_EXTRACT_VERSION()

PROJECT(Gakki VERSION ${GAKKI_APP_VERSION})

MESSAGE(INFO "--------------------------------")
MESSAGE(STATUS "Build Gakki: ${GAKKI_APP_VERSION}")