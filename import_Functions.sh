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
  echo "Mitchell van Bijleveld's Function Importer has been started..."
  StringFunctions=$(echo $@ | sed 's/ /, /g')
  echo "The following function(s) will be downloaded, checked on their sha256sum and imported to the script: $StringFunctions."
  echo "["

  UpdateProgressBar () {
    for step in $(seq 1 $ProgressBarStepSize); do
      echo -n "="
    # sleep "0.25"
    done
  }

###########################################################################
# Step 1 - Create a temporary directory to store the checksum files.      #
###########################################################################
  TempDir="/tmp/mitchellvanbijleveld/sha256sum_Checker"
  mkdir -p $TempDir
  mkdir -p "$TempDir/sha256sum"

  TerminalWidth=$(tput cols)
  echo $TerminalWidth
  ProgressBarStepSize=$(($TerminalWidth-6))
  echo $ProgressBarStepSize
  ProgressBarStepSize=$(($ProgressBarStepSize/$#))
  echo $ProgressBarStepSize
  ProgressBarStepSize=$(($ProgressBarStepSize/6))
  echo $ProgressBarStepSize

###########################################################################
# Step 2 - Download all functions, called by the script.                  #
###########################################################################
  for FunctionX in $@; do
  
    UpdateProgressBar
    
# Download Files
    curl --output "$TempDir/$FunctionX.sh" "https://github.mitchellvanbijleveld.dev/Bash-Functions/$FunctionX.sh" --silent
    UpdateProgressBar
    curl --output "$TempDir/sha256sum/$FunctionX.sh" "https://github.mitchellvanbijleveld.dev/Bash-Functions/sha256sum/$FunctionX.sh" --silent
    UpdateProgressBar

# Get checksums
    expected_checksum=$(cat "$TempDir/sha256sum/$FunctionX.sh")
    UpdateProgressBar
    actual_checksum=$(sha256sum "$TempDir/$FunctionX.sh" | awk '{print $1}')
    UpdateProgressBar
    
# Compare checksum
    if [ "$expected_checksum" == "$actual_checksum" ]; then
      source "$TempDir/$FunctionX.sh"
      UpdateProgressBar
    else
      echo
      echo "Error: script checksum does not match expected value"
      exit 1
    fi
    
  done
  echo "] 100%"
  echo
}
