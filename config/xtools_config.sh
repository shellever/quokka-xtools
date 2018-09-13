#!/bin/bash

############################################################
# Author: Shellever
# Date:   12/17/2017 13:35:54
# Desc:   config file for xtools
# Email:  shellever@163.com
# Usage:  source it in ~/.bashrc 
# History: 
# 12/16/2017
# add xtools version information
############################################################

# xtools version and release
XTOOLS_VERSION=1
XTOOLS_RELEASE=0
XTOOLS_EXTRAVERSION=0

# env var config
export PS1="\[\e[32m\]Curdir\[\e[31m\]: \[\e[0m\]\w\n\[\e[33m\]\u@\h\[\e[0m\]\[\e[32m\]$\[\e[0m\] "


# alias config
# compat Windows
alias dir='ls'
alias cls='clear'

alias cd1='cd ..'
alias cd2='cd ../../'
alias cd3='cd ../../../'
alias cdx="cd $PATH_XTOOLS"
alias grepstr='grep -rn'
alias grepistr='grep -rin'
alias findfile='find -type f -name'
alias sinstall='sudo apt-get install'

