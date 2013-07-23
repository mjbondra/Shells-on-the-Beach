#!/bin/sh

## PRIMARY FUNCTION
#---------------------------------------------------------#

## stop application
app_exit() {
  if [ $1 -eq 1 ]; then
    app_log "$2" "$3"
    app_log "$APP_NAME aborting..." "$3"
    app_log_break
    exit 1
  else
    app_log "$APP_NAME stopping..." 10
    app_log_break
    exit 0
  fi
}


## SUPPLEMENTAL FUNCTIONS
#---------------------------------------------------------#


## INITIALIZATION
#---------------------------------------------------------#

