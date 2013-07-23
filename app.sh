#!/bin/sh

## static global variables available throughout the app
APP_NAME="Shells on the Beach"
CONFIG_FILE=0 # indicates that the app should not look for an additional configuration file
ERROR_LOG=1 # indicates that the app should conceal errors, and log them in a separate file


## DO NOT EDIT BELOW THIS LINE... or do it, I don't care.
#---------------------------------------------------------#

## determine path to app for includes
APP_EXECUTION_PATH="$0"
APP_EXECUTION_FILENAME="$(basename "$0")"
APP_EXECUTION_ROOT="$(cd "$(dirname "$APP_EXECUTION_PATH")"; pwd)"
if [ -h "$APP_EXECUTION_PATH" ]; then
  SYMLINK_PATH="$APP_EXECUTION_PATH"
  while [ -h "$(cd "$(dirname "$SYMLINK_PATH")"; pwd)/$(cd "$(dirname "$SYMLINK_PATH")"; readlink "$(basename "$SYMLINK_PATH")")" ]; do
    SYMLINK_PATH="$(cd "$(dirname "$SYMLINK_PATH")"; pwd)/$(cd "$(dirname "$SYMLINK_PATH")"; readlink "$(basename "$SYMLINK_PATH")")"
  done
  APP_FILENAME="$(basename "$(readlink "$SYMLINK_PATH")")"
  APP_ROOT="$(cd "$(dirname "$SYMLINK_PATH")"; cd "$(dirname "$(readlink "$(basename "$SYMLINK_PATH")")")"; pwd)"
else
  APP_FILENAME="$(basename "$APP_EXECUTION_PATH")"
  APP_ROOT="$(cd "$(dirname "$APP_EXECUTION_PATH")"; pwd)"  
fi

## include the framework script
. "$APP_ROOT/sotb/sotb.sh" "$@"

