#!/bin/bash

# Begin DEPNotify Clean-Up
# Caffeination Clean-Up
echo "Fully caffeinated..."
pkill caffeinate

# Create DEPNotify Setup doneFile.
mkdir /Library/Application\ Support/JAMF/ExtensionAttributes/
touch /Library/Application\ Support/JAMF/ExtensionAttributes/com.depnotify.provisioning.done

# Check if DEPNotify.app is running
depnotifyStatus=`pgrep DEPNotify`
while [ $depnotifyStatus ]
do
    sleep 1
    depnotifyStatus=`pgrep DEPNotify`
done

# Removing DEPNotify and support files
echo "Removing DEPNotify.app and temp directory..."
rm -rf /Applications/Utilities/DEPNotify.app
rm -rf /var/tmp/*

exit 0
