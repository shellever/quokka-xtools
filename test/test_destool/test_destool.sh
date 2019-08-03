#!/usr/bin/env bash


# help info
destool -h

# encrypt
destool -e -k 1122334455667788 1234567887654321

# decrypt
destool -d -k 1122334455667788 1234567887654321


