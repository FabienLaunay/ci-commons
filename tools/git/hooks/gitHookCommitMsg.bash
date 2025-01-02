#!/bin/bash

script_dir=$(dirname "$(realpath "$0")")
echo "[gitHookCommitMsg.bash] script_dir='${script_dir}'"

# ==============================================================================
# Abort if Git pre-commit hook failed
# ==============================================================================

LOCK_FILE="tools/git/locks/pre-commit-failed"

if [ -f "$LOCK_FILE" ]; then
  echo "[gitHookCommitMsg.bash] Git pre-commit hook failed."
  exit 1
fi

