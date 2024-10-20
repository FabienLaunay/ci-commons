#!/bin/bash

. bsh/utilities/message.bash

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
# Install the 'git' package (prerequisite for gitlint)
# ==============================================================================

# Print starting text box level 1.
message="'git' Debian package installation"
printStartingL1TaskTextBox "$message"
currentLvlOneTaskStartTimeStamp=$(date +%s)

#Print command and run it.
command="apt-get install --yes git"
printExecutingCommand "$command"
$command

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
