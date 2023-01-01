# Here comes the logic to verify the sha256sum of downloaded files.





# Step 1 - Create a temporary directory to store the checksum files.
TempDir = "/tmp/mitchellvanbijleveld/sha256sum_Checker/"
mkdir -p "$TempDir"



# Step 2 - Download sha256sum file
curl --output "$TempDir/sha256sum" "https://github.mitchellvanbijleveld.dev/Bash-Functions/sha256sum" --silent



# Step 3 - Download all functions, called by the script.
# Check the arguments.
FunctionsToCheck=" $@ "
for FunctionX in $@; do
  curl --output "$TempDir/$FunctionX.sh" "https://github.mitchellvanbijleveld.dev/Bash-Functions/$FunctionX.sh" --silent
  
  sha256sum_=$FunctionX.sh

  # Read the expected checksum from the checksum file
  expected_checksum=$(cat script.sh.sha256)

  # Verify the script's integrity
  actual_checksum=$(sha256sum script.sh | awk '{print $1}')
  
  
  
  
done
