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

# =============================================================================
# Set styles
# =============================================================================

SET_STYLE_BOLD='\e[1m'
SET_STYLE_DIM='\e[2m'
SET_STYLE_ITALIC='\e[3m'
SET_STYLE_UNDERLINE='\e[4m'
SET_STYLE_BLINK='\e[5m'
SET_STYLE_REVERSE='\e[7m'
SET_STYLE_HIDDEN='\e[8m'
SET_STYLE_STRIKETHROUGH='\e[9m'

# =============================================================================
# Unset styles
# =============================================================================

UNSET_STYLE_BOLD='\e[21m'
UNSET_STYLE_DIM='\e[22m'
UNSET_STYLE_ITALIC='\e[23m'
UNSET_STYLE_UNDERLINE='\e[24m'
UNSET_STYLE_BLINK='\e[25m'
UNSET_STYLE_REVERSE='\e[27m'
UNSET_STYLE_HIDDEN='\e[28m'
UNSET_STYLE_STRIKETHROUGH='\e[29m'

# =============================================================================
# Foreground colors
# =============================================================================

# -----------------------------------------------------------------------------
# Dark colors
# -----------------------------------------------------------------------------

FG_COLOR_BLACK='\e[30m'
FG_COLOR_RED='\e[31m'
FG_COLOR_GREEN='\e[32m'
FG_COLOR_YELLOW='\e[33m'
FG_COLOR_BLUE='\e[34m'
FG_COLOR_MAGENTA='\e[35m'
FG_COLOR_CYAN='\e[36m'
FG_COLOR_WHITE='\e[37m'
FG_COLOR_DEFAULT='\e[39m'

# -----------------------------------------------------------------------------
# Bright colors
# -----------------------------------------------------------------------------

FG_COLOR_BRIGHT_BLACK='\e[90m'
FG_COLOR_BRIGHT_RED='\e[91m'
FG_COLOR_BRIGHT_GREEN='\e[92m'
FG_COLOR_BRIGHT_YELLOW='\e[93m'
FG_COLOR_BRIGHT_BLUE='\e[94m'
FG_COLOR_BRIGHT_MAGENTA='\e[95m'
FG_COLOR_BRIGHT_CYAN='\e[96m'
FG_COLOR_WHITE='\e[97m'

# =============================================================================
# Background colors
# =============================================================================

# -----------------------------------------------------------------------------
# Dark colors
# -----------------------------------------------------------------------------

BG_COLOR_BLACK='\e[40m'
BG_COLOR_RED='\e[41m'
BG_COLOR_GREEN='\e[42m'
BG_COLOR_YELLOW='\e[43m'
BG_COLOR_BLUE='\e[44m'
BG_COLOR_MAGENTA='\e[45m'
BG_COLOR_CYAN='\e[46m'
BG_COLOR_BRIGHT_GRAY='\e[47m'

# -----------------------------------------------------------------------------
# Bright colors
# -----------------------------------------------------------------------------

BG_COLOR_GRIGHT_BLACK='\e[100m'
BG_COLOR_BRIGHT_RED='\e[101m'
BG_COLOR_BRIGHT_GREEN='\e[102m'
BG_COLOR_BRIGHT_YELLOW='\e[103m'
BG_COLOR_BRIGHT_BLUE='\e[104m'
BG_COLOR_BRIGHT_MAGENTA='\e[105m'
BG_COLOR_BRIGHT_CYAN='\e[106m'
BG_COLOR_WHITE='\e[107m'

# =============================================================================
# Unset styles and colors
# =============================================================================

UNSET_STYLE_ALL='\e[0m'
