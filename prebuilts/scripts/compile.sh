#!/bin/bash

__func_compile_pre()
{
    __func_clean
    mkdir -p $OUT_CMAKE_PATH
    mkdir -p $TMP_PATH
}

__func_compile()
{
    cd $OUT_CMAKE_PATH
    cmake $CUR_PATH
    # 输出make环境变量
    env > $OUT_PATH/environment.log
    # 1 标准输出  2标识标准错误, tee 读取标准输入的数据，并将其内容输出成文件
    make 2>&1 | tee $OUT_PATH/compile.log
    echo "build start time:" $(date +"%Y-%m-%d %H:%M:%S") >> $OUT_PATH/compile.log
}

__func_compile_pre
__func_compile
