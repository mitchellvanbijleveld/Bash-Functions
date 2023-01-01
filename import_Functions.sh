#!/bin/bash

###########################################################################
# Custom 'import' function that writes in a verbose logging style.          #
# Mitchell van Bijleveld - (https://mitchellvanbijleveld.dev/             #
# © 2023 Mitchell van Bijleveld. 01 / 01 / 2023                           #
###########################################################################

###########################################################################
# Instructions.
###########################################################################
# It's as simple as putting 'echo_Verbose [TEXT]' instead of echo.        # 
# In case you want to use this function only when a --verbose flag is     #
# passed, build a function that sets an argument called                   #
# 'ArgumentVerboseLogging' in your script (and set it to 'true'.          #
###########################################################################

import_Functions () {




###########################################################################
# Step 1 - Create a temporary directory to store the checksum files.      #
###########################################################################
  TempDir="/tmp/mitchellvanbijleveld/sha256sum_Checker"
  mkdir -p $TempDir
  mkdir -p "$TempDir/sha256sum"



###########################################################################
# Step 2 - Download all functions, called by the script.                  #
###########################################################################
  for FunctionX in $@; do
    curl --output "$TempDir/$FunctionX.sh" "https://github.mitchellvanbijleveld.dev/Bash-Functions/$FunctionX.sh" --silent
    curl --output "$TempDir/sha256sum/$FunctionX.sh" "https://github.mitchellvanbijleveld.dev/Bash-Functions/sha256sum/$FunctionX.sh" --silent
  
    expected_checksum=$(cat "$TempDir/sha256sum/$FunctionX.sh")
    actual_checksum=$(sha256sum "$TempDir/$FunctionX.sh" | awk '{print $1}')
    if [ "$expected_checksum" == "$actual_checksum" ]; then
      return
    else
      echo "Error: script checksum does not match expected value"
      exit 1
    fi

#  source "$TempDir/$FunctionX.sh"

  done
}
