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

set_String () {
  if [[ $1 == "-e" ]]; then
    printingString=$2
  else
    printingString=$1
  fi
}

print_LogMessage () {
  printf "LOG $(date +"%Y-%m-%d %H:%M:%S") [DEBUG] : $printingString"
  printf "\n"
}


print_Message () {
  printf "$printingString"
  printf "\n"
}

echo () {
  if [[ $@ != "" ]]; then
    set_String "$@"
    if [[ $ArgumentVerboseLogging = true ]]; then
      printf "ARGU TRUEEE"
      print_LogMessage
    else
      printf "ARGU FALSEEEEEEEEEE"
      print_Message
    fi
  else
    printf "\n"
  fi
}

echo_Verbose () {
  set_String "$@"
    if [[ $ArgumentVerboseLogging = true ]]; then
    print_LogMessage
  fi
}
