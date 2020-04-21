######################################################
# Author: Ishpuneet Singh

#####PowerShell Script trigger to delete folder/files on the windows server
######################################################
. .\config.ps1

Start-Transcript -Path $Dir1 -noclobber -append

echo "`n"
Get-date
Echo "####################################" 
Echo "#################`nNew Log Entry`n###################" 
Echo "####################################"


If (-NOT ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator"))
 {
  Echo "This script needs to be run As Admin"
 Stop-Transcript
  Break
 }
else {
    "You are running this script as a root user"
}


if ( Test-Path $Dir2 ) {
    echo "Directory Exists"
} else {
    echo "Directory doesn't Exists"
Stop-Transcript
 Break
}

If ((Get-ChildItem -Force $Dir2) -eq $Null) {
    "the Folder is empty"
Stop-Transcript
#Break
}
else {
    "Directory is not empty"
}
####

####
####
# Delete all Files older than 1 day
####
####
Set-ExecutionPolicy RemoteSigned
#it will delete the content leaving the directory structure intact
$Daysback = "-1" 
$CurrentDate = Get-Date
$DatetoDelete = $CurrentDate.AddDays($Daysback)
Get-ChildItem -Path $Dir2  -Include * -File -Recurse | Where-Object { $_.LastWriteTime -lt $DatetoDelete } | Remove-Item 
echo "The files older than one day have been deleted successfully" 


echo "`n"
Echo "###"
Stop-Transcript


####
####
# Rog retention 7 day
####
####

Get-Content $Dir1 | select -Last 225 | Set-Content $Dir1

exit
