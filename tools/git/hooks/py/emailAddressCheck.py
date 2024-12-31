import sys
import os
import configparser
import re
import subprocess

def printError(message):
    RED = '\033[31m'
    RESET = '\033[0m'
    print(f"{RED}ERROR: {RESET}{message}")

# Function to extract email address regex
def get_email_regex():
    # Get the directory where the current Python script is located
    script_dir = os.path.dirname(os.path.abspath(__file__))

    # Define the relative path to the configuration file
    config_file_path = os.path.join(script_dir, '../../../gitlint/gitlint.cfg')

    # Check if the config file exists
    if not os.path.exists(config_file_path):
        print(f"Error: File not found: '{config_file_path}'.")
        sys.exit(1)

    # Initialize ConfigParser and read the config file
    # config = configparser.ConfigParser(interpolation=None)
    config = configparser.ConfigParser()
    config.read(config_file_path, encoding='utf-8')

    # Check if the 'author-valid-email' section and 'regex' option exist
    if not config.has_section('author-valid-email') or not config.has_option('author-valid-email', 'regex'):
        print(f"Error: 'regex' option not found in '[author-valid-email]' section in file: '{config_file_path}'.")
        sys.exit(1)

    email_regex= config.get('author-valid-email', 'regex')

    return email_regex

def get_git_user_email():
    try:
        # Run the Git command to get the user email
        result = subprocess.run(
            ['git', 'config', 'user.email'],
            capture_output=True,
            text=True,
            check=True
        )
        return result.stdout.strip()
    except subprocess.CalledProcessError as e:
        print(f"Error occurred: '{e}'.")
        sys.exit(1)

email_regex = get_email_regex()
compiled_regex = re.compile(email_regex)

git_user_email = get_git_user_email()

if not re.search(compiled_regex,git_user_email):
    message = f"Git user e-mail address '{git_user_email}' does not satisfy regular expression '{email_regex}'."
    printError(message)
    sys.exit(1)
