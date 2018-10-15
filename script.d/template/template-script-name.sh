#!/usr/bin/env bash

# flag for debug mode (true/false)
is_debug=true

# script root path
Q_ROOT_PATH=$(cd `dirname $0`; pwd)


function debug_print()
{
    local msg=$1
    [ "$is_debug" = "true" ] && {
        echo $msg
    }
}


function print_help_info()
{
    echo
    echo "Usage: $(basename $0) [options]"
    echo
    echo "Options:"
    echo "  -d    direction of synchronous"
    echo "  -h    display this help and exit"
    echo
}


function do_sync_from_win_to_linux()
{
    debug_print "===> do_sync_from_win_to_linux"
}

function do_sync_from_linux_to_win()
{
    debug_print "===> do_sync_from_linux_to_win"
}


# start here
# parse options
while getopts d:h ARGS; do
    debug_print "option: $ARGS"
    case $ARGS in
        d) direction="$OPTARG";;
        h) print_help_info; exit 0;;
        ?) print_help_info; exit 1;;
    esac
done


# dispatch according to action
# w2l: from windows to linux
# l2w: from linux to windows
echo "direction=$direction"
if [ "$direction" = "w2l" ]; then
    do_sync_from_win_to_linux
elif [ "$direction" = "l2w" ]; then
    do_sync_from_linux_to_win
fi

