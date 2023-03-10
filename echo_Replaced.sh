###########################################################################
# Custom 'echo' function that writes in a verbose logging style.          #
# Mitchell van Bijleveld - (https://mitchellvanbijleveld.dev/             #
# © 2023 Mitchell van Bijleveld. 09 / 01 / 2023                           #
##### Version 0.1.0                                                       #
###########################################################################

###########################################################################
# Instructions.
###########################################################################
# It's as simple as putting 'echo_Verbose [TEXT]' instead of echo.        # 
# In case you want to use this function only when a --verbose flag is     #
# passed, build a function that sets an argument called                   #
# 'ArgumentVerboseLogging' in your script (and set it to 'true'. If you   #
# set the LogStyle to 'Verbose' in your script, the verbose logging       #
# will be used.                                                           #
###########################################################################

check_echoFlags () {
  NewLine=true
  PrintedMessage="$@"
  case "$1" in
  "-n")
    NewLine=false
    PrintedMessage="$2"
    ;;
  "-e")
    PrintedMessage="$2"
    ;;
  esac
}

write_LogFile () {
  echo "testing purposes only for now"
}

print_LogMessage () {
  printf "LOG $(date +"%Y-%m-%d %H:%M:%S") [DEBUG] : $PrintedMessage"
  if [[ $NewLine == true ]]; then
    printf "\n"
  fi
}

print_Message () {
  printf "$PrintedMessage"
  if [[ $NewLine == true ]]; then
    printf "\n"
  fi
}

echo () {
  if [[ $@ != "" ]]; then
    check_echoFlags "$@"
    if [[ $LogStyle == "Verbose"  ]]; then
      print_LogMessage "$PrintedMessage"
    else
      print_Message "$PrintedMessage"
  fi
  else
    printf "\n"
  fi
}

echo_Verbose () {
if [[ $LogExtraMessages == true ]]; then
  if [[ $@ != "" ]]; then
    check_echoFlags "$@"
    if [[ $LogStyle == "Verbose"  ]]; then
      print_LogMessage "$PrintedMessage"
    else
      print_Message "$PrintedMessage"
  fi
  else
    printf "\n"
  fi
fi
}
