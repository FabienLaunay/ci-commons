#!/bin/bash

RED="\e[31m"
YELLOW="\e[33m"
BLUE="\e[94m"
GREEN="\e[32m"
NO_COLOR="\e[0m"

title() {
  MSG="$BLUE$1$NO_COLOR"
  #    printf "%s" "$MSG"
  echo -e "$MSG"
}

subtitle() {
  MSG="$YELLOW$1$NO_COLOR"
  #    printf "%s" "$MSG"
  echo -e "$MSG"
}

# Utility method that prints SUCCESS if a test was succesful, or FAIL together with the test output
handle_test_result() {
  EXIT_CODE=$1
  RESULT="$2"
  # Change color to red or green depending on SUCCESS
  if [ "$EXIT_CODE" -eq "0" ]; then
    #        printf "%sSUCCESS" "${GREEN}"
    echo -e "${GREEN}SUCCESS"
  else
    #        printf "%sFAIL" "${RED}"
    echo -e "${RED}FAIL"
  fi
  # Print RESULT if not empty
  if [ -n "$RESULT" ]; then
    printf "\n%s" "$RESULT"
  fi
  # Reset color
  #    printf "%s" "${NO_COLOR}"
  echo -e "${NO_COLOR}"
}
