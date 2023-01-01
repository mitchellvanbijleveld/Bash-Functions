#!/bin/bash

# Here comes the logic to verify the sha256sum of downloaded files.





# Step 1 - Create a temporary directory to store the checksum files.
TempDir="/tmp/mitchellvanbijleveld/sha256sum_Checker"
mkdir -p $TempDir
mkdir -p "$TempDir/sha256sum"


# Step 2 - Download all functions, called by the script.
# Check the arguments.
FunctionsToCheck="$@"
for FunctionX in $@; do
  curl --output "$TempDir/$FunctionX.sh" "https://github.mitchellvanbijleveld.dev/Bash-Functions/$FunctionX.sh" --silent
  curl --output "$TempDir/sha256sum/$FunctionX.sh" "https://github.mitchellvanbijleveld.dev/Bash-Functions/sha256sum/$FunctionX.sh" --silent
  # Read the expected checksum from the checksum file
  expected_checksum=$(cat "$TempDir/sha256sum/$FunctionX.sh")

  # Verify the script's integrity
  actual_checksum=$(sha256sum "$TempDir/$FunctionX.sh" | awk '{print $1}')

  echo $actual_checksum
  echo $expected_checksum
  if [ "$expected_checksum" != "$actual_checksum" ]; then
    echo "Error: script checksum does not match expected value"
    exit 1
  fi

  source "$TempDir/$FunctionX.sh"

done
