
#####################################################
# Author: Ishpuneet Singh

#####PowerShell Script trigger to delete folder/files on the windows server
#####################################################





$Trigger= New-ScheduledTaskTrigger -At 12:00PM -Daily  # Specify the trigger settings

$User= "ishba" # Specify the account to run the script

$Action= New-ScheduledTaskAction -Execute "PowerShell.exe"  -Argument "C:\Users\ishba\Downloads\Test\windows.ps1" # Specify what program to run and with its parameters

Register-ScheduledTask -TaskName "Delete folders and files " -Trigger $Trigger -User $User -Action $Action -RunLevel Highest ñForce # Specify the name of the task


####PowerShell Script to delete folder/files on the windows server


Set-ExecutionPolicy RemoteSigned

$Dir1 = "C:\Users\ishba\Downloads\Test\test1\*"   #it will delete all the content of the specific folder
$Dir2 = "C:\Users\ishba\Downloads\Test\test2"     #it will delete the content leaving the directory structure intact
  
  
Remove-Item   -Path $Dir1 -recurse                #it will delete all the content of the specific folder
Get-ChildItem -Path $Dir2  -Include * -File -Recurse | foreach { $_.Delete()}    #it will delete the content leaving the directory structure intact


echo "The files have been deleted successfully" 
exit

