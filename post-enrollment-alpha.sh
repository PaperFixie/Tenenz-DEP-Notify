#!/bin/bash

# Begin DEPNotify Clean-Up
# Caffeination Clean-Up
echo "Fully caffeinated..."
pkill caffeinate

# Create DEPNotify Setup doneFile.
mkdir /Library/Application\ Support/JAMF/ExtensionAttributes/
touch /Library/Application\ Support/JAMF/ExtensionAttributes/com.depnotify.provisioning.done

exit 0
