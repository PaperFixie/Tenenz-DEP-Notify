#!/bin/bash

# Standard Variables

dockStatus=`pgrep Dock`

until [ $dockStatus ]
do
    sleep 1
    dockStatus=`pgrep Dock`
done

echo "Dock process found, proceeding with enrollment..."

# Caffeinating

echo "Time to caffeniate..."
caffeinate -d -i -m -s -u &

# Jamf Helper Variables

jamfHelper="/Library/Application Support/JAMF/bin/jamfHelper.app/Contents/MacOS/jamfHelper"
windowType="hud"
description="Please wait while we prepare your computer! Core applications will begin installing momentarily."
icon="/Applications/Self Service.app/Contents/Resources/AppIcon.icns"
title="macOS Enrollment"
alignDescription="left"
alignHeading="center"

# Jamf Helper

userChoice=$("$jamfHelper" -windowType "$windowType" -lockHUD -icon "$icon" -title "$title" -description "$description" \
-alignDescription "$alignDescription" -alignHeading "$alignHeading" -timeout 5)

# Trigger next policy

/usr/local/jamf/bin/jamf policy -event "DEPNotify-Enrollment-dev"

exit 0
