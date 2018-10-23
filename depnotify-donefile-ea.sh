#!/bin/bash

doneFile="/Library/Application Support/JAMF/ExtensionAttributes/com.depnotify.provisioning.done"

# Check for com.depnotify.provisioning.done file in specified $doneFile path
if [[ -e "${doneFile}" ]]; then
  echo "<result>Done</result>"
else
  echo "<result>Not Done</result>"
fi
