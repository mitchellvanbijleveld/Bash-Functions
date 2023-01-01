###########################################################################
# Script Information.                                                     #
###########################################################################
#ScriptName="Mitchell's Minecraft Server Service Installation Script"
#ScriptDescription="Bash script that helps installing a Minecraft Server on Linux as a system service."
#ScriptDeveloper="Mitchell van Bijleveld"
#ScriptDeveloperWebsite="https://mitchellvanbijleveld.dev/"
#ScriptVersion="2022 12 30 23 02 - beta"
#ScriptCopyright="Â© 2022"

#ScriptName = $1
#ScriptDescription = $2
#ScriptDeveloper = $3
#ScriptDeveloperWebsite = $4
#ScriptVersion = $5
#ScriptCopyright = $6
Show_Version_Info () {
  echo "$1"
  echo "$2"
  echo
  echo "Script Developer  : $3"
  echo "Developer Website : $4"
  echo
  echo "Version $5 - $6 $3"
  echo
}
###########################################################################
