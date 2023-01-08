# Bash Functions
This README will guild you through the steps of using this repository. Below is a code example with how to use the script. It basically is as simple as 'sourcing' the import script and then launch it to import the functions you want.
```
eval "$(curl https://github.mitchellvanbijleveld.dev/Bash-Functions/import_Functions.sh --silent)"
import_Functions [Function_1] [Function_2]
```

Below is a list of function files you can import with the corresponding functions.

## echo_Replaced

### echo
When the command `echo` is used in your code, it will print the text after the command. If the argument `ArgumentVerboseLogging` in your code is set to true, the `echo` command wil print 'log-styled' to the terminal. An example:

```
LOG 2023-01-07 19:53:08 [DEBUG] : These
LOG 2023-01-07 19:53:08 [DEBUG] : Are four
LOG 2023-01-07 19:53:08 [DEBUG] : Lines of
LOG 2023-01-07 19:53:08 [DEBUG] : Code!
```

### echo_Verbose
When `echo_Verbose` is used, the output won't be written to the terminal if the argument `ArgumentVerboseLogging` is set to `false`. If the argument `ArgumentVerboseLogging` is set to `true`, the lines will be printed as the example above.

## print_ScriptInfo
After importing `print_ScriptInfo` you can use the following command in your code to print a default Script Info 'Page' to the terminal.
```
print_ScriptInfo
```

## script_Updater.sh
After importing `script_Updater` you can use the following command in your code to check for updates for your script.
```
Check_Script_Update
```
