#!/bin/bash
#####################################################
# Author: Ishpuneet Singh

# Program:
#   Delete Folders on the server with on the fly cron
#####################################################

#!/bin/bash
#find . -name "*.log" -print -mmin +2 -type f -exec rm {} \;
find . -name "*.log" -print -mtime +7 -type f -exec rm {} \;

log_file="test.log"
exec &> >(tee -a "$log_file")
echo "**********************************************"
echo -e  "***********\nNew Log Entry\n************"
echo "**********************************************"
DIR="/home/ishpuneetsingh007/test"
DIRR="/home/ishpuneetsingh007/test/"
if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root"
   exit 1
   else
 echo " You are running this scirpt as root user"
fi
if [ -d "$DIR" ]; then
  # Control will enter here if $DIRECTORY exists.
   echo " The directory exists"
else
echo " The directory doesn't exist"
exit
fi
# init
# look for empty dir
if [ "$(ls -A $DIR)" ]; then
     echo "$DIR is not Empty"
else
    echo "$DIR is Empty"
exit
fi
####################################################################################
#####Delete files timestamped 24 hours ago leaving the directory structure intact
##
#
#find "$DIRR" -name "*.log" -print -type f -exec rm {} \;
#find "$DIRR" -print -type f -exec rm {} \;
find "$DIRR" -print -mtime +1 -type f -exec rm {} \;
echo "Files Deleted"
