#!/bin/sh

## PRIMARY FUNCTION
#---------------------------------------------------------#

## function that will simulate arrays portably through a layer of concealed variable expansion
# write usage: arr [varname] [key] [value]
# read usage: arr [varname] [key]
# read usage (wrapped): $(arr [varname] [key])
arr() { req_arg "$@" %% "var_name" "var_key"

  if [ "$3" ]; then
    var_value="$3"
    eval "$(echo "${var_name}_${var_key}=\"${var_value}\"")"
    arr_index "$var_name" "$var_key"
  else
    arr_val="$(eval echo "\$${var_name}_${var_key}")"
    if [ "$arr_val" ]; then
      echo "$arr_val"
    else
      echo "'${var_name}' key '${var_key}' does not have a value!"
    fi
  fi
}


## SUPPLEMENTAL FUNCTIONS
#---------------------------------------------------------#

## function that ensures index values are only listed once
arr_index_clean() { req_arg "$@" %% "var_key" "arr_index"

  awked_index="$(echo "$arr_index" | awk -F '\\|'$var_key'\\|' '{ print $1 }')"
  if [ "$awked_index" = "$arr_index" ]; then
    echo "${arr_index}${var_key}|"
  else
    echo "${arr_index}"
  fi
}


## function that maintains a duplicate-free index of each array's keys
arr_index() { req_arg "$@" %% "var_name" "var_key"

  if [ "$(eval echo "\$${var_name}_arr_index")" ]; then
    old_index="$(eval echo "\$${var_name}_arr_index")"
    new_index="$(arr_index_clean "${var_key}" "${old_index}")"
    eval "$(echo "${var_name}_arr_index=\"${new_index}\"")"
  else
    eval "$(echo "${var_name}_arr_index=\"|${var_key}|\"")"
  fi
}


## function that will make numerically-indexed arrays from passed arguments
# usage: arr_from_args [varname] [args...]
arr_from_args() { req_arg "$@" %% "var_name" "var_val"
}


## INITIALIZATION
#---------------------------------------------------------#

