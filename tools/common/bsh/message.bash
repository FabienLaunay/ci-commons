#!/bin/bash

# #############################################################################
# Copyright (C) 2023-2024 Fabien Launay. All Rights Reserved.
# Author: Fabien Launay.
# Email : fabien.launay.email@gmail.com.
# Source: This file is part of the "Reactor Coding Challenge 01" project Git
#         repository developed by Fabien Launay for Woven by Toyota.
# Usage : This copyright notice may not be removed from this file.
# #############################################################################

. $(dirname "$(realpath "$0")")/../../common/bsh/format.bash
. $(dirname "$(realpath "$0")")/../../common/bsh/strings.bash

# #############################################################################
# This bash file contains functions that perform operations related to message
# printing and prompting.
#
# Author: Fabien Launay (fabien.launay.email@gmail.com)
#
# #############################################################################

# =============================================================================
# Print bash script tasks.
#
# Prints to the terminal the list of tasks to be executed by a bash script.
#
# @param $1 Tasks to be printed to the terminal.
#
# @return 0
# =============================================================================

currentLvlOneTaskStartTimeStamp=""
currentLvlOneMessage=""
currentLvlTwoTaskStartTimeStamp=""
currentLvlTwoMessage=""

printBashScriptTasks() {
	local tasks=$1
	echo "$NEW_LINE"
	echo "This Bash script will perform the following task(s):"
	echo -e "$tasks"
	return 0
}

# =============================================================================
# Ask user to continue.
#
# Prints to the terminal a message asking the user whether to continue or not.
# Terminates the script if the user presses a key other than 'y' and 'Y'.
#
# @return 0 if user presses the 'y' or 'Y' key.
# =============================================================================

askUserToContinue() {
	echo "$NEW_LINE"
	read \
		-p "Press Y to continue or any other key to cancel: " \
		-n 1 \
		-r
	echo "$NEW_LINE"
	echo "$NEW_LINE"
	if [[ $REPLY =~ ^[Yy]$ ]]; then
		return 0
	else
		exit 0
	fi
}

# =============================================================================
# Print border.
#
# Prints to the terminal the same character multiple times, with the specified
# foreground and background colors.
#
# Example: The following command:
#
#   ------------------------------------
#   printBorder 30 '~' '\e[31m' '\e[42m'
#   ------------------------------------
#
#   would print the following characters to the terminal (red foreground color,
#   green background color):
#
#   ------------------------------------
#   ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#   ------------------------------------
#
# @param $1 Number of times to print the character.
# @param $2 Character to print.
# @param $3 ANSI escape sequence code for the character foreground color.
# @param $4 ANSI escape sequence code for the character background color.
#
# @return 0 if user presses the 'y' or 'Y' key.
# =============================================================================

printBorder() {
	local width=$1
	local character=$2
	local fgColor=$3
	local bgColor=$4

	# Store the sequence of characters to be printed in the `border` variable.
	printf -v border "$character%.0s" $(seq 1 $width)

	# Print the characters to the terminal surrounded by the appropriate ANSI
	# escape sequence codes
	echo -e $fgColor$bgColor$border$UNSET_STYLE_ALL

	return 0
}

# =============================================================================
# Print delimited line.
#
# Prints to the terminal a message of specified length, delimited by a
# character, with the specified foreground and background colors, and
# optionally centered.
#
# Example: The following commands:
#
#   ------------------------------------
#   printDelimitedLine 10 '~' '\e[31m' '\e[42m' 'L' 'This text is not centered'
#   printDelimitedLine 10 '~' '\e[31m' '\e[42m' 'C' 'This text is centered'
#   ------------------------------------
#
#   would print the following lines to the terminal (red foreground color,
#   green background color):
#
#   ------------------------------------
#   ~ This text is not centered  ~
#   ~   This text is centered    ~
#   ------------------------------------
#
# @param $1 Line length.
# @param $2 Character used to surround the message.
# @param $3 ANSI escape sequence code for the line foreground color.
# @param $4 ANSI escape sequence code for the line background color.
# @param $5 Alignment (centered if value is "C", left-aligned otherwise).
# @param $6 Message to be printed on the line.
#
# @return 0.
# =============================================================================

