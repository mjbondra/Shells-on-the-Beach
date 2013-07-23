#!/bin/sh

## load configuration if it exists and CONFIG_FILE=1
preprocess_configuration() {
  if [ ! -f "$APP_ROOT/config/$APP_NAME.conf" ]; then
    if [ ! -f "$APP_ROOT/config/$APP_NAME.conf.tpl" ]; then
      if [ $CONFIG_FILE -eq 1 ]; then
        app_log "Cannot load app configuration because it does not exist at $APP_ROOT/config/$APP_NAME.conf NOR does a template exist at $APP_ROOT/config/$APP_NAME.conf.tpl" 10
        app_exit 1 "If $APP_NAME is not meant to have a separate configuration file, set CONFIG_FILE=0 in your app.sh script" 1
      fi
    else
      cp "$APP_ROOT/config/$APP_NAME.conf.default" "$APP_ROOT/config/$APP_NAME.conf"
    fi
  else
    . "$APP_ROOT/config/$APP_NAME.conf"
  fi
}
