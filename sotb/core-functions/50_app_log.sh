#!/bin/sh

## PRIMARY FUNCTION
#---------------------------------------------------------#

## logging function
app_log() {
  local log_output="$APP_NAME[$(date +"%m/%d/%Y %H:%M:%S")]: $1"
  if [ $LOG_LEVEL -ge $2 ]
  then
    if [ ! -f "$LOG_PATH" ]; then
      if [ ! -d "$(dirname "$LOG_PATH")" ]; then
        mkdir -p "$(dirname "$LOG_PATH")"
        touch "$LOG_PATH"
        app_log "Created directory: $(dirname "$LOG_PATH")" 10
      else
        touch "$LOG_PATH"
      fi
      app_log "Created log file: $LOG_PATH" 10
    fi
    echo "$log_output" >> "$LOG_PATH"
  fi

  if [ $PRINT_LEVEL -ge $2 ]; then
    echo "$log_output"
  fi
}


## SUPPLEMENTAL FUNCTIONS
#---------------------------------------------------------#

## add line break to log
app_log_break() {
  echo "" >> "$LOG_PATH"
}

## divert error message to a dedicated log file
app_log_error_log() {
  pass_error_file="$TEMPORARY_DIRECTORY/pass.error"
  if [ ! -f "$pass_error_file" ]; then
    touch "$pass_error_file"
    if [ -f "$pass_error_file" ]; then
      app_log "Restarting $APP_NAME with execution: $APP_EXECUTION_ROOT/$APP_EXECUTION_FILENAME $APP_ARGUMENTS 2>>$(dirname "$LOG_PATH")/error.log" 1
      "$APP_EXECUTION_ROOT/$APP_EXECUTION_FILENAME" $APP_ARGUMENTS 2>>"$(dirname "$LOG_PATH")/error.log" # start app again with error logging
      exit 0
    fi
  else # do not continue to restart the app over and over again
    rm -f "$pass_error_file" 
  fi
}


## INITIALIZATION
#---------------------------------------------------------#

# set logging and print levels to max until config derived settings are loaded
LOG_LEVEL=10
PRINT_LEVEL=10

# set log path relative to app root and app name
LOG_PATH="$APP_ROOT/log/$(echo_lowercase_alphanumeric "$APP_NAME").log"

# trap errors in a file
if [ $ERROR_LOG = 1 ]; then app_log_error_log; fi

# log startup
app_log "$APP_NAME starting..." 10
