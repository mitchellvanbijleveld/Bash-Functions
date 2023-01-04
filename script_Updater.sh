###########################################################################
# Custom 'echo' function that writes in a verbose logging style.          #
# Mitchell van Bijleveld - (https://mitchellvanbijleveld.dev/             #
# © 2023 Mitchell van Bijleveld. Last edited on 01 / 01 / 2023.          #
###########################################################################

###########################################################################
# Instructions.
###########################################################################
# ....................................................................... #
###########################################################################

###########################################################################
# Function that checks for a script update, download it and run it.       #
###########################################################################
Check_Script_Update () {
  echo "Checking for script updates..."
  mkdir -p "/tmp/mitchellvanbijleveld/$Internal_ScriptName/"
  curl --output "/tmp/mitchellvanbijleveld/$Internal_ScriptName/VersionInfo" "$URL_VERSION" --silent
  . "/tmp/mitchellvanbijleveld/$Internal_ScriptName/VersionInfo"
  Online_ScriptVersion=$SCRIPT
  Online_JarVersion=$JAR
  Online_JarURL=$URL

  if [[ $ScriptVersion < $Online_ScriptVersion ]]; then
    ScriptName="$0"
    echo $ScriptName
    echo -e "\x1B[1;33mScript not up to date ($ScriptVersion)! Downloading newest version ($Online_ScriptVersion)...\x1B[0m"
    curl --output "./$ScriptName" "$URL_SCRIPT" --progress-bar
    echo
    echo "Restarting Script..."
    bash "./$ScriptName"
    exit
  elif [[ $ScriptVersion > $Online_ScriptVersion ]]; then
    echo -e "\x1B[1;33mYour version of the script ($ScriptVersion) is newer than the server version ($Online_ScriptVersion).\x1B[0m"
  else
    echo -e "\x1B[1;32mScript is up to date.\x1B[0m"
  fi
  echo
}
###########################################################################







