#!/bin/bash

verbs="cfg/gitlint/txt/Verbs.txt"
total_lines=$(wc -l < "$verbs")
random_line_number=$((RANDOM % total_lines + 1))
verb=$(sed -n "${random_line_number}p" "$verbs")

d=$(date "+%y/%m/%d %T %N")
echo "$verb $d" > README.md

git add .
git commit \
  -m "$verb $d" \
  -m "Line 10" \
  -m "Line 11"

d=$(date "+%y/%m/%d %T %N")
echo "$verb $d" > README.md
git add .
git commit \
  -m "$verb $d" \
  -m "Line 20" \
  -m "Line 21"

d=$(date "+%y/%m/%d %T %N")
echo "$verb $d" > README.md
git add .
git commit \
    -m "$verb $d" \
    -m "Line 30" \
    -m "Line 31"

git push
