test_controller() {
  sotb_command() {
    printf "SOTB[$(pwd)]-> "
    read actionable_variable
    eval $actionable_variable
    sotb_command
  }

	$1 "$@"
}