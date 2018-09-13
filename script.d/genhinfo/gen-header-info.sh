#!/bin/bash

############################################################
# Author: Shellever
# Date:   11/03/2017 02:14:28
# Desc:   gen header information
# Email:  shellever@163.com
# Usage:  ./gen-header-info.sh FILE
# History: 
# 11/02/2017
# 1.complete basic function and gen header information
############################################################


function usage()
{
    echo
    echo "Usage: $(basename $0) FILE"
    echo
}

function gen_header_info()
{
    echo "#!/bin/bash"
    echo
    echo "############################################################"
    echo "# Author: Shellever"
    echo "# Date:   `date "+%m/%d/%Y %H:%M:%S"`"
    echo "# Desc:   N/A"
    echo "# Email:  shellever@163.com"
    echo "# Usage: "
    echo "# History: "
    echo "############################################################"
    echo 
}

if [ $# -ne 1 ]; then
    usage
    exit 1
fi
TO_FILE=$1
# replace globally
#30,45s/$1/$TO_FILE/g

if [ ! -f $TO_FILE ]; then
    gen_header_info > $TO_FILE
else
    grep "^# Author:" $TO_FILE > /dev/null
    if [ $? -ne 0 ]; then
        gen_header_info > hi.template
        sed -i '/^#!\/bin\/bash/r hi.template' $TO_FILE
        sed -i '1{/^#!\/bin\/bash/d}' $TO_FILE
        rm -f hi.template
    fi
fi

[ ! -x $TO_FILE ] && chmod 755 $TO_FILE

#has_header_file=0
#header_file=
#
#set -- `getopt -q f: "$@"`
#while [ -n "$1" ]; do
#    case $1 in
#        -f) 
#            has_header_file=1
#            header_file="$2"
#            shift;;
#        --)
#            shift
#            break;;
#        *)
#            usage;;
#    esac
#    shift
#done


