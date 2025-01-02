#!/bin/bash

scriptDirectory=$(dirname "$(realpath "$0")")
#echo "[gitHookCommitMsg.bash] scriptDirectory ='${scriptDirectory}'"

toolsDirectory="${scriptDirectory%/git/hooks}"

#echo "[gitHookCommitMsg.bash] toolsDirectory  ='${toolsDirectory}'"

. $toolsDirectory/bsh/message.bash

# ==============================================================================
# Print header
# ==============================================================================

printLargeTextBoxForGitHooks "Commit Message Hook"

currentL1TaskNumber="1"
totalL1TaskCount="1"

# ==============================================================================
# Check user e-mail address
# ==============================================================================

printStartingL1TaskTextBox "user e-mail address verification"

command="$toolsDirectory/bsh/checkEmail.bash"
printExecutingCommand "$command"
$command

if [[ $? -ne 0 ]]; then
  printCompletedL1TaskTextBoxAndIncrementCounter
  exit 1
fi
printCompletedL1TaskTextBoxAndIncrementCounter
