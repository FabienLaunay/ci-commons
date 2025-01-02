#!/bin/bash

# Define the regex pattern for valid email
regex="^[a-zA-Z0-9._%+-]+@gmail\.com$"

# Get the user email from Git config
email=$(git config --get user.email)

# Check if the email matches the regex
if [[ $email =~ $regex ]]; then
  echo "The email '$email' is valid."
  exit 0
else
  echo "The email '$email' is invalid."
  exit 1
fi
