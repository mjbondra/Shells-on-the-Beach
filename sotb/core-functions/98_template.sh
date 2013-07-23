#!/bin/sh

## PRIMARY FUNCTION
#---------------------------------------------------------#


## SUPPLEMENTAL FUNCTIONS
#---------------------------------------------------------#


## INITIALIZATION
#---------------------------------------------------------#

## Replace a templates tokens with input values and save
template_populate() {
  echo ""
}


template_line_digest() {
  rl="$1"
  rd="$(echo "$rl" | awk -F '%%' '{ print $2 }')"
  rdCount=1
  if [ $rd ]; then
    rdList[$rdCount]="$rd"
    echo "${rdList[1]}"
  fi
}


template_prompt_input() {
  # need to think of a good way to do this -- 'read' fucntion is not being read in other functions, only outside of them in the general script
  # generate a dummy script and execute it to accomplish this? blahblah.sh with read function outside of function
  echo ""
}


## read a template
template_load() {
  render_method="$2"
  echo "$render_method: "
  while read template_line; do
    echo "$template_line"
  done < "$APP_ROOT/$1"
}
