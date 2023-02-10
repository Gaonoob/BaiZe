#!/bin/bash

# 源目录
export CUR_PATH=$(pwd)
export CODE_PATH=${CUR_PATH}/code
export CUST_PATH=${CUR_PATH}/cust
export SCRIPTS_PATH=${CUR_PATH}/prebuilts/scripts


# 临时目录,仅用于定制覆盖 不会影响源代码
export BUILD_PATH=${CUR_PATH}/build

# 输出目录
export OUT_PATH=${BUILD_PATH}/out

# 输出Log目录
export OUT_LOG_PATH=${BUILD_PATH}/log
export OUT_LOG_CMAKE_PATH=${BUILD_PATH}/log/cmake # Log cmake目录

# 参数注释
BUILDMODE=(userdebug user clean scan)
PROJLIST=$(ls -l ${CUST_PATH} | awk '/^d/ {print $NF}')
MODELIST=${BUILDMODE[@]}

# 默认编译选项
PROJECT_NAME=ubuntu
BUILD_MODE=userdebug


###############################################################################
###############################################################################
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
    ##    ./build.sh -p ubuntu -m userdebug                                 ##
    ##----------------------------------------------------------------------##
"

# 打印Help
__func_long_help_messge()
{
    echo "$long_help_message"
    exit 0
}

# 打印错误原因
__func_print_err_messge()
{
    case $(($1)) in
        0)
            echo "ERROR: do not use the BSP as root."
            ;;
        1)
            echo "ERROR: Invalid argument."
            ;;
        *)
            echo "ERROR: Invalid argument."
            ;;
    esac

    echo "Build Eixt ..."
    exit 1
}

#在搜索$1,如果找不到$? 的值将会非0，所有用这个作为判断条件。
__func_check_argument()
{
    echo $1 | grep -wq $2
    if [  $? != 0  ];then
        __func_print_err_messge 1 #不位于列表
    fi
}

# 校验入参
__func_verify_input_parameter()
{
    # 参数大小写转换
    export PROJECT_NAME=$(echo "$PROJECT_NAME" | tr '[:upper:]' '[:lower:]')
    export BUILD_MODE=$(echo "$BUILD_MODE" | tr '[:upper:]' '[:lower:]')

    # 检查参数是否在List中
    __func_check_argument "$PROJLIST" "$PROJECT_NAME"
    __func_check_argument "$MODELIST" "$BUILD_MODE"
}

# 非 root 执行
if [ "$(whoami)" = "root" ]; then
    __func_print_err_messge 0
fi

# $@传入脚本的所有参数
ARGS=`getopt -n "build.sh" -o "hp:m:" -l "help,proj:,mode:" -- "$@"`

# eval 命令用于将其后的内容作为单个命令读取和执行，这里用于处理getopt命令生成的参数的转义字符。
eval set -- "${ARGS}"

while [ -n "$1" ]
do
    case "${1}" in
        -h | --help)
            echo "PROJLIST:" ${PROJLIST}
            echo "MODELIST: ${MODELIST}"
            __func_long_help_messge
            exit ;;
        -p | --proj)
            if [[ -n "${1}" ]]; then
                PROJECT_NAME=${2}
            fi
            shift;; #右移
        -m | --mode)
            if [[ -n "${1}" ]]; then
                BUILD_MODE=${2}
            fi
            shift;;
        --)
            shift
            break ;;
        *)
            __func_print_err_messge 1
    esac
    shift
done

__func_verify_input_parameter

bash $SCRIPTS_PATH/compile.sh

echo "Build Succesed !!!"
