import sys
import os
import configparser
import re

def printError(message):
    RED = '\033[31m'
    RESET = '\033[0m'
    print(f"{RED}ERROR: {RESET}{message}")

# Function to extract allowed types
def getTypesArray():
    # Get the directory where the current Python script is located
    script_dir = os.path.dirname(os.path.abspath(__file__))

    # Define the relative path to the configuration file
    config_file_path = os.path.join(script_dir, '../gitlint/gitlint.cfg')

    # Check if the config file exists
    if not os.path.exists(config_file_path):
        print(f"Error: File not found: '{config_file_path}'.")
        sys.exit(1)

    # Initialize ConfigParser and read the config file
    config = configparser.ConfigParser()
    config.read(config_file_path, encoding='utf-8')

    # Check if the 'title-match-regex' section and 'regex' option exist
    if not config.has_section('title-match-regex') or not config.has_option('title-match-regex', 'regex'):
        print(f"Error: 'regex' option not found in '[title-match-regex]' section in file: '{config_file_path}'.")
        sys.exit(1)

    titleMatchRegex= config.get('title-match-regex', 'regex')

    # Regex pattern
    typesPattern = r"^\^\((.*)\){"

    # Perform the regex search
    match = re.search(typesPattern, titleMatchRegex)

    # Check if a match is found and extract the first group
    if not match:
        print(f"Error: pattern '{typesPattern}'not found in 'regex' in '[title-match-regex]' section in file: '{config_file_path}'.")
        sys.exit(1)

    types = match.group(1)

    typesArray = re.findall(r'[^|]+', types)
    return typesArray

# Function to dynamically extract commit types and their associated emojis
def getTypesMap(typesArray):
    # Build the commit_type_to_emoji dictionary from the extracted commit types
    # typesMap = [[item[1:], item[0]] for item in typesArray]
    typesMap = {item[1:]: item[0] for item in typesArray}
    return typesMap



typesArray = getTypesArray()

# Read the commit message
commitMessageFile = sys.argv[1]
with open(commitMessageFile, 'r', encoding='utf-8') as file:
    commitMessage = file.read()

if commitMessage.startswith(tuple(typesArray)):
    sys.exit(0)

# Build the commit_type_to_emoji map dynamically
typesMap = getTypesMap(typesArray)

matching_key = next((key for key in typesMap if commitMessage.startswith(key)), None)

if not matching_key:
    message = "Type not valid in Git commit message."
    printError(message)
    sys.exit(1)

newCommitMessage = f"{typesMap[matching_key]}{commitMessage}"

# Write the new commit message back
with open(commitMessageFile, 'w', encoding='utf-8') as file:
    file.write(newCommitMessage)
