#!/bin/bash

############################################################
# Author: Shellever
# Date:   11/03/2017 02:40:58
# Desc:   setup the tools 
# Email:  shellever@163.com
# Usage:  source xsetup.sh
# History: 
# 11/03/2017
# 1. complete the initial function
# 11/05/2017
# 1. create the config file xtools_config.sh, and source it
# in ~/.bashrc. 
# 01/06/2018
# 1. issues-20180106: 
# when config env var in xtools_config.sh, it cannot take an
# effect.
############################################################

# store the current path
PATH_CUR=`pwd`
#CFG_FILE="~/.bashrc"
#16,44s%~/\.bashrc%"$CFG_FILE"%g


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
echo >> ~/.bashrc
echo >> ~/.bashrc
echo "##############################">> ~/.bashrc
echo "# `whoami`" >> ~/.bashrc
echo "# `date "+%m/%d/%Y %H:%M:%S"`" >> ~/.bashrc
echo "export PATH_XTOOLS=$PATH_CUR" >> ~/.bashrc
echo "export PATH=\$PATH_XTOOLS/link.d:\$PATH" >> ~/.bashrc
echo >> ~/.bashrc
echo "[ -f \$PATH_XTOOLS/config/xtools_config.sh ] && . \$PATH_XTOOLS/config/xtools_config.sh" >> ~/.bashrc
echo "##############################">> ~/.bashrc
echo >> ~/.bashrc

# take an effect right now
source ~/.bashrc
echo
echo "The tools have successfully configured in ~/.bashrc"
echo

