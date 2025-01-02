#!/bin/bash

script_dir=$(dirname "$(realpath "$0")")
echo "[gitHookPreCommit.bash] script_dir='${script_dir}'"

ls -la

LOCK_FILE="tools/git/locks/pre-commit-failed"

#touch $LOCK_FILE