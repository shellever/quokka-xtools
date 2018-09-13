#!/bin/bash

############################################################
# Author: Shellever
# Date:   12/17/2017 00:45:07
# Desc:   testing pkgxtools 
# Email:  shellever@163.com
# Usage: 
# History: 
############################################################

find . -type f -name *.zip -exec rm -f {} \;

pkgxtools ../../../xtools/

