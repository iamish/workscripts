#!/bin/bash
#####################################################
# Author: Ishpuneet Singh

# Program:
#   Delete Folders on the server with on the fly cron
#####################################################
#!/bin/bash
if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root"
   exit 1
   else
 echo " You are running this scirpt as root user"
fi


DIR="/home/ishpuneetsingh007/test"
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
echo "**************************"

