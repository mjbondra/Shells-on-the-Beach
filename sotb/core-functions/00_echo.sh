#!/bin/sh

## PRIMARY FUNCTION
#---------------------------------------------------------#

## replace echo (within app scope) to something more portable
echo() { 
  printf %s\\n "$*" 
}


## SUPPLEMENTAL FUNCTIONS
#---------------------------------------------------------#

## reduces a string to alphanumeric characters (and '_'), then transforms to lowercase
echo_lowercase_alphanumeric() {
  echo "$(echo "$1" | tr -cd '\n[:alnum:] ""' | tr '[:blank:]' '_' | tr '[A-Z]' '[a-z]' )"
}


## INITIALIZATION
#---------------------------------------------------------#
