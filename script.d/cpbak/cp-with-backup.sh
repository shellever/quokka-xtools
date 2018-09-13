#!/bin/bash

############################################################
# Author: Shellever
# Date:   11/03/2017 05:34:20
# Desc:   backup file or directory
# Email:  shellever@163.com
# Usage:  ./cp-with-backup.sh <file|directory>
# History: 
############################################################



IS_DEBUG=1

function idebug()
{
    [ $# -eq 1 ] && {
        [ $IS_DEBUG -eq 1 ] && echo $1
    }
}

function usage()
{
    echo 
    echo "Usage: $(basename $0) <FILE|DIR>"
    echo
}

if [ $# -ne 1 ]; then
    usage
    exit 1
fi

if [ -f "$1" ]; then
    cp -p "$1"{,.`date "+%Y%m%d_%H%M%S"`}
elif [ -d "$1" ]; then
    cp -Rp "$1"{,-`date "+%Y%m%d_%H%M%S"`}
else
    usage
fi
