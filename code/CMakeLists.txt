cmake_minimum_required (VERSION 2.8)    #cmake的最低版本要求


#--------------------------------------------
# Build code
#--------------------------------------------
# 代表头文件所在的路径
INCLUDE_DIRECTORIES(inc)

# 查找当前目录下的所有源文件
AUX_SOURCE_DIRECTORY(src SRC)

# 链接动态库
# LINK_DIRECTORIES

# 把所有的源文件加工成目标文件main
add_executable(main ${SRC})

# 设定可执行文件输出目录是在工程根目录下的bin文件夹
set(EXECUTABLE_OUTPUT_PATH ${PROJECT_SOURCE_DIR}/out/bin) 