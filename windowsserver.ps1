#####################################################
# Author: Ishpuneet Singh

#####PowerShell Script trigger to delete folder/files on the windows server
#####################################################
. .\config.ps1


####
####
# Rog retention 7 day
####
####
echo "###############"
$Date = Get-Date
$Delete = $Date.AddMinutes($Log_rtntn)
Get-ChildItem -Path $Log_Dir  -Include * -File -Recurse | Where-Object { $_.LastWriteTime -lt $Delete } | Remove-Item -Recurse -force -Verbose
echo "###############"


Start-Transcript -Path $Log_name -noclobber -append
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



if ( Test-Path $Acss_Dir ) {
    echo "Directory Exists"
} else {
    echo "Directory doesn't Exists"
Stop-Transcript
 Break
}

If ((Get-ChildItem -Force $Acss_Dir) -eq $Null) {
    "the Folder is empty"
Stop-Transcript
Break
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
$CurrentDate = Get-Date
$DatetoDelete = $CurrentDate.AddMinutes($Daysback)
Get-ChildItem -Path $Acss_Dir  -Directory -Recurse | Where-Object { $_.LastWriteTime -lt $DatetoDelete } | Remove-Item -Recurse -force -Verbose

echo "###############"
echo "###############"
Get-ChildItem -Path $Acss_Dir  -Include * -File -Recurse | Where-Object { $_.LastWriteTime -lt $DatetoDelete } | Remove-Item -Recurse -force -Verbose
echo "###############"

echo "The files older than one day have been deleted successfully" 


echo "`n"


Stop-Transcript





exit
