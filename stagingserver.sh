#!/bin/bash
#####################################################
# Author: Ishpuneet Singh

# Program:
#   Delete Folders on the server with on the fly cron
#####################################################

# Replace the file location upon every new deployment, cronjob set to every 24 hours
crontab -l | { cat; echo "0 0 * * * /home/ishpuneetsingh007/shell.sh"; } | crontab -
 
#1st Directory path
 Dir_1="test/*"
 rm -rf $Dir_1

#2nd  Directory path
#Dir_2="test/test1/*"
#rm -rf $Dir_2

echo "Files Deleted"
