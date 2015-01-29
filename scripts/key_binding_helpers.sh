yank_line="y"
yank_line_option="@yank_line"

yank_default="y"
yank_option="@copy_mode_yank"

put_default="Y"
put_option="@copy_mode_put"

yank_put_default="M-y"
yank_put_option="@copy_mode_yank_put"

yank_wo_newline_default="!"
yank_wo_newline_option="@copy_mode_yank_wo_newline"

yank_selection_default="clipboard"
yank_selection_option="@yank_selection"

# helper functions
get_tmux_option() {
	local option="$1"
	local default_value="$2"
	local option_value=$(tmux show-option -gqv "$option")
	if [ -z "$option_value" ]; then
		echo "$default_value"
	else
		echo "$option_value"
	fi
}

yank_line_key() {
	echo "$(get_tmux_option "$yank_line_option" "$yank_line")"
}

yank_key() {
	echo "$(get_tmux_option "$yank_option" "$yank_default")"
}

put_key() {
	echo "$(get_tmux_option "$put_option" "$put_default")"
}

yank_put_key() {
	echo "$(get_tmux_option "$yank_put_option" "$yank_put_default")"
}

yank_wo_newline_key() {
	echo "$(get_tmux_option "$yank_wo_newline_option" "$yank_wo_newline_default")"
}

yank_selection() {
	echo "$(get_tmux_option "$yank_selection_option" "$yank_selection_default")"
}

# Ensures a message is displayed for 5 seconds in tmux prompt.
# Does not override the 'display-time' tmux option.
display_message() {
	local message="$1"

	# display_duration defaults to 5 seconds, if not passed as an argument
	if [ "$#" -eq 2 ]; then
		local display_duration="$2"
	else
		local display_duration="5000"
	fi

	# saves user-set 'display-time' option
	local saved_display_time=$(get_tmux_option "display-time" "750")

	# sets message display time to 5 seconds
	tmux set-option -gq display-time "$display_duration"

	# displays message
	tmux display-message "$message"

	# restores original 'display-time' value
	tmux set-option -gq display-time "$saved_display_time"
}
