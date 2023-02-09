#!/bin/bash

# 源目录
export CUR_PATH=$(pwd)
export CODE_PATH=${CUR_PATH}/code
export CUST_PATH=${CUR_PATH}/cust
export SCRIPTS_PATH=${CUR_PATH}/prebuilts/scripts

# 输出目录
export OUT_PATH=${CUR_PATH}/out
export OUT_CMAKE_PATH=${CUR_PATH}/out/cmakelog

# 临时目录,仅用于定制覆盖 不会影响源代码
export TMP_PATH=${CUR_PATH}/build

# 默认编译选项
export PROJECT_NAME=Ubuntu
export BUILD_MODE=userdebug

# 参数注释
modelist=(userdebug user clean)
projlist=$(ls -l ${CUST_PATH} | awk '/^d/ {print $NF}')

long_help_message="
build.sh help message as below:
    -h, --help       report help message
    -p, --porj       porject
    -m, --mode       build mode

    ##----------------------------------------------------------------------##
    ## build.sh arguments include:                                          ##
    ##     PROJLIST, MODELIST                                               ##
    ##                                                                      ##
    ## build modle:                                                         ##
    ##    ./build.sh  -p PROJLIST -m MODELIST                               ##
    ##    ./build.sh  --proj PROJLIST --mode MODELIST                       ##
    ##                                                                      ##
    ## build sample:                                                        ##
    ##    ./build.sh -p Clound -m userdebug                                 ##
    ##----------------------------------------------------------------------##
"

__func_build_list()
{
    names=$1
    echo "$2 LIST:"
    for ((i=0; i<${#names[*]}; i++))
    {
       echo ${names[$i]}
    }
}

__func_long_help_messge()
{
    echo "$long_help_message"
    exit 0
}

__func_clean()
{
    rm -rf $OUT_PATH
    echo "Clean Succesed !!!"
}

__func_compile_pre()
{
    __func_clean
    mkdir -p $OUT_CMAKE_PATH
    mkdir -p $TMP_PATH
}

# 非 root 执行
if [ "$(whoami)" = "root" ]; then
    echo "ERROR: do not use the BSP as root. Exiting..."
    exit 1
fi

# $@传入脚本的所有参数
ARGS=`getopt -n "build.sh" -o "hp:m:" -l "help,proj:,mode:" -- "$@"`

# eval 命令用于将其后的内容作为单个命令读取和执行，这里用于处理getopt命令生成的参数的转义字符。
eval set -- "${ARGS}"

while [ -n "$1" ]
do
    case "${1}" in
        -h | --help)
            __func_build_list "${projlist[*]}" "PROJLIST"
            __func_build_list "${modelist[*]}" "MODELIST"
            __func_long_help_messge
            exit ;;
        -p | --proj)
            if [[ -n "${1}" ]]; then
                PROJECT_NAME=${2}
            fi
            shift;; # 右移
        -m | --mode)
            if [[ -n "${1}" ]]; then
                BUILD_MODE=${2}
            fi
            shift;;
        --)
            shift
            break ;;
        *)
            echo "$1 is not an option"
            exit 1 ;;  # 发现未知参数，直接退出
    esac
    shift
done

# 校验参数

# __func_compile_pre

#sh $SCRIPTS_PATH/compile.sh
echo "Build Succesed !!!"
