#!/bin/bash

############################################################
# Author: Shellever
# Date:   11/25/2017 23:16:53
# Desc:   check file format
# Email:  shellever@163.com
# Usage:  ffcheck <FILE|DIR>
# History: 
# 11/25/2017
# complete the initial functionality
# after the future
# automatically find shell script and check it
# 11/27/2017
# implement to find shell script automatically and check it
# 12/03/2017
# check array to config
############################################################

# turn on debug
#set -x

# array to check
CHECK_ARR=(
sh
py
exp
lua
pl
)


function usage()
{
    echo
    echo "Usage: `basename $0` <FILE|DIR>"
    echo
}

if [ $# -ne 1 ]; then
    usage
    exit 1
fi

function ffcheck()
{
    file $1 | grep "CRLF" > /dev/null
    if [ $? -eq 0  ]; then
        echo -e "check file: \033[1;32m$1\033[0m, format: \033[1;33mWindows(CRLF)\033[0m"
    else
        echo -e "check file: \033[1;32m$1\033[0m, format: \033[1;33mUnix(LF)\033[0m"
    fi
}

if [ -d $1 ]; then
    for fformat in "${CHECK_ARR[@]}"; do
        for file in `find $1 -type f -name '*.'$fformat`; do
            ffcheck $file
        done
    done
    #for file in `find $1 -type f -name *.sh`; do
    #    ffcheck $file
    #done
elif [ -f $1 ]; then
    ffcheck $1
else
    echo "not supported now"
fi

