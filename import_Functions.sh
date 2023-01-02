#!/bin/bash

###########################################################################
# Custom 'import' function that writes in a verbose logging style.        #
# Mitchell van Bijleveld - (https://mitchellvanbijleveld.dev/             #
# © 2023 Mitchell van Bijleveld. 02 / 01 / 2023                           #
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

if echo $@ | grep -q "--quiet"
then
    # Disable the echo command
    set -o noglob

    # Do not echo the argument
    set +o history
else
    # Enable the echo command
    set +o noglob

    # Echo the argument
    set -o history
fi


  echo "Mitchell van Bijleveld's Function Importer has been started..."
  StringFunctions=$(echo $@ | sed 's/ /, /g')
  echo "The following function(s) will be downloaded, checked on their sha256sum and imported to the script: $StringFunctions."
  echo -n "["

  UpdateProgressBar () {
    for step in $(seq 1 $ProgressBarStepSize); do
      echo -n "="
      Percentage=$(($Percentage + 1))
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
  TerminalWhiteSpace=7
  ProgressBarStepSize=$(($TerminalWidth-$TerminalWhiteSpace))
  ProgressBarStepSize=$(($ProgressBarStepSize/$#))
  ProgressBarStepSize=$(($ProgressBarStepSize/6))

###########################################################################
# Step 2 - Download all functions, called by the script.                  #
###########################################################################
  for FunctionX in $@; do
  
    UpdateProgressBar
    
# Download Files
    curl --output "$TempDir/$FunctionX.sh" "https://github.mitchellvanbijleveld.dev/Bash-Functions/$FunctionX.sh" --silent &
    UpdateProgressBar
    curl --output "$TempDir/sha256sum/$FunctionX.sh" "https://github.mitchellvanbijleveld.dev/Bash-Functions/sha256sum/$FunctionX.sh" --silent &
    UpdateProgressBar

# Wait for the downloads to complete.
  wait

# Get checksums
    expected_checksum=$(cat "$TempDir/sha256sum/$FunctionX.sh") &
    UpdateProgressBar
    actual_checksum=$(sha256sum "$TempDir/$FunctionX.sh" | awk '{print $1}') &
    UpdateProgressBar
    
# Wait for the checksums comparison to complete.
  wait
    
# Compare checksum
    if [ "$expected_checksum" == "$actual_checksum" ]; then
      source "$TempDir/$FunctionX.sh"
      UpdateProgressBar
    else
      ErrorDuringImport=true
    fi
  done
  
  MissingPercentage=$((TerminalWidth - $TerminalWhiteSpace - $Percentage))

  for Percent in $(seq 1 $MissingPercentage); do
    echo -n "="
  done
  echo "] 100%"

  if [ $ErrorDuringImport ]; then
      echo
      echo "There was an error importing one or more functions, most likely due to a sha256sum mismatch."
      echo "You can, however, continue importing any other functions (if asked by the script) and run the script."
      echo "This can, however, be a serious security concern since I can't verify the integrity of the function that is being imported."
      echo
      read -p "Do you want to continue? If so, type 'Yes'. " yn
        case $yn in
        Yes)
          echo "Well, I hope you know what you are doing."
          ;;
        *)
          echo -e "Wise choice! The script will exit."
          echo
          exit 1
          ;;
       esac
  fi

if echo $@ | grep -q "--quiet"
then
    # Enable the echo command
    set +o noglob

    # Echo the argument
    set -o history

else
    # Disable the echo command
    set -o noglob

    # Do not echo the argument
    set +o history
fi

  echo
}
