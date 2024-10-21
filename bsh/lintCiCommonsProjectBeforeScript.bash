#!/bin/bash

. bsh/utilities/message.bash

packages="$1"

printLargetTextBox "Git Commit Messages Linter"

currentL1TaskNumber=1
totalL1TaskCount=5

# ==============================================================================
# Update Debian-based Gitlab Linux runner local package index.
# ==============================================================================

# Print starting text box level 1.
message="Gitlab runner local package index update"
printStartingL1TaskTextBox "$message"
currentLvlOneTaskStartTimeStamp=$(date +%s)

#Print command and run it.
command="apt-get update"
printExecutingCommand "$command"
$command

# Print completed text box level 1.
currentLvlOneTaskEndTimeStamp=$(date +%s)
printCompletedL1TaskTextBoxAndIncrementCounter "$message" \
  "$((currentLvlOneTaskEndTimeStamp - currentLvlOneTaskStartTimeStamp))"

# ==============================================================================
# Install Debian packages
# ==============================================================================

# Print starting text box level 1.
message="Debian packages installation"
printStartingL1TaskTextBox "$message"
currentLvlOneTaskStartTimeStamp=$(date +%s)

currentL2TaskNumber=1

set -- $packages
totalL2TaskCount=$#

for package in $packages; do

  # ----------------------------------------------------------------------------
  # Install one package at a time
  # ----------------------------------------------------------------------------

  # Print starting text box level 2.
  message="'$package' package installation"
  printStartingL2TaskTextBox "$message"
  currentLvlTwoTaskStartTimeStamp=$(date +%s)


  #Print command and run it.
  command="apt-get install --yes $package"
  printExecutingCommand "$command"
  $command

  # Print completed text box level 2.
  currentLvlTwoTaskEndTimeStamp=$(date +%s)
  printCompletedL2TaskTextBoxAndIncrementCounter "$message" \
    "$((currentLvlTwoTaskEndTimeStamp - currentLvlTwoTaskStartTimeStamp))"

done

# Print completed text box level 1.
currentLvlOneTaskEndTimeStamp=$(date +%s)
printCompletedL1TaskTextBoxAndIncrementCounter "$message" \
  "$((currentLvlOneTaskEndTimeStamp - currentLvlOneTaskStartTimeStamp))"

# ==============================================================================
# Install the 'gitlint' package using Python package installer
# ==============================================================================

# Print starting text box level 1.
message="'gitlint' Python package installation"
printStartingL1TaskTextBox "$message"
currentLvlOneTaskStartTimeStamp=$(date +%s)

#Print command and run it.
command="pip install gitlint"
printExecutingCommand "$command"
$command

# Print completed text box level 1.
currentLvlOneTaskEndTimeStamp=$(date +%s)
printCompletedL1TaskTextBoxAndIncrementCounter "$message" \
  "$((currentLvlOneTaskEndTimeStamp - currentLvlOneTaskStartTimeStamp))"
