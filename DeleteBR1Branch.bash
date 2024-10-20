#!/bin/bash

branch="BR1"

git branch --delete--force "$branch"

for remote in $(git remote); do
  git push $remote --delete "$branch"
done