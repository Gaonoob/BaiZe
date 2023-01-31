#!/bin/bash

project_path=$(pwd)
code_path=${project_path}/code/
out_path=${project_path}/code/out

# 注释
#
#
#
#

machinelist=(Hisi Qualcomm)
distrolist=(console tiny initgc)
imagelist=(console docker minimal tiny prerootfs wayland)
userlist=(userdebug user eng)

long_help_message="
build.sh help message as below:
   -h, --help, ?    report help message
   -m, MACHINE      print MACHINENAME list
   -d, DISTRO       print DISTRONAME list
   -i, IMAGE        print IMAGENAME list
   -u, USER         print USERNAME list， [userdebug as default]

    ##--------------------------------------------------------------------##
    ## build.sh arguments include:                                        ##
    ##     MACHINENAME, DISTRONAME, IMAGENAME, USERNAME                   ##
    ##                                                                    ##
    ## build modle:                                                       ##
    ##    ./build.sh MACHINENAME+DISTRONAME+IMAGENAME USERNAME            ##
    ##                                                                    ##
    ## build sample:                                                      ##
    ##    ./build.sh sl8563-cpe-2h10+initgc+console userdebug             ##
    ##------------------------------------------------------------------- ##
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
    rm -rf $out_path
}

__func_compile()
{
    __func_clean
    mkdir -p $out_path
    cd $out_path
    # echo $out_path
    # echo $code_path
    cmake ../
    cd -
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
         -m|MACHINE)
                __func_build_list "${machinelist[*]}" "MACHINENAME"
                break
                ;;
         -d|DISTRO)
                __func_build_list "${distrolist[*]}" "DISTRONAME"
                break
                ;;
         -i|IMAGE)
                __func_build_list "${imagelist[*]}" "IMAGENAME"
                break
                ;;
         -u|USER*|ENG)
                __func_build_list "${userlist[*]}" "USERNAME"
                #break
                ;;
         -c|CLEAN)
                __func_clean
                exit 0
                ;;
         *)
                break
                ;;
         esac
     done
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

__func_compile





