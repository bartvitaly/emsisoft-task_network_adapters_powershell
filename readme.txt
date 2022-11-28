README
1. ExecutionPolicy should be set to 'Unrestricted' before running the script. Otherwise the script will not run.
Run the following command in the terminal: "Set-ExecutionPolicy 'Unrestricted'".
2. All the scripts have to be in the same folder because they import methods from the common.ps1 file located there.
3. Run scripts from terminal as Administrator: "PowerShell -File task1_1.ps1".
4. Script task1_3.ps1 creates a file "disabled_adapters.txt" with the list of disabled adapters.
