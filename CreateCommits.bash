#!/bin/bash

date "+%y/%m/%d %T %N" > README.md
git add .
git commit -m 'FEA1: Update "+%y/%m/%d %T %N" README.md'

date "+%y/%m/%d %T %N" > README.md
git add .
git commit -m 'FEA2: Update "+%y/%m/%d %T %N" README.md'

date "+%y/%m/%d %T %N" > README.md
git add .
git commit -m 'FEA: Update "+%y/%m/%d %T %N" 3 README.md'

git push