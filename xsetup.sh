#!/bin/bash

############################################################
# Author: Shellever
# Date:   11/03/2017 02:40:58
# Desc:   setup the tools 
# Email:  shellever@163.com
############################################################

# store the current path
PATH_CUR=`pwd`
# in first, export it for source configme.sh
export PATH_XTOOLS=$PATH_CUR


# make sure thath link.d has existed
mkdir -p link.d

# remove the previous symbolic links
echo "===> remove the previous symbolic links"
for link in `find link.d -type l`; do
    echo "rm -f $link"
    rm -f $link
done

echo

# create symbolic links through sourcing the script configme.sh
echo "===> source configme.sh to create symbolic links"
for conf in `find script.d -type f -name configme.sh`; do
    echo "source $conf"
    source $conf
done

echo


# check if have configured 
echo "===> check if have configured in ~/.bashrc"
[ ! -f ~/.bashrc ] && touch ~/.bashrc 
grep "^export PATH_XTOOLS=" ~/.bashrc > /dev/null
if [ $? -eq 0 ]; then
    echo "The tools have already configured in ~/.bashrc"
    return 0
fi

# firstly take a backup, and then append the configured lines
cp -p ~/.bashrc{,.bak.`date "+%Y%m%d_%H%M%S"`}
cat >> ~/.bashrc << ok

##################################################
# quokka-xtools configs
# `date "+%m/%d/%Y %H:%M:%S"`
export PATH_XTOOLS=$PATH_CUR
export PATH=\$PATH_XTOOLS/link.d:\$PATH

[ -f \$PATH_XTOOLS/config/xtools_config.sh ] && {
    . \$PATH_XTOOLS/config/xtools_config.sh
}
##################################################

ok


# take an effect right now
source ~/.bashrc
echo
echo "The tools have successfully configured in ~/.bashrc"
echo