printDelimitedLine() {
	local lineLength=$1
	local character=$2
	local fgColor=$3
	local bgColor=$4
	local alignment=$5
	local message=$6

	local messageLength=${#message}

	# Store the sequence of characters to be printed in the `border` variable.
	if ((messageLength > lineLength)); then
		printf -v line "$character $message $character"
	else
		if [ "$alignment" = "C" ]; then
			paddingSize=$((lineLength - messageLength))
			rightPaddingSize=$((paddingSize / 2))
			leftPaddingSize=$((rightPaddingSize - paddingSize))
			printf -v line "%*s$message%*s" \
				$leftPaddingSize $character $rightPaddingSize $character
		else
			paddingSize=$((lineLength - messageLength - 2))
			printf -v line "$character $message%*s" $paddingSize $character
		fi
	fi

	# Print the characters to the terminal surrounded by the appropriate ANSI
	# escape sequence codes
	echo -e $fgColor$bgColor"$line"$UNSET_STYLE_ALL

	return 0
}

# =============================================================================
# Print large text box.
#
# Prints to the terminal a message centered in a pre-formatted text box,
# surrounded by the application and author names.
#
# @param $1 Message to be printed in the pre-formatted text box.
#
# @return 0.
# =============================================================================

printLargeTextBox() {
	application=$1
	message=$2
	CHARACTER="#"
	WIDTH=80

	echo "$NEW_LINE"

	printBorder $WIDTH $CHARACTER $FG_COLOR_WHITE $BG_COLOR_GREEN

	printDelimitedLine $WIDTH $CHARACTER $FG_COLOR_WHITE $BG_COLOR_GREEN "L" \
		""
	printDelimitedLine $WIDTH $CHARACTER $FG_COLOR_WHITE $BG_COLOR_GREEN "C" \
		"$application"
	printDelimitedLine $WIDTH $CHARACTER $FG_COLOR_WHITE $BG_COLOR_GREEN "L" \
		""
	printDelimitedLine $WIDTH $CHARACTER $FG_COLOR_WHITE $BG_COLOR_GREEN "C" \
		"$message"
	printDelimitedLine $WIDTH $CHARACTER $FG_COLOR_WHITE $BG_COLOR_GREEN "L" \
		""
	printDelimitedLine $WIDTH $CHARACTER $FG_COLOR_WHITE $BG_COLOR_GREEN "C" \
		"Author: Fabien Launay (fabien.launay.email@gmail.com) "
	printDelimitedLine $WIDTH $CHARACTER $FG_COLOR_WHITE $BG_COLOR_GREEN "L" \
		""

	printBorder $WIDTH $CHARACTER $FG_COLOR_WHITE $BG_COLOR_GREEN

	return 0
}

# =============================================================================
# Print large text box for CI-JOBS.
#
# Prints to the terminal a message centered in a pre-formatted text box,
# surrounded by 'CI-JOBS - Version 1.0.0' and author name.
#
# @param $1 Message to be printed in the pre-formatted text box.
#
# @return 0.
# =============================================================================

printLargeTextBoxForCiJobs() {
  printLargeTextBox "CI-JOBS - Version 1.0.0" "$1"
}

# =============================================================================
# Print large text box for CI-JOBS.
#
# Prints to the terminal a message centered in a pre-formatted text box,
# surrounded by 'GIT-HOOKS - Version 1.0.0' and author name.
#
# @param $1 Message to be printed in the pre-formatted text box.
#
# @return 0.
# =============================================================================

printLargeTextBoxForGitHooks() {
  printLargeTextBox "GIT-HOOKS - Version 1.0.0" "$1"
}

# =============================================================================
# Print normal text box.
#
# Prints to the terminal a message left-aligned in a pre-formatted text box.
#
# @param $1 ANSI escape sequence code for the text box foreground color.
# @param $2 ANSI escape sequence code for the text box background color.
# @param $3 Character used to make the borders of the text box.
# @param $4 Message to be printed in the pre-formatted text box.
#
# @return 0.
# =============================================================================

printNormalTextBox() {

	local fgColor=$1
	local bgColor=$2
	local character=$3
	local message=$4

	WIDTH=80

	printBorder $WIDTH $character $fgColor $bgColor
	printDelimitedLine $WIDTH $character $fgColor $bgColor "L" "$message"
	printBorder $WIDTH $character $fgColor $bgColor
	echo "$NEW_LINE"

	return 0
}

# =============================================================================
# Print staring level 1 task text box.
#
# Prints to the terminal a staring task message in a pre-formatted text box
# whose:
# - Border is the "=" character
# - Foreground text color is white.
# - Background text color is blue.
#
# @param $1 Message to be printed in the text box.
#
# @return 0.
# =============================================================================

printStartingL1TaskTextBox() {
	currentLvlOneMessage=$1

	echo "$NEW_LINE"

	printNormalTextBox \
		$FG_COLOR_WHITE \
		$BG_COLOR_BLUE \
		"=" \
		"[$currentL1TaskNumber/$totalL1TaskCount] Starting $currentLvlOneMessage..."

	currentLvlOneTaskStartTimeStamp=$(date +%s)

	return 0
}

# =============================================================================
# Print completed level 1 task text box and increment level 1 task counter.
#
# Prints to the terminal a completed task message, including the task execution
# duration, in a pre-formatted text box whose:
# - Border is the "=" character
# - Foreground text color is black.
# - Background text color is bright blue.
#
# @param $1 Message to be printed in the text box.
# @param $2 Duration of the completed task.
#
# @return 0.
# =============================================================================

printCompletedL1TaskTextBoxAndIncrementCounter() {

	local currentLvlOneTaskEndTimeStamp=$(date +%s)
	duration=$((currentLvlOneTaskEndTimeStamp - currentLvlOneTaskStartTimeStamp))

	echo "$NEW_LINE"

	# Store in the  `hhmmss` variable the task execution duration in the
	# `hh:mm:ss` format.
	printf -v hhmmss \
		'%02dh:%02dm:%02ds' \
		$((duration / 3600)) $((duration % 3600 / 60)) $((duration % 60))

	# Print to the terminal the pre-formatted text box.
	printNormalTextBox \
		$FG_COLOR_BLACK \
		$BG_COLOR_BRIGHT_BLUE \
		"=" \
		"[$currentL1TaskNumber/$totalL1TaskCount] Completed $currentLvlOneMessage in $hhmmss"
	((currentL1TaskNumber++))

	return 0
}

# =============================================================================
# Print staring level 2 task text box.
#
# Prints to the terminal a staring task message in a pre-formatted text box
# whose:
# - Border is the "+" character
# - Foreground text color is white.
# - Background text color is yellow.
#
# @param $1 Message to be printed in the text box.
#
# @return 0.
# =============================================================================

printStartingL2TaskTextBox() {
	currentLvlTwoMessage=$1

	echo "$NEW_LINE"

	printNormalTextBox \
		$FG_COLOR_WHITE \
		$BG_COLOR_YELLOW \
		"+" \
		"[$currentL2TaskNumber/$totalL2TaskCount] Starting $currentLvlTwoMessage..."

	currentLvlTwoTaskStartTimeStamp=$(date +%s)

	return 0
}

# =============================================================================
# Print completed level 2 task text box and increment level 2 task counter.
#
# Prints to the terminal a completed task message, including the task execution
# duration, in a pre-formatted text box whose:
# - Border is the "+" character
# - Foreground text color is black.
# - Background text color is bright yellow.
#
# @param $1 Message to be printed in the text box.
# @param $2 Duration of the completed task.
#
# @return 0.
# =============================================================================

printCompletedL2TaskTextBoxAndIncrementCounter() {
	local currentLvlTwoTaskEndTimeStamp=$(date +%s)
	duration=$((currentLvlTwoTaskEndTimeStamp - currentLvlTwoTaskStartTimeStamp))

	echo "$NEW_LINE"

	# Store in the  `hhmmss` variable the task execution duration in the
	# `hh:mm:ss` format.
	printf -v hhmmss \
		'%02dh:%02dm:%02ds' \
		$((duration / 3600)) $((duration % 3600 / 60)) $((duration % 60))

	# Print to the terminal the pre-formatted text box.
	printNormalTextBox \
		$FG_COLOR_BLACK \
		$BG_COLOR_BRIGHT_YELLOW \
		"+" \
		"[$currentL2TaskNumber/$totalL2TaskCount] Completed $currentLvlTwoMessage in $hhmmss"
	((currentL2TaskNumber++))

	return 0
}

# =============================================================================
# Execute L2 task.
#
# Prints to the terminal messages related to L2 task execution start and
# completion, and execute the task.
#
# @param $1 Message to print in the staring / completed L2 task text boxes.
# @param $2 Command corresponding to the task to be executed.
#
# @return 0.
# =============================================================================

executeL2Task() {
	local message=$1
	local command=$2

	# Print staring L2 task text box and store start date.
	printStartingL2TaskTextBox "$message"
	currentLvlTwoTaskStartTimeStamp=$(date +%s)

	# Print execute command message and execute the task
	printExecutingCommand "$command"
	eval $command

	# Store end date and print completed L2 task text box.
	printCompletedL2TaskTextBoxAndIncrementCounter

	return 0
}

# =============================================================================
# Print various messages.
#
# Prints to the terminal various messages shared across multiple Bash scripts.
# =============================================================================
printSuccessMessage() {
	local header="SUCCESS: "
	local message=$1
	echo -e $FG_COLOR_GREEN$header$UNSET_STYLE_ALL$message
	echo "$NEW_LINE"
}

printErrorMessage() {
	local header="ERROR: "
	local message=$1
	echo -e $FG_COLOR_BRIGHT_RED$header$UNSET_STYLE_ALL$message
	echo "$NEW_LINE"
}

printRemarksHeader() {
	echo "$NEW_LINE"
	echo 'REMARKS(S):'
	return 0
}

printTaskFailureWarningsHeader() {
	echo "$NEW_LINE"
	echo 'WARNING(S): Above task(s) will fail if:'
	return 0
}

printGuidanceHeader() {
	local header="GUIDANCE: "
	echo -e $FG_COLOR_BRIGHT_BLUE$header$UNSET_STYLE_ALL
	echo "$NEW_LINE"
}

printWarningForFailureIfUnmetPrerequisites() {
	echo -n '
- The prerequisites are unmet.
  -> Run the "01_InstallSoftwarePrerequisites.bash" script to make sure all are
     met.'
	echo "$NEW_LINE"
	return 0
}

printWarningFailureIfProjectBinaryTreeNotBuilt() {
	echo -n '
- The project binary trees are not built under the 'bld' directory.
  -> Run the "03_BuildProgramAndSourceCodeDoc.bash" script to do so.'
	echo "$NEW_LINE"
	return 0
}

printInfoMessageNextPossibleActions() {
	echo -e '
You can now:'
	return 0
}

printInfoBrowseSourceCodeDocumentation() {
	echo -n -e '
- Browse the '$SET_STYLE_ITALIC'ReactorCodingChallenge01'$UNSET_STYLE_ALL' program source code documentation at:
  '$FG_COLOR_CYAN$SET_STYLE_UNDERLINE'bld/01_default/SourceCodeDocumentation/html/index.html'$UNSET_STYLE_ALL'.'
	echo "$NEW_LINE"
	return 0
}

printInfoExecuteUnitTests() {
	echo -n -e '
- Execute unit tests for the '$SET_STYLE_ITALIC'ReactorCodingChallenge01'$UNSET_STYLE_ALL' program.
  -> Run the "05_RunUnitTests.bash" script.'
	echo "$NEW_LINE"
	return 0
}

printInfoBrowseTestsSourceCodeCoverageReport() {
	testType=$1
	if [[ $testType == "Unit" ]]; then
		configuration="02_coverage"
	else
		configuration="ToDo"
	fi
	echo -n -e '
- Browse the '$testType' tests source code coverage report at:
  '$FG_COLOR_CYAN$SET_STYLE_UNDERLINE'bld/'$configuration'/'$testType'TestsCoverageReport/html/index.html'$UNSET_STYLE_ALL'.'
	echo "$NEW_LINE"
	return 0
}

printInfoExecuteFuzzTestsInUnitTestMode() {
	echo -n -e '
- Execute fuzz tests in unit test mode for the '$SET_STYLE_ITALIC'ReactorCodingChallenge01'$UNSET_STYLE_ALL' program.
  -> Run the "06_RunFuzzTestsInUnitTestMode.bash" script.'
	echo "$NEW_LINE"
	return 0
}

printInfoExecuteFuzzTestsInFuzzingMode() {
	echo -n -e '
- Execute fuzz tests in fuzzing mode for the '$SET_STYLE_ITALIC'ReactorCodingChallenge01'$UNSET_STYLE_ALL' program.
  -> Run the "07_RunFuzzTestsInFuzzingMode.bash" script.'
	echo "$NEW_LINE"
	return 0
}

printInfoExecuteIntegrationTests() {
	echo -n -e '
- Execute integration tests for the '$SET_STYLE_ITALIC'ReactorCodingChallenge01'$UNSET_STYLE_ALL' program.
  -> Run the "08_RunIntegrationTests.bash" script.'
	echo "$NEW_LINE"
	return 0
}

printInfoExecuteGitPreCommitHooks() {
	echo -n -e '
- Execute Git pre-commit hooks for the '$SET_STYLE_ITALIC'ReactorCodingChallenge01'$UNSET_STYLE_ALL' project.
  -> Run the "09_RunGitPrecommitHooks.bash" script.'
	echo "$NEW_LINE"
	return 0
}

printExecutingCommand() {
	local command=$1
	echo "Executing the following command..."
	echo "$NEW_LINE"
	echo -e $FG_COLOR_BRIGHT_MAGENTA"$command"$UNSET_STYLE_ALL
	echo "$NEW_LINE"
	return 0
}
