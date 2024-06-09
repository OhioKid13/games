# Create a ZIP archive containing the PowerShell script and the Python script
Compress-Archive -Path main.ps1, run.sh, README.md, run.ps1 -DestinationPath chess.zip
