#!/bin/bash
#
#
# Daily_Archive - Archive Designated files and directories
#############################################################
#
# Gather The Current Date
#
DATE=$(date +%y%m%d)
#
# Set Archive File Name
#
FILE=archive$DATE.tar.gz
#
# Set Configuration and Destination File
#
CONFIG_FILE=/archive/files_to_backup
DESTINATION=/archive/$FILE
#
##################### Main Script ##########################
#
# Check Backup Config File Exists
#
if [ -f $CONFIG_FILE ] # make sure config file exists
then # if it exists do nothing and continue on!
echo
else
echo
echo "$CONFIG_FILE does not exist."
echo "backup not completed due to missing configuration file"
echo
exit
fi
#
# Build the names of the files to backup
#
FILE_NO=1 # start on line 1 on the config file
#
exec < $CONFIG_FILE #Redirect std Input to name of config file
#
read FILE_NAME # read 1st record
#
while [ $? -eq 0 ] # create list of files to backup
do
if [ -f $FILE_NAME -O -d $FILE_NAME ] #check the file exists
then
# if file exists add its name to list.
FILE_LIST="$FILE_LIST $FILE_NAME"
else
# If files doesn't exist, issue warning
echo
echo $FILE_NAME, does not exist."
echo "Obviously I will not include it in this archiuve."
echo "It is listed on line $FILE_NO of the config file."
echo "Continuing to build archive list."
echo
fi
#
FILE_NO=$($File_NO +1] # Increase Line/File by one.
Read FILE_NAME # read next record
done
#
#######################################################################
#
# Backup the files and compress the archive
#
echo "Starting Archive..."
echo
#
tar -czf $DESTINATION $FILE_LIST 2> /dev/null
#
echo "Archive completed"
echo "Resulting archive file is: $DESTINATION"
echo
#
exit
