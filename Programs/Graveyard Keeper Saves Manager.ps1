# This script is a saves manager for the game "Graveyard Keeper" by rifkais.online
# It allows the user to create a zip archive of their save files and restore them later

$user = $env:USERNAME
$defaultFilesLocation = "C:\Users\$user\AppData\LocalLow\Lazy Bear Games\Graveyard Keeper"
$savedFilesLocation = "C:\Users\$user\Documents\Graveyard Keeper Saves\"

# Show-Menu function creates the main menu of the script
function Show-Menu {
    param (
        [string]$Title = 'Welcome to the Graveyard Keeper Saves Manager - by rifkaisonline'
    )
    Clear-Host
    
     # Writes the title and menu options
     Write-Host "================ $Title ================"
     Write-Host " "
     Write-Host "** Press 1 to zip your save files **"
     Write-Host "** Press 2 to restore a save file **"
     Write-Host "** Press Q to Quit **"
}


# save function creates a zip archive of the user's save files
function save(){
    # Gets the current date and time
    $formatedName = get-date -format "yyyy-MM-dd_HH\hmm"

    # Sets the destination path and name of the zip archive
    $zipname = "SaveGK_$formatedName.zip"

    # If the destination folder doesn't exist, it creates it
    if(!(test-path $savedFilesLocation )){new-item -Path $savedFilesLocation  -force }

    # Tries to create the zip archive, if it fails, it tells the user to close the game
    try{
        Compress-Archive "$defaultFilesLocation\*" -DestinationPath "$savedFilesLocation$zipname" -force -ErrorAction SilentlyContinue
        cls
        Write-host "Done ! " -ForegroundColor Green
        Write-host "$zipname created " -ForegroundColor Green
        Write-host "You can find it in $savedFilesLocation " -ForegroundColor Green
        Write-host "Press enter to go back to the menu"
        pause
    }catch{
        Write-host "You need to close the game =D" -ForegroundColor Red -BackgroundColor Yellow
        pause
    }
}


function restore(){

    Write-host "Press enter to choose the .zip save that you want to restore"

    pause
    Function Open-File()
    {  
        Function Get-Filename($initialDirectory){
            [System.Reflection.Assembly]::LoadWithPartialName("System.windows.Forms") |
            Out-Null

            $OpenFileDialog = New-Object System.Windows.Forms.OpenFileDialog
            $OpenFileDialog.initialDirectory = $initialDirectory
            $OpenFileDialog.filter = "zip (*.zip) | *.zip"

            $OpenFileDialog.ShowDialog() | Out-Null
            $OpenFileDialog.filename
     
        }
        $filepath = Get-filename
        return $filepath
    }
    $selectedSave = Open-File $savedFilesLocation #recupere le chemin du fichier zip

    if(!(test-path $defaultFilesLocation\Old)){new-item -ItemType "directory" -Path $defaultFilesLocation\Old -force} 

    Get-ChildItem -path $defaultFilesLocation *.* | Move-Item -destination $defaultFilesLocation\Old -force -erroraction silentlycontinue
    cls
    write-host "Done !" -ForegroundColor white -backgroundColor blue
    write-host "Your saves files are in $defaultFilesLocation" -ForegroundColor white -backgroundColor blue


    expand-archive -literalpath "$selectedSave" -destinationpath $defaultFilesLocation -force

    write-host "Your old save as moved on $defaultFilesLocation\Old" -ForegroundColor white -backgroundcolor blue 
    Write-host "Press enter to go back to the menu"
    pause
    
}


do
{    
    show-menu
    $input = Read-Host "Please make a choice"

    switch ($input)
    {
        "1" 
        {
            cls
            save
        }   
        "2" 
        {
            cls 
            restore
        }
    }     
}
until ($input -eq "q")