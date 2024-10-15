#!/bin/bash

echo "###################################################################"
echo "Update Debian-based Gitlab Linux runner local package index."
echo "###################################################################"
echo ""
apt-get update
echo "###################################################################"
echo "Install the `git` package (prerequisite for gitlint)."
echo "###################################################################"
echo ""
apt-get install --yes git
echo "###################################################################"
echo "Install the `gitlint` package using Python package installer."
echo "###################################################################"
echo ""
pip install gitlint
