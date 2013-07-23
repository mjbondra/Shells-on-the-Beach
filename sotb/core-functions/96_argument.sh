#!/bin/sh

## PRIMARY FUNCTION
#---------------------------------------------------------#

## require and name arguments in a function
# usage: req_arg "$@" %% [arg name for $1] [arg name for $2 (optional)] ... [arg name for $n (optional)]
req_arg() {
  req_arg_count=1
  req_arg_data_count=0
  req_arg_assignment_count=0
  req_arg_phase=0
  while [ "$(eval echo "\$$req_arg_count")" ]; do
    c="$(eval echo "\$$req_arg_count")"
    if [ $req_arg_phase -eq 0 ]; then
      if [ "$c" = "%%" ]; then
        req_arg_phase=1
      else
        req_arg_data_count=`expr $req_arg_data_count + 1`
      fi
    elif [ $req_arg_phase -eq 1 ]; then
      req_arg_assignment_count=`expr $req_arg_assignment_count + 1`
      if [ $req_arg_assignment_count -le $req_arg_data_count ]; then
        eval "$(echo "${c}=\"\$${req_arg_assignment_count}\"")"
      else
        echo "Error! Required value for \$${c} was not found!"
        break
      fi
    fi 
    req_arg_count=`expr $req_arg_count + 1`
  done
}


## SUPPLEMENTAL FUNCTIONS
#---------------------------------------------------------#

## process and globalize user arguments
app_arguments_process() {
  APP_ARGS="$@"
  APP_ARG_COUNT="$#"
  active_arg_count=1
  while [ $active_arg_count -le $APP_ARG_COUNT ]; do
    active_arg_value="$(eval echo "\$$active_arg_count")"  
    arr "APP_ARG" "$active_arg_count" "$active_arg_value"
    active_arg_count=`expr $active_arg_count + 1`
  done
}

## INITIALIZATION
#---------------------------------------------------------#

