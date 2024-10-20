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

failureCount=0
actions=()

for commit in $commits; do
  # Print starting text box level 2.
  commitShort=${commit:0:8}
  message="Gitlint execution on commit $commitShort"
  printStartingL2TaskTextBox "$message"
  currentLvlTwoTaskStartTimeStamp=$(date +%s)

  commitMessage=$(git log -1 --pretty=%s $commit)

  #Print command and run it.
  command="gitlint --config cfg/gitlint/gitlint.cfg --commit $commitShort"
  printExecutingCommand "$command"
  RESULT=$($command)

  if [[ $? -ne 0 ]]; then
    ((failureCount++))
      actions+=("reword $commitShort $commitMessage")
  else
      actions+=("pick $commitShort $commitMessage")
  fi

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
      printSuccessMessage "Git commit message is valid."
    else
      printSuccessMessage "All of $totalL2TaskCount Git commit messages are valid."
    fi
  else
    if [[ $totalL2TaskCount -eq 1 ]]; then
      printErrorMessage "Git commit message is not valid."
    else
      printErrorMessage "$failureCount out of $totalL2TaskCount Git commit messages are not valid."
    fi
    printGuidanceHeader
    echo "1.Run the following command to open the default Git text editor:"
    echo $NEW_LINE
    echo "  $ git rebase --interactive HEAD~$totalL2TaskCount"
    echo $NEW_LINE
    echo "2.Replace the content of the editor by the following one:"
    echo $NEW_LINE
    printBorder 80 "#" $FG_COLOR_WHITE $BG_COLOR_BLACK
    for (( i=${#actions[@]}-1; i>=0; i-- )); do
      echo "${actions[i]}"
    done
    printBorder 80 "#" $FG_COLOR_WHITE $BG_COLOR_BLACK
    echo $NEW_LINE
    echo "3.Modify every Git commit message to fix errors reported above by Gitlint."
  fi

# Print completed text box level 1.
currentLvlOneTaskEndTimeStamp=$(date +%s)
printCompletedL1TaskTextBoxAndIncrementCounter "$message" \
  "$((currentLvlOneTaskEndTimeStamp - currentLvlOneTaskStartTimeStamp))"

if [[ $failureCount -eq 0 ]]; then
  exit 0
else
  exit 1
fi