

function Show-Menu {
    param (
        [string]$Title = 'Welcome to the Graveyard Keeper Saves Manager - by rifkaisonline'
    )
    Clear-Host
    
     Write-Host "================ $Title ================"
     Write-Host "========================================"
     Write-Host "Press 1 to zip your save files"
     Write-Host "Press 2 to restore a save file"
     Write-Host "Press Q to Quit"
}





function save(){
    $year = get-date -Format "yyyy"
    $month=get-date -Format "MM"
    $day = (get-date).day
    $hour=get-date -Format "HH"
    $minutes=get-date -Format "mm"
    $user = $env:USERNAME

    
    $destinationpath = "C:\Users\$user\Documents\Graveyard Keeper Saves\SaveGK_"+"$year"+"-"+"$month"+"-"+"$day"+"_"+"$hour"+"h"+"$minutes"+".zip"
    $zipname = "SaveGK_"+"$year"+"-"+"$month"+"-"+"$day"+"_"+"$hour"+"h"+"$minutes"+".zip"

    if(!(test-path $destinationpath )){new-item -Path $destinationpath  -force }


    try{
    Compress-Archive "C:\Users\$user\AppData\LocalLow\Lazy Bear Games\Graveyard Keeper\*" -DestinationPath "$destinationpath" -force -ErrorAction SilentlyContinue
    cls
    Write-host "Done ! " -ForegroundColor Green
    Write-host "$zipname created " -ForegroundColor Green
    Write-host "You can find it in Documents\Graveyard Keeper Saves " -ForegroundColor Green
    Write-host "Press enter to go back to the menu"
    pause
    }catch {
    Write-host "You need to close the game =D" -ForegroundColor Red -BackgroundColor Yellow
    pause}
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
    $path = Open-File #recupere le chemin du fichier zip
    $userfolder = $env:USERNAME


    $savespath = "C:\Users\$userfolder\AppData\LocalLow\Lazy Bear Games\Graveyard Keeper"

    if(!(test-path $savespath\Old)){new-item -ItemType "directory" -Path $savespath\Old -force} #test si le dossier old existe et le cree si necessaire


    Get-ChildItem -path $savespath *.* | Move-Item -destination $savespath\Old -force -erroraction silentlycontinue
    cls
    write-host "Done !" -ForegroundColor white -backgroundColor blue
    write-host "Your saves files are in $savespath" -ForegroundColor white -backgroundColor blue


    expand-archive -literalpath "$path" -destinationpath $savespath -force

    write-host "Your old save as moved on $savespath\Old" -ForegroundColor white -backgroundcolor blue 
    Write-host "Press enter to go back to the menu"
    pause
    
}






do
{
     
     show-menu
     $input = Read-Host "Please make a choice"

     switch ($input)
     {
           "1" {
                cls
                save
        } "2" {
                cls 
		restore

           }
     }
     
}
until ($input -eq "q")