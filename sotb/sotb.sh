#!/bin/sh

########################################################
########################################################
##                                                    ##
##     .dMMMb  dMP dMP dMMMMMP dMP     dMP    .dMMMb  ##
##    dMP" VP dMP dMP dMP     dMP     dMP    dMP" VP  ##
##    VMMMb  dMMMMMP dMMMP   dMP     dMP     VMMMb    ##
##  dP .dMP dMP dMP dMP     dMP     dMP    dP .dMP    ##
##  VMMMP" dMP dMP dMMMMMP dMMMMMP dMMMMMP VMMMP"     ##
##                                                    ##
##     .aMMMb  dMMMMb      dMMMMMMP dMP dMP dMMMMMP   ##
##    dMP"dMP dMP dMP        dMP   dMP dMP dMP        ##
##   dMP dMP dMP dMP        dMP   dMMMMMP dMMMP       ##
##  dMP.aMP dMP dMP        dMP   dMP dMP dMP          ##
##  VMMMP" dMP dMP        dMP   dMP dMP dMMMMMP       ##
##                                                    ##
##      dMMMMb  dMMMMMP .aMMMb  .aMMMb  dMP dMP       ##
##     dMP"dMP dMP     dMP"dMP dMP"VMP dMP dMP        ##
##    dMMMMK" dMMMP   dMMMMMP dMP     dMMMMMP         ##
##   dMP.aMF dMP     dMP dMP dMP.aMP dMP dMP          ##
##  dMMMMP" dMMMMMP dMP dMP  VMMMP" dMP dMP  v.0.5    ##
##                                                    ##
########################################################
########################################################
##  a shell script framework

## store app arguments in a variable
APP_ARGUMENTS="$@"

## confirm that there is a directory for temporary data
TEMPORARY_DIRECTORY="$APP_ROOT/tmp"
if [ ! -d "$TEMPORARY_DIRECTORY" ]; then mkdir "$TEMPORARY_DIRECTORY"; fi

## find and load core function scripts in order
FUNCTIONS_DIRECTORY="$APP_ROOT/sotb/core-functions"
for filename in "$FUNCTIONS_DIRECTORY"/*.sh; do function_files="$function_files$filename\n"; done
functions_load_file="$TEMPORARY_DIRECTORY/.the_tide.sh" # the function scripts will 'ride the tide' out of the subshell
printf "#!/bin/sh\n\n" > "$functions_load_file"
printf "$(printf "$function_files\n" | sort)\n" | while read filename; do if [ -f "$filename" ] && [ "$filename" ]; then printf ". \"$filename\"\n" >> "$functions_load_file"; fi; done # write shell script executions into functions_load_file
. "$functions_load_file"
rm -f "$functions_load_file"

app_arguments_process "$@"
route_read
app_exit 0

