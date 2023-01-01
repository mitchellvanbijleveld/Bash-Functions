###########################################################################
# Custom Log Message Function that takes LogLevel in consideration.       #
###########################################################################
echo_Verbose () {
  if $ArgumentVerboseLogging; then
    echo "LOG $(date +"%Y-%m-%d %H:%M:%S") [DEBUG] : $1"
  fi
}
###########################################################################
