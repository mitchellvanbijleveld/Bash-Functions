#!/bin/bash

###########################################################################
# Function Import Script.                                                 #
# © 2023 Mitchell van Bijleveld - https://mitchellvanbijleveld.dev/.      #
# Last modified on 05 / 01 / 2023.                                        #
###########################################################################

###########################################################################
# Instructions.
###########################################################################
# You basically need to call this script with the functions you want to   #
# import and the script handles everything else. Read README.md for more  #
# information. Example usage: 'bash import_Functions.sh [functions]'.     #
###########################################################################

import_Functions () {

##### In case the '--quiet' flag is passed, replace the 'echo' function with printing nothing.
if echo $@ | grep -q "\-\-quiet"
then
  function echo () {
    printf ""
  }
fi

##### Log starting information.
  echo "Mitchell van Bijleveld's Function Importer has been started..."
  StringFunctions=$(echo $@ | sed 's/--quiet//g')
  StringFunctions=$(echo $StringFunctions | sed 's/ /, /g')
  echo "The following function(s) will be downloaded, checked on their sha256sum and imported to the script: $StringFunctions."

##### Function that updates the dynamic progress bar.
  UpdateProgressBar () {
    for Percent in $(seq 1 $ProgressBarStepSize); do
      StringPercentage="$StringPercentage="
      Percentage=$(($Percentage + 1))
    # sleep "0.25"
    done
    MissingPercentage=$(($TerminalWidth - $TerminalSpareWhiteSpaces - $Percentage))
    StringPercentageCandy=$(awk "BEGIN {print $Percentage/$TerminalWidth}")
    StringPercentageCandy=$(awk "BEGIN {print $StringPercentageCandy * 100}")
    StringPercentageCandy=$(printf "%.0f\n" "$StringPercentageCandy")
    StringMissingPercentage=""
    if [[ $1 == "--finish-progressbar" ]]; then
      MissingPercentChar="="
      StringPercentageCandy=100
    else
      MissingPercentChar="."
      StringPercentageCandy=" $StringPercentageCandy"
    fi
    for MissingPercent in $(seq 1 $MissingPercentage); do
       StringMissingPercentage="$MissingPercentChar$StringMissingPercentage"
    done
    ProgressBar="[$StringPercentage$StringMissingPercentage] $StringPercentageCandy %%"
    printf "\r"
    printf "$ProgressBar"
    if [[ $1 == "--finish-progressbar" ]]; then
      printf "\n"
    fi
  }

###########################################################################
# Step 1 - Create a temporary directory to store the checksum files.      #
###########################################################################
  TempDir="/tmp/mitchellvanbijleveld/.Functions"
  mkdir -p $TempDir
  mkdir -p "$TempDir/.sha256sum"
  
  ##### Download new version info file.
  curl --output "$TempDir/.version" "https://github.mitchellvanbijleveld.dev/Bash-Functions/VERSION" --silent
  source "$TempDir/.version"

  TerminalWidth=$(tput cols)
  TerminalSpareWhiteSpaces=9
  ProgressBarStepSize=$(($TerminalWidth-$TerminalSpareWhiteSpaces))
  ProgressBarStepSize=$(($ProgressBarStepSize/$#))
  ProgressBarStepSize=$(($ProgressBarStepSize/6))
  Percentage=0
  ProcessedImports=0

###########################################################################
# Step 2 - Download all functions, called by the script.                  #
###########################################################################
  for FunctionX in $@; do
    if [ $FunctionX == "--quiet" ]; then
      continue
      fi
    
    ##### Get version of function from server version file
    eval vFunction=\$$FunctionX
    
    UpdateProgressBar
    
# Download Files
    ##### If the file exists, compare the versions. If the file doesn't exist, download it. If the versions don't match, download new file.
    if [[ -e "$TempDir/$FunctionX.sh" ]]; then
      vTempFunction=$(cat "$TempDir/$FunctionX.sh" | grep "##### Version")
      vTempFunction=$(echo $vTempFunction | sed 's/#//g')
      vTempFunction=$(echo $vTempFunction | sed 's/Version//g')
      if [[ $vFunction != $vTempFunction ]]; then
        curl --output "$TempDir/$FunctionX.sh" "https://github.mitchellvanbijleveld.dev/Bash-Functions/$FunctionX.sh" &
      fi
    else
      curl --output "$TempDir/$FunctionX.sh" "https://github.mitchellvanbijleveld.dev/Bash-Functions/$FunctionX.sh" &   
    fi
    UpdateProgressBar
    
    curl --output "$TempDir/.sha256sum/$FunctionX.sh" "https://github.mitchellvanbijleveld.dev/Bash-Functions/sha256sum/$FunctionX.sh" --silent &
    UpdateProgressBar

# Wait for the downloads to complete.
    wait

# Get checksums
    expected_checksum=$(cat "$TempDir/.sha256sum/$FunctionX.sh")
    UpdateProgressBar
    actual_checksum=$(sha256sum "$TempDir/$FunctionX.sh" | awk '{print $1}')
    UpdateProgressBar
    
# Compare checksum
    if [ "$expected_checksum" == "$actual_checksum" ]; then
      source "$TempDir/$FunctionX.sh"
    else
      ErrorDuringImport=true
      FailedImports="$FailedImports$TempDir/$FunctionX.sh "
    fi
    ProcessedImports=$(($ProcessedImports + 1))
    if [[ $ProcessedImports == $# ]]; then
      UpdateProgressBar --finish-progressbar
    else
      UpdateProgressBar
    fi
  done
  
  echo
  if [ $ErrorDuringImport ]; then
      unset echo
      echo "There was an error importing one or more functions, most likely due to a sha256sum mismatch."
      echo "You can, however, continue importing any other functions (if asked by the script) and run the script."
      echo "This can, however, be a serious security concern since I can't verify the integrity of the function that is being imported."
      echo
      NumberOfFailedImport=1
      for FailedImport in $FailedImports; do
        echo "$NumberOfFailedImport - $FailedImport"
        NumberOfFailedImport=$((NumberOfFailedImport + 1))
      done
      echo
      echo -n "Do you want to import and use the script(s) mentioned above? "
      read -p "If so, type 'Yes': " yn
        case $yn in
        Yes)
          echo "Well, I hope you know what you are doing."
          for FailedImport in $FailedImports; do
            echo "Importing file '$FailedImport'..."
            source $FailedImport
          done
          sleep 5
          ;;
        *)
          echo "Wise choice! The script will exit."
          echo
          exit 1
          ;;
       esac
  fi
  if echo $@ | grep -q "\-\-quiet"
  then
    unset echo
  fi
}
