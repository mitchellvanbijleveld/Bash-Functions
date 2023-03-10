###########################################################################
# Custom 'echo' function that writes in a verbose logging style.          #
# Mitchell van Bijleveld - (https://mitchellvanbijleveld.dev/             #
# © 2023 Mitchell van Bijleveld. Last edited on 01 / 01 / 2023.           #
##### Version 0.1.0                                                       #
###########################################################################

###########################################################################
# Instructions.
###########################################################################
# Please set the following variables in the script you want to use:       #
# Internal_ScriptName : This will be the folder created in                #
#                       '/tmp/mitchellvanbijleveld/ to store temporary    #
#                        files                                            #
# URL_VERSION         : Location (URL) of the file where the version      #
#                       info is stored.                                   #
#URL_SCRIPT           : URL where the newer version of the script can     #
#                       be found                                          #
###########################################################################

Check_Script_Update () {
  echo "Mitchell van Bijleveld's Script Updater has been started..."
  echo "Checking for script updates..."
  mkdir -p "/tmp/mitchellvanbijleveld/$Internal_ScriptName/"
  curl --output "/tmp/mitchellvanbijleveld/$Internal_ScriptName/VersionInfo" "$URL_VERSION" --silent
  . "/tmp/mitchellvanbijleveld/$Internal_ScriptName/VersionInfo"
  Online_ScriptVersion=$SCRIPT
  Online_JarVersion=$JAR
  Online_JarURL=$URL

  if [[ $ScriptVersion < $Online_ScriptVersion ]]; then
    ScriptPath=$(realpath $0)
    echo -e "\x1B[1;33mScript not up to date ($ScriptVersion)! \x1B[1;32mDownloading newest version ($Online_ScriptVersion)...\x1B[0m\n"
    curl --output "$ScriptPath" "$URL_SCRIPT" --progress-bar
    echo
    if [[ $@ == "" ]]; then
      echo "Restarting Script from '$ScriptPath' in 5 seconds..."
    else
      echo "Restarting Script from '$ScriptPath' with arguments '$@' in 5 seconds..."
    fi
    sleep 5
    /usr/bin/bash $ScriptPath $@
    exit
  elif [[ $ScriptVersion > $Online_ScriptVersion ]]; then
    echo -e "\x1B[1;33mYour version of the script ($ScriptVersion) is newer than the server version ($Online_ScriptVersion).\x1B[0m\n"
  else
    echo -e "\x1B[1;32mScript is up to date.\x1B[0m\n"
  fi
}
