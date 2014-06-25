yank_line="y"
yank_line_option="@yank_line"

yank_default="y"
yank_option="@copy_mode_yank"

put_default="C-y"
put_option="@copy_mode_put"

yank_put_default="M-y"
yank_put_option="@copy_mode_yank_put"

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
