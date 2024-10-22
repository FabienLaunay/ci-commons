#!/bin/bash

. bsh/utilities/message.bash

packages="$1"

printLargeTextBox "Git Commit Messages Linter"

currentL1TaskNumber=1
totalL1TaskCount=4

# ==============================================================================
# Install Debian packages
# ==============================================================================

printStartingL1TaskTextBox "Debian packages installation"

currentL2TaskNumber=1

set -- $packages
totalL2TaskCount=$#

for package in $packages; do

	# ----------------------------------------------------------------------------
	# Install one package at a time
	# ----------------------------------------------------------------------------

	printStartingL2TaskTextBox "'$package' package installation"
	currentLvlTwoTaskStartTimeStamp=$(date +%s)

	#Print command and run it.
	command="apt-get install --yes $package"
	printExecutingCommand "$command"
	$command

	printCompletedL2TaskTextBoxAndIncrementCounter

done

printCompletedL1TaskTextBoxAndIncrementCounter

# ==============================================================================
# Install the 'gitlint' package using Python package installer
# ==============================================================================

printStartingL1TaskTextBox "'gitlint' Python package installation"
currentLvlOneTaskStartTimeStamp=$(date +%s)

#Print command and run it.
command="pip install gitlint"
printExecutingCommand "$command"
$command

printCompletedL1TaskTextBoxAndIncrementCounter
