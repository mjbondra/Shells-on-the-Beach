#!/bin/sh

## PRIMARY FUNCTION
#---------------------------------------------------------#


## SUPPLEMENTAL FUNCTIONS
#---------------------------------------------------------#

## make sure that a clean temporary directory exists for app data
preprocess_tmp() {
  tmp_folder="${APP_ROOT}/.tmp"
  if [ -d "$tmp_folder" ] && [ "$tmp_folder" ] && [ $tmp_folder != "/" ]; then
    rm -rf "$tmp_folder"
    preprocess_tmp
  else
    mkdir -p "$tmp_folder"
    if [ ! -d "$tmp_folder" ]; then
      app_exit 1 "Unable to create directory ${tmp_folder}" 1
    fi
  fi
}


## INITIALIZATION
#---------------------------------------------------------#
