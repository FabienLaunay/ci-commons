#!/bin/bash

. bsh/utilities/message.bash
. bsh/utilities/strings.bash

currentL1TaskNumber=4
totalL1TaskCount=4

# ==============================================================================
# Run Gitlint on every commit between the provided range
# ==============================================================================

# Print starting text box level 1.
message="Gitlint execution on new commits"
printStartingL1TaskTextBox "$message"
currentLvlOneTaskStartTimeStamp=$(date +%s)

commits=$(git rev-list $1..$2)

currentL2TaskNumber=1
totalL2TaskCount=$(echo "$commits" | wc -l)

gitlintFailed=false

for commit in $commits; do
  # Print starting text box level 2.
  message="Gitlint execution on commit ${commit:0:7}"
  printStartingL2TaskTextBox "$message"
  currentLvlTwoTaskStartTimeStamp=$(date +%s)

  #Print command and run it.
  command="gitlint --config cfg/gitlint/gitlint.cfg --commit $commit"
  printExecutingCommand "$command"
  $command
#  RESULT=$command
  if [[ $? -ne 0 ]]; then
      echo "RESULT=$RESULT"
      gitlintFailed=true  # Set flag if gitlint fails
  fi

  # Print completed text box level 2.
  currentLvlTwoTaskEndTimeStamp=$(date +%s)
  printCompletedL2TaskTextBoxAndIncrementCounter "$message" \
  "$((currentLvlTwoTaskEndTimeStamp - currentLvlOneTaskStartTimeStamp))"
done


  if [[ "$gitlintFailed" == true ]]; then
    printGuidanceHeader
    echo "One or more gitlint commands failed."
  fi


# Print completed text box level 1.
currentLvlOneTaskEndTimeStamp=$(date +%s)
printCompletedL1TaskTextBoxAndIncrementCounter "$message" \
  "$((currentLvlOneTaskEndTimeStamp - currentLvlOneTaskStartTimeStamp))"
