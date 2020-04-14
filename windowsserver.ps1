
#####################################################
# Author: Ishpuneet Singh

#####PowerShell Script trigger to delete folder/files on the windows server
#####################################################

Echo "####################################"
Echo "####################################"
Echo "####################################"


Start-Transcript -Path "C:\Users\ishba\Downloads\Test\trans.log" -noclobber -append


If (-NOT ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator"))
 {
  Echo "This script needs to be run As Admin"
 Stop-Transcript
  Break
 }
else {
    "You are running this script as a root user"
}


if ( Test-Path C:\Windows ) {
    echo "Directory Exists"
} else {
    echo "Directory doesn't Exists"
Stop-Transcript
 Break
}


If ((Get-ChildItem -Force C:\Users\ishba\Downloads\Test) -eq $Null) {
    "the Folder is empty"
Stop-Transcript
#Break
}
else {
    "Directory is not empty"
}



####
####
<#
$Dir1 = "C:\Users\ishba\Downloads\Test\test1\*"   #it will delete all the content of the specific folder
Remove-Item   -Path $Dir1 -recurse 
echo "The files have been deleted successfully" 
#>
####
####


# Delete all Files older than 1 day
####
####
Set-ExecutionPolicy RemoteSigned
$Dir2 = "C:\Users\ishba\Downloads\Test\"     #it will delete the content leaving the directory structure intact
$Daysback = "-1" 
$CurrentDate = Get-Date
$DatetoDelete = $CurrentDate.AddDays($Daysback)
Get-ChildItem -Path $Dir2  -Include * -File -Recurse | Where-Object { $_.LastWriteTime -lt $DatetoDelete } | Remove-Item 
echo "The files older than one day have been deleted successfully" 

# Delete Log Files older than 7 day
####
####
Get-ChildItem –Path  "C:\Users\ishba\Downloads\Test\" –Recurse -Force -include *.log | Where-Object { $_.CreationTime –lt (Get-Date).AddDays(-1) } | Remove-Item -Force

exit

