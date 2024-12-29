#!/bin/bash

script_dir=$(dirname "$(realpath "$0")")

#echo "script_dir ='$script_dir'"

#messageBash=""

#if [[ ! -z "$1" ]]; then
#  messageBash="$1/"
#fi

#messageBash+="tools/common/bsh/message.bash"
#. $messageBash

. ../../../common/bsh/message.bash

printLargeTextBox "$1"