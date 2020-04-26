#!/bin/bash
##########################################################################################################
# Author: Ishpuneet Singh

# Program:
#   Delete Folders on the server while preserving the directory structure with log retention of a week
##########################################################################################################

#!/bin/bash
source <(grep -E '^\w+=' config.txt)
#####Log file deletion
##
#echo "**************************"
echo "Log file deleted::"
find $log_del -type f -mmin +$(($num)) -delete -print
exec &> >(tee -a "$log_file")
date
echo "**********************************************"
echo -e  "***********\nNew Log Entry\n************"
echo "**********************************************"
if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root"
echo "**************************"
echo "**************************"
   exit 1
   else
 echo " You are running this scirpt as root user"
echo "**************************"
echo "**************************"
fi
if [ -d $FIND ]; then
  # Control will enter here if $DIRECTORY exists.
   echo " The directory exists"
echo "**************************"
echo "**************************"
else
echo " The directory doesn't exist"
echo "**************************"
echo "**************************"
exit 1
fi
# init
# look for empty dir
if [ "$(ls -A $FIND)" ]; then
     echo "$FIND is not Empty"
echo "**************************"
echo "**************************"
else
    echo "$FIND  is Empty"
echo "**************************"
echo "**************************"
#exit 1
fi
####################################################################################
#####Delete files/directory timestamped 24 hours ago
##
#
#echo "**************************"
echo "Files/directory timestamped 24 hours ago Deleted  are ::"
find $DIR -mmin +$((1*3)) -print 2>/dev/null
find $DIR -mmin +$((1*3)) -exec rm -Rf {} \; 2>/dev/null
echo "**************************"
echo -e "\n"
exit 0
