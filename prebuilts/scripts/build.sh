#!/bin/bash

# 定义代码源目录、输出目录、编译日志目录等
CUR_PATH=$(pwd)
CODE_PATH=${CUR_PATH}/code
CUST_PATH=${CUR_PATH}/cust
OUT_PATH=${CUR_PATH}/out
OUT_CMAKE_PATH=${CUR_PATH}/out/cmakelog

# 注释
userlist=(userdebug user eng)
prolist=$(ls -l ${CUST_PATH} | awk '/^d/ {print $NF}') 

long_help_message="
build.sh help message as below:
   -h, --help, ?    report help message
   -u, USER         print USERNAME list， [userdebug as default]
   -p, porject      cur porject list

    ##----------------------------------------------------------------------##
    ## build.sh arguments include:                                          ##
    ##     PROJECTNAME, USERNAME                                            ##
    ##                                                                      ##
    ## build modle:                                                         ##
    ##    ./build.sh  PROJECTNAME USERNAME                                  ##
    ##                                                                      ##
    ## build sample:                                                        ##
    ##    ./build.sh -p Clound userdebug                                    ##
    ##----------------------------------------------------------------------##
"

__func_build_list()
{
    names=$1
    echo "$2 list:"
    for ((i=0; i<${#names[*]}; i++))
    {
       echo ${names[$i]}
    }
    exit 0;
}

__func_long_help_messge()
{
    echo "$long_help_message"
    exit 0
}

__func_clean()
{
    rm -rf $OUT_PATH
}

__func_compile()
{
    cd $OUT_CMAKE_PATH
    cmake $CUR_PATH
    # 输出make环境变量
    env > $OUT_PATH/environment.log
    # 1 标准输出  2标识标准错误   , tee 读取标准输入的数据，并将其内容输出成文件
    make 2>&1 | tee $OUT_PATH/compile.log
}

__func_help()
{
     for loop in $@
     do
         case $loop in
         ?|-h|*help)
                __func_long_help_messge
                break
                ;;
         -p|project)
                __func_build_list "${prolist[*]}" "PROLIST"
                break
                ;;
         -u|user*|eng)
                __func_build_list "${userlist[*]}" "USERLIST"
                break
                ;;
         -c|clean)
                __func_clean
                exit 0
                ;;
         *)
                break
                ;;
         esac
     done
}

__func_compile_pre()
{
    __func_clean
    mkdir -p $OUT_CMAKE_PATH
}

if [ "$(whoami)" = "root" ]; then
    echo "ERROR: do not use the BSP as root. Exiting..."
    exit 1
fi

# 开启nocasematch模式
shopt -s nocasematch

__func_help $1 $2

# 关闭nocasematch模式
shopt -u nocasematch

__func_compile_pre
__func_compile

echo "Build Succes... !!!"
