#!/bin/bash

. $(dirname "$(realpath "$0")")/../../../common/bsh/message.bash

currentL1TaskNumber="$1"
totalL1TaskCount="$2"
packages="$3"

printStartingL1TaskTextBox "Debian packages installation"

currentL2TaskNumber=1

set -- $packages
totalL2TaskCount=$#

for package in $packages; do

	printStartingL2TaskTextBox "'$package' package installation"
	currentLvlTwoTaskStartTimeStamp=$(date +%s)

	#Print command and run it.
	command="apt-get install --yes $package"
	printExecutingCommand "$command"
	$command

	printCompletedL2TaskTextBoxAndIncrementCounter

done

printCompletedL1TaskTextBoxAndIncrementCounter