#!/bin/bash

# Begin DEPNotify Clean-Up
# Caffeination Clean-Up
echo "Fully caffeinated..."
pkill caffeinate

# Removing DEPNotify files
echo "Removing DEPNotify.app and temp directory..."
rm -rf /Applications/Utilities/DEPNotify.app
rm -rf /var/tmp/*

mkdir /Library/Application\ Support/JAMF/ExtensionAttributes/
touch /Library/Application\ Support/JAMF/ExtensionAttributes/com.depnotify.provisioning.done

exit 0
