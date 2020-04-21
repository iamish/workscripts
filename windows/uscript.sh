#!/bin/bash
##########################################################################################################
# Author: Ishpuneet Singh

# Program:
#   Delete Folders on the server while preserving the directory structure with log retention of a week
##########################################################################################################


#!/bin/bash

source <(grep -E '^\w+=' config.txt)
exec &> >(tee -a "$log_file")
date

echo "**********************************************"
echo -e  "***********\nNew Log Entry\n************"
echo "**********************************************"

# init
# look for user permissions
if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root"
   exit 1
   else
 echo " You are running this scirpt as root user"

fi

# init
# look if the directory exists
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

find "$DIRR" -print -mmin +$((60*24)) -type f -exec rm {} \;

echo "Files Deleted"


echo "**************************"
echo "$(tail -n 106 logs.txt)" > logs.txt

echo -e "\n"
exit 0
