#!/bin/bash

# Validate Args
EXPECTED_ARGS=1
if [ $# -ne $EXPECTED_ARGS ]; then
  echo "Usage: `basename $0` PROVISIONING_PROFILE_NAME"
  exit 1
fi

# Defaults
TARGET="$1"
PROFILE_TYPE="distribution"
DEST="$HOME/Library/MobileDevice/Provisioning Profiles/"

# List the profiles
LOOP_INDEX=1
ios profiles:list "$PROFILE_TYPE" | grep Active | cut -f 2 -d "|" | sed 's/^ *//g' | sed 's/ *$//g' | while read PROFILE; do
  
  # Find a profile matching the target name
  if [ "$TARGET" == "$PROFILE" ]; then
    # Download the profile
    PROFILE_FILE=`echo "$LOOP_INDEX" | ios profiles:download "$PROFILE_TYPE" | grep "Successfully downloaded:" | cut -f 2 -d \'`
    
    # Install the profile
    mv "$PROFILE_FILE" "$DEST"
    
    echo "Installed: $PROFILE_FILE"
    break
  fi
  
  LOOP_INDEX=`expr $LOOP_INDEX + 1`
done