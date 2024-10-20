#!/bin/bash

bash DeleteBR1Branch

git checkout -b BR1

date "+%y/%m/%d %T %N" > README.md
git add .
git commit \
  -m 'FEA1: Update README.md' \
  -m 'Line 10' \
  -m 'Line 11'

date "+%y/%m/%d %T %N" > README.md
git add .
git commit -m 'FEA2: Update README.md' \
  -m 'Line 21' \
  -m 'Line 22'


date "+%y/%m/%d %T %N" > README.md
git add .
git commit -m 'FEA: Update Update README.md' \
  -m 'Line 31' \
  -m 'Line 32'

git push all BR1