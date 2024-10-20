#!/bin/bash

# #############################################################################
# Copyright (C) 2023-2024 Fabien Launay. All Rights Reserved.
# Author: Fabien Launay.
# Email : fabien.launay.email@gmail.com.
# Source: This file is part of the "Reactor Coding Challenge 01" project Git
#         repository developed by Fabien Launay for Woven by Toyota.
# Usage : This copyright notice may not be removed from this file.
# #############################################################################

# #############################################################################
# This bash file contains variables used to format text.
#
# Author: Fabien Launay (fabien.launay.email@gmail.com)
#
# #############################################################################

if [[ -n "$GITLAB_CI" ]]; then
  NEW_LINE=" "
else
  NEW_LINE=""
fi
