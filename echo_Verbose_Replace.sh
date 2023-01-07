###########################################################################
# Custom 'echo' function that writes in a verbose logging style.          #
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

echo () {
  if [[ $@ != "" ]]; then
    if [[ $1 == "-e" ]]; then
      printingString=$2
    else
      printingString=$1
    fi
    if $ArgumentVerboseLogging; then
      printf "LOG $(date +"%Y-%m-%d %H:%M:%S") [DEBUG] : $printingString"
      printf "\n"
    else
      printf 
    fi
  fi
}
