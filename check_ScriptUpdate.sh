###########################################################################
# Custom 'echo' function that writes in a verbose logging style.          #
# Mitchell van Bijleveld - (https://mitchellvanbijleveld.dev/             #
# Â© 2023 Mitchell van Bijleveld. 01 / 01 / 2023                           #
###########################################################################

###########################################################################
# Instructions.
###########################################################################
# It's as simple as putting 'echo_Verbose [TEXT]' instead of echo.        # 
# In case you want to use this function only when a --verbose flag is     #
# passed, build a function that sets an argument called                   #
# 'ArgumentVerboseLogging' in your script (and set it to 'true'.          #
###########################################################################

check_ScriptUpdate () {
echo "Checking for script updates..."
mkdir -p /tmp/mitchellvanbijleveld/Minecraft-Server-Service/
curl --output /tmp/mitchellvanbijleveld/Minecraft-Server-Service/VersionInfo https://github.mitchellvanbijleveld.dev/Minecraft-Server-Service/VERSION --silent
. /tmp/mitchellvanbijleveld/Minecraft-Server-Service/VersionInfo
Online_ScriptVersion=$SCRIPT
Online_JarVersion=$JAR
Online_JarURL=$URL

if [[ $ScriptVersion < $Online_ScriptVersion ]]; then
    ScriptName="$0"
    echo -e "\x1B[1;33mScript not up to date ($ScriptVersion)! Downloading newest version ($Online_ScriptVersion)...\x1B[0m"
    curl --output "./$ScriptName" https://github.mitchellvanbijleveld.dev/Minecraft-Server-Service/minecraft-server-service-installer.sh --progress-bar
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
