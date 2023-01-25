******************************

Graveyard Keeper Saves Manager - by rifkais.online

******************************


This program is a simple PowerShell script launchable with a .exe program  that allows you to easily manage your save files for the game "Graveyard Keeper". 


It provides two main functionality:

Zip your save files - 
This option allows you to create a backup of your save files by compressing them into a .zip file. 
The .zip file is named with the current date and time, and is saved in the "Documents\Graveyard Keeper Saves" folder.

Restore a save file - 
This option allows you to restore a previously backed up save file. 
When you select this option, you will be prompted to choose a .zip file from a file dialog. 
Once you select the file, the script will extract the save files and overwrite the current save files in the game's folder. 
The current save files will be moved to a folder called "Old" in the game's folder.


#Usage
-Open Graveyard Keeper Saves Manager.exe (or execute with Powershell Graveyard Keeper Saves Manager.ps1 - Set-ExecutionPolicy Unrestricted command will be needed)
-The script will display a menu with the two options mentioned above.
-Select the option you want by typing the corresponding number and pressing enter.
-Follow the instructions on the screen to complete the action.
-Press "Q" to quit the script.
-Please note that the script will not work if the game is open when you run it.

Note
The script assumes that the game is installed on the default location on the C drive, 
if you have installed the game on another drive or folder, you need to change the path in the script accordingly.
This script is not an official tool, and it is not endorsed or supported by the game developer. Use it at your own risk.


