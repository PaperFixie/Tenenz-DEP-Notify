#!/bin/bash

# Ensuring that the authchanger command is set to implement the notify window
/usr/local/bin/authchanger -reset -prelogin NoMADLoginAD:Notify

# Reloading the login window
/usr/bin/killall -HUP loginwindow

# DEPNotify Log file
DNLOG="/var/tmp/depnotify.log"

# Configure DEPNotify starting window
echo "Command: MainTitle: New Mac Setup" > $DNLOG
echo "Command: Image: /PATH/TO/A/PHOTO/YOU/WANT.png" >> $DNLOG
echo "Command: WindowStyle: NotMovable" >> $DNLOG
echo "Command: Status: Starting Configuration" >> $DNLOG
echo "Command: MainText: Welcome to your new Mac! \n\nYour Mac will now begin automatically installing pre-determined software.\
 It is recommend you ensure the machine is plugged into power." >> $DNLOG

# Getting triggered
caffeinate -disu bash -c '/usr/local/bin/jamf policy -trigger DEPNotify-Enrollment-alpha'

# Exiting with the policy return code to properly get error detection
exit $?
