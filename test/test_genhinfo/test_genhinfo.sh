#!/bin/bash


echo "===> genhinfo default.sh"
genhinfo default.sh
echo "===> cat default.sh"
cat default.sh
echo "===> genhinfo default.sh"
genhinfo default.sh
echo "===> cat default.sh"
cat default.sh
rm -f default.sh


cp -p hello.sh{,.bak}
echo "===> cat hello.sh"
cat hello.sh
echo "===> genhinfo hello.sh"
genhinfo hello.sh
echo "===> cat hello.sh"
cat hello.sh
rm -f hello.sh
cp -p hello.sh.bak hello.sh
rm -f hello.sh.bak
