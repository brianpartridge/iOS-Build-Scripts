#!/bin/bash

# Expected Jenkins environment variables
# - JOB_NAME
# - BUILD_NUMBER
# - BUILD_CONFIGURATION
# - GIT_COMMIT
# - PACKAGED_IPA_PATH
# - PACKAGED_DSYM_PATH

if [ "" = "$JOB_NAME" ]; then
  JOB_NAME="Undefined"
fi

if [ "" = "$BUILD_NUMBER" ]; then
  BUILD_NUMBER="0"
fi

if [ "" = "$BUILD_CONFIGURATION" ]; then
  BUILD_CONFIGURATION="AdHoc"
fi

REVISION="0"
if [ "" != "$GIT_COMMIT" ]; then
  REVISION="$GIT_COMMIT"
fi

# Configuration
env
API_TOKEN="<INSERT TOKEN HERE>"
TEAM_TOKEN="<INSERT TOKEN HERE"
LISTS="Internal,BetaTesters,etc" # Comma separated

# Testflight validation

if [ "AdHoc" != "$BUILD_CONFIGURATION" ]; then
  echo "Unsupported build configuration for Testflight deployment"
  exit 0
fi

if [ ! -f "$PACKAGED_IPA_PATH" ]; then
  echo "Error: $PACKAGED_IPA_PATH not found"
  exit 1
fi

if [ ! -f "$PACKAGED_DSYM_PATH" ]; then
  echo "Error: $PACKAGED_DSYM_PATH not found"
  exit 1
fi

NOTES="$JOB_NAME
Build: $BUILD_NUMBER
Revision: $REVISION"

# Deploy to Testflight

echo "Deploying build to Testflight"
curl http://testflightapp.com/api/builds.json -F file=@"$PACKAGED_IPA_PATH" -F dsym=@"$PACKAGED_DSYM_PATH" -F api_token="$API_TOKEN" -F team_token="$TEAM_TOKEN" -F notes="$NOTES" -F notify=False -F replace=True -F distribution_lists="$LISTS"
