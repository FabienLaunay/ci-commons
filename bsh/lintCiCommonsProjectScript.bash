#!/bin/bash

. bsh/utilities/message.bash
. bsh/utilities/actions.bash

currentL1TaskNumber=4
totalL1TaskCount=5

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

lintCount=0
failureCount=0
modifyFrom=-1
actions=()

for commit in $commits; do
  # Print starting text box level 2.
  message="Gitlint execution on commit ${commit:0:7}"
  printStartingL2TaskTextBox "$message"
  currentLvlTwoTaskStartTimeStamp=$(date +%s)

  #Print command and run it.
  command="gitlint --config cfg/gitlint/gitlint.cfg --commit $commit"
  printExecutingCommand "$command"
  $command

  if [[ $? -ne 0 ]]; then
      if [[ $modifyFrom -eq -1 ]]; then
        modifyFrom=$(($totalL2TaskCount-$lintCount))
      fi
      ((failureCount++))
      actions+=("reword $COMMIT $COMMIT_MESSAGE")
    else
      actions+=("pick $COMMIT $COMMIT_MESSAGE")
  fi

  ((lintCount++))

  # Print completed text box level 2.
  currentLvlTwoTaskEndTimeStamp=$(date +%s)
  printCompletedL2TaskTextBoxAndIncrementCounter "$message" \
  "$((currentLvlTwoTaskEndTimeStamp - currentLvlOneTaskStartTimeStamp))"
done

# Print completed text box level 1.
currentLvlOneTaskEndTimeStamp=$(date +%s)
printCompletedL1TaskTextBoxAndIncrementCounter "$message" \
  "$((currentLvlOneTaskEndTimeStamp - currentLvlOneTaskStartTimeStamp))"

# ==============================================================================
# Run Gitlint on every commit between the provided range
# ==============================================================================

# Print starting text box level 1.
message="Gitlint report generation"
printStartingL1TaskTextBox "$message"
currentLvlOneTaskStartTimeStamp=$(date +%s)

  if [[ $failureCount -eq 0 ]]; then
    if [[ $totalL2TaskCount -eq 1 ]]; then
      echo "Git commit message is valid."
    else
      echo "All of $totalL2TaskCount Git commit messages are valid."
    fi
  else
    if [[ $totalL2TaskCount -eq 1 ]]; then
      echo "Git commit message is not valid."
    else
      echo "failureCount out of $totalL2TaskCount Git commit messages are not valid."
    fi
    echo "1.Run the following command to open the default Git text editor:"
    echo "  $ git rebase --interactive HEAD~$modifyFrom"
    echo $NEW_LINE
    echo "2.Replace the content of the editor by the following one:"
    echo "###################################"
    for action in "${actions[@]}"; do
      echo "$action"
    done    
    echo "###################################"
  fi

# Print completed text box level 1.
currentLvlOneTaskEndTimeStamp=$(date +%s)
printCompletedL1TaskTextBoxAndIncrementCounter "$message" \
  "$((currentLvlOneTaskEndTimeStamp - currentLvlOneTaskStartTimeStamp))"
