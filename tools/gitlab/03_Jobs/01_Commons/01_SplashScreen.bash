#!/bin/bash

messageBash=""

if [[ ! -z "$1" ]]; then
  messageBash="$1/"
fi

messageBash+="tools/common/bsh/message.bash"
. $messageBash

printLargeTextBox "$1"