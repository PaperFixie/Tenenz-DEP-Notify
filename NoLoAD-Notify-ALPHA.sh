#!/bin/bash

# Ensuring that the authchanger command is set to implement the notify window
/usr/local/bin/authchanger -reset -AD -postAuth NoMADLoginAD:Notify

# Reloading the login window
/usr/bin/killall -HUP loginwindow

# Variables for File Paths
JAMF_BINARY="/usr/local/bin/jamf"
DEP_NOTIFY_CONFIG="/var/tmp/depnotify.log"
TMP_DEBUG_LOG="/var/tmp/depNotifyDebug.log"

#########################################################################################
# Variables to Modify
#########################################################################################
# Testing flag will enable the following things to change:
# - Auto removal of BOM files to reduce errors
# - Sleep commands instead of polcies being called
# - Quit Key set to command + control + x
TESTING_MODE=false # Set variable to true or false

# Banner image can be 600px wide by 100px high. Images will be scaled to fit
# If this variable is left blank, the generic image will appear
BANNER_IMAGE_PATH="/Library/Application Support/NoLoAD Branding/tenenz-logo.png"

# Main heading that will be displayed under the image
# If this variable is left blank, the generic banner will appear
BANNER_TITLE="Welcome to Tenenz, Inc."

# Paragraph text that will display under the main heading. For a new line, use \n
# this variable is left blank, the generic message will appear. Leave single
# quotes below as double quotes will break the new line.
MAIN_TEXT='Thanks for joining us at Tenenz! We want you to have a few applications and settings configured before you get started with your new Mac. This process should take 10 to 20 minutes to complete. \n \n If you need addtional software or help, please visit the Self Service app in your Applications folder or on your Dock.'

# The policy array must be formatted "Progress Bar text,customTrigger". These will be
# run in order as they appear below.
  POLICY_ARRAY=(
    "Setting Timezone...,set_timezone"
    "Naming Mac...,name_mac"
    "Installing Utilities...,dockutil"
    "Installing Utilities...,fonts"
    "Installing Utilities...,desktoppr"
    "Installing NoMAD...,nomad"
    "Installing Java for Mac...,java"
    "Installing FileMaker Pro 15...,filemaker15"
    "Installing FileMaker Plug-Ins...,fmp15_plugins"
    "Installing FileMaker Pro 16...,filemaker16"
    "Installing FileMaker Plug-Ins...,fmp16_plugins"
    "Installing Microsoft Word...,word"
    "Installing Microsoft PowerPoint...,powerpoint"
    "Installing Microsoft Excel...,excel"
    "Installing Microsoft Outlook...,outlook"
    "Installing Chrome...,chrome"
    "Installing Firefox...,firefox"
    "Installing Slack...,slack"
    "Adding Printers,install_printers"
    "Swabbing Deck...,set_dock_items"
    "Polishing Apple...,set_tenenz_wallpaper"
    "Updating Inventory...,dep_update_inventory"
  )

# Text that will display in the progress bar
  INSTALL_COMPLETE_TEXT="Setup Complete!"

# Text that will display inside the alert once policies have finished
  COMPLETE_ALERT_TEXT="Your Mac is now finished with initial setup and configuration. Press Quit to get started!"

# Caffeinating

echo "Time to caffeniate..."
caffeinate -d -i -m -s -u &

# Configure DEPNotify starting window
# Setting custom image if specified
  if [ "$BANNER_IMAGE_PATH" != "" ]; then
    echo "Command: Image: $BANNER_IMAGE_PATH" >> "$DEP_NOTIFY_CONFIG"
  fi

# Setting custom title if specified
  if [ "$BANNER_TITLE" != "" ]; then
    echo "Command: MainTitle: $BANNER_TITLE" >> "$DEP_NOTIFY_CONFIG"
  fi

# Setting custom main text if specified
  if [ "$MAIN_TEXT" != "" ]; then
    echo "Command: MainText: $MAIN_TEXT" >> "$DEP_NOTIFY_CONFIG"
  fi

# Validating true/false flags
  if [ "$TESTING_MODE" != true ] && [ "$TESTING_MODE" != false ]; then
    echo "$(date "+%a %h %d %H:%M:%S"): Testing configuration not set properly. Currently set to '$TESTING_MODE'. Please update to true or false." >> "$TMP_DEBUG_LOG"
    exit 1
  fi

# Checking policy array and adding the count from the additional options above.
ARRAY_LENGTH="$((${#POLICY_ARRAY[@]}+ADDITIONAL_OPTIONS_COUNTER))"
echo "Command: Determinate: $ARRAY_LENGTH" >> "$DEP_NOTIFY_CONFIG"

# Loop to run policies
for POLICY in "${POLICY_ARRAY[@]}"; do
    echo "Status: $(echo "$POLICY" | cut -d ',' -f1)" >> "$DEP_NOTIFY_CONFIG"
    if [ "$TESTING_MODE" = true ]; then
      sleep 10
    elif [ "$TESTING_MODE" = false ]; then
      "$JAMF_BINARY" policy -event "$(echo "$POLICY" | cut -d ',' -f2)"
    fi
done

# Exit gracefully after things are finished
echo "Status: $INSTALL_COMPLETE_TEXT" >> "$DEP_NOTIFY_CONFIG"
echo "Command: Quit: $COMPLETE_ALERT_TEXT" >> "$DEP_NOTIFY_CONFIG"
exit 0
