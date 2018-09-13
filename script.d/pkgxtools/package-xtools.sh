#!/bin/bash

############################################################
# Author: Shellever
# Date:   12/16/2017 23:44:36
# Desc:   package xtools
# Email:  shellever@163.com
# Usage: 
# History: 
############################################################

# turn on debug mode
set -x

LOCAL_PATH=$(pwd)
SPEC_PATH="./"

function usage()
{
    echo
    echo "Usage: $(basename $0) [path_xtools]"
    echo
}

if [ $# -gt 1 ]; then
    usage
    exit 0
fi

test $# -eq 1 && SPEC_PATH="$1"

cd $LOCAL_PATH/$SPEC_PATH
cd ..
pwd
XTOOLS_VERSION=`grep -P "^XTOOLS_VERSION=" $PATH_XTOOLS/config/xtools_config.sh | sed 's/^XTOOLS_VERSION=//g'`
XTOOLS_RELEASE=`grep -P "^XTOOLS_RELEASE=" $PATH_XTOOLS/config/xtools_config.sh | sed 's/^XTOOLS_RELEASE=//g'`
XTOOLS_EXTRAVERSION=`grep -P "^XTOOLS_EXTRAVERSION=" $PATH_XTOOLS/config/xtools_config.sh | sed 's/^XTOOLS_EXTRAVERSION=//g'`
zip -ry $LOCAL_PATH/xtools-v$XTOOLS_VERSION.$XTOOLS_RELEASE.$XTOOLS_EXTRAVERSION-$(date +%Y%m%d_%H%M%S).zip xtools/

