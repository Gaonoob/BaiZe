#!/bin/bash

__func_clean()
{
    rm -rf $BUILD_PATH
}

__func_compile_pre()
{
    __func_clean
    mkdir -p $BUILD_PATH
    mkdir -p $OUT_LOG_CMAKE_PATH

    # 复制配置项
    cp -r $CUST_PATH/baize_base_info.cfg $BUILD_PATH/
    cp -r $CUST_PATH/$PROJECT_NAME/baize_cust_info.cfg $BUILD_PATH/

    # 复制camek
    cp -r $CUR_PATH/CMakeLists.txt $BUILD_PATH/

    # 代码定制复制
    cp -r $CUR_PATH/code $BUILD_PATH/
}

__func_compile()
{
    cd $OUT_LOG_CMAKE_PATH
    cmake $BUILD_PATH

    # 输出make环境变量
    env > $OUT_LOG_PATH/environment.log

    # 1 标准输出  2标识标准错误, tee 读取标准输入的数据，并将其内容输出成文件
    make 2>&1 | tee $OUT_LOG_PATH/compile.log
    echo "build start time:" $(date +"%Y-%m-%d %H:%M:%S") >> $OUT_LOG_PATH/compile.log
    echo "Compile Succesed !!!"
}

echo "PROJ:$PROJECT_NAME"
echo "MODE:$BUILD_MODE"

if [[ "$BUILD_MODE" == "clean" ]]; then
    __func_clean
    echo "Clean Succesed !!!"
    exit 0
fi

__func_compile_pre
__func_compile