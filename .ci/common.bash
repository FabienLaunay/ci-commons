#!/bin/bash

RED="\033[31m"
YELLOW="\033[33m"
BLUE="\033[94m"
GREEN="\033[32m"
NO_COLOR="\033[0m"

title(){
    MSG="$BLUE$1$NO_COLOR"
    printf "%s" "$MSG"
}

subtitle() {
    MSG="$YELLOW$1$NO_COLOR"
    printf "%s" "$MSG"
}


# Utility method that prints SUCCESS if a test was succesful, or FAIL together with the test output
handle_test_result(){
    EXIT_CODE=$1
    RESULT="$2"
    # Change color to red or green depending on SUCCESS
    if [ "$EXIT_CODE" -eq "0" ]; then
        printf "%sSUCCESS" "${GREEN}"
    else
        printf "%sFAIL" "${RED}"
    fi
    # Print RESULT if not empty
    if [ -n "$RESULT" ] ; then
        printf "\n%s" "$RESULT"
    fi
    # Reset color
    printf "%s" "${NO_COLOR}"
}