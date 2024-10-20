#!/bin/bash

d=$(date "+%y/%m/%d %T %N")
date "$d" > README.md
git add .
git commit \
  -m "FEA1: Update README.md with $d" \
  -m "Line 10" \
  -m "Line 11"

d=$(date "+%y/%m/%d %T %N")
date "$d" > README.md
git add .
git commit \
  -m "FEA2: Update README.md with $d" \
  -m "Line 20" \
  -m "Line 21"

  d=$(date "+%y/%m/%d %T %N")
  date "$d" > README.md
  git add .
  git commit \
    -m "FEA3: Update README.md with $d" \
    -m "Line 30" \
    -m "Line 31"
git push