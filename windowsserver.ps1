
#####################################################
# Author: Ishpuneet Singh

#####PowerShell Script trigger to delete folder/files on the windows server
#####################################################


#PowerShell Script to delete folder/files on the windows server

Start-Transcript -Path "C:\Users\ishba\Downloads\Test\trans.txt" -noclobber -append

If (-NOT ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator"))
 {
  Echo "This script needs to be run As Admin"
  Break
 }
else {
    "You are running this script as a root user"
}


if ( Test-Path C:\Windows ) {
    echo "Directory Exists"
} else {
    echo "Directory doesn't Exists"
 Break
}


If ((Get-ChildItem -Force C:\Users\ishba\Downloads\Test\test1) -eq $Null) {
    "the Folder is empty"
Break
}
else {
    "Directory is not empty"
}


Set-ExecutionPolicy RemoteSigned

$Dir1 = "C:\Users\ishba\Downloads\Test\test1\*"   #it will delete all the content of the specific folder
$Dir2 = "C:\Users\ishba\Downloads\Test\test2"     #it will delete the content leaving the directory structure intact
  
  
Remove-Item   -Path $Dir1 -recurse 
Get-ChildItem -Path $Dir2  -Include * -File -Recurse | foreach { $_.Delete()}   

echo "The files have been deleted successfully" 

exit



