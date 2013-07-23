#!/bin/sh

## PRIMARY FUNCTION
#---------------------------------------------------------#

## read through a list of all possible routes
route_read() {
  routes_path="$APP_ROOT/sotb/app.routes"
  app_log "Read routes at $routes_path" 10
  while read route; do
    # ignore anything after '#' on any line
    route="$(echo "$route" | awk -F '#' '{ print $1 }')"
    # proceed to read, if there's something to read
    if [ "$route" ]; then
      route_args="$(echo "$route" | awk -F '[{}]' '{ print $2 }')"
      route_direction="$(echo "$route" | awk -F ' FROM' '{ print $1 }')"
      route_check
      # we are in a subshell, we want to break out of this before we pursue a route
      if [ $arg_match -eq 1 ]; then
        break
      elif [ $APP_ARG_COUNT -eq 0 ] && [ $route_args = "ROOT" ]; then
        arg_match=1
        break
      fi
    fi
  done < "$routes_path"

  # pursue a route if one has been discovered
  if [ $arg_match -eq 1 ]; then
    route_pursue
  else
    app_exit 1 "Route not found for $APP_EXECUTION_PATH $APP_ARGS" 1
  fi
}


## SUPPLEMENTAL FUNCTIONS
#---------------------------------------------------------#

## follow the directive prescribed by a confirmed and argument-matched route
route_pursue() {
  app_log "Follow route $route_direction in response to execution $APP_EXECUTION_PATH $APP_ARGS" 10
  route_controller="$(echo "$route_direction" | awk -F ' ' '{ print $1 }')"
  route_function="$(echo "$route_direction" | awk -F ' ' '{ print $2 }')"
  if [ $route_controller = "static" ]; then
    static_path="$APP_ROOT/sotb/static/$route_function"
    if [ -f "$static_path" ]; then
      app_log "Render $static_path" 10
      cat "$static_path"
    else
      app_exit 1 "FATAL ERROR! Cannot render $route_function because it does not exist at $static_path" 1
    fi
  elif [ "$route_controller" ]; then
    controller_path="$APP_ROOT/sotb/controllers/$route_controller.sh"
    if [ -f "$controller_path" ]; then
      app_log "Load $controller_path" 10
      . "$controller_path"
      app_log "Call $route_function() in $route_controller controller" 10
      "$route_controller"_controller "$route_function" "$parameters"
    else
      app_exit 1 "FATAL ERROR! Cannot load $route_controller because it does not exist at $controller_path" 1
    fi  
  fi
}


## check whether or not a particular route has been called by this execution
route_check() {
  # read route arguments
  route_arg_count=1
  while [ "$(echo "$route_args" | awk -F ';' '{ print $'$route_arg_count' }')" ]; do
    route_arg_tmp="$(echo "$route_args" | awk -F ';' '{ print $'$route_arg_count' }')"
    eval "$(echo "route_arg_${route_arg_count}=\"$route_arg_tmp\"")"
    route_arg_count=`expr $route_arg_count + 1`
  done
  route_arg_count=`expr $route_arg_count - 1` # lazy-fix

  # compare route arguments to app arguments
  arg_match=0
  if [ $APP_ARG_COUNT -eq $route_arg_count ]; then
    arg_match=1
    check_arg_count=1
    while [ $check_arg_count -le $route_arg_count ] && [ $arg_match -eq 1 ] ; do
      # create temporary variables for comparison
      app_arg_tmp="$(eval echo "\$APP_ARG_$check_arg_count")"
      route_arg_tmp="$(eval echo "\$route_arg_$check_arg_count")"
      if [ $route_arg_tmp != $app_arg_tmp ] && [ $route_arg_tmp != "%" ]; then
        arg_match=0
      fi
      check_arg_count=`expr $check_arg_count + 1`
    done
  fi
}

## INITIALIZATION
#---------------------------------------------------------#

