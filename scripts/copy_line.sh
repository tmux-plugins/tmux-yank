#!/usr/bin/env bash

CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
TMUX_COPY_MODE=""

source "$CURRENT_DIR/key_binding_helpers.sh"

COPY_COMMAND="$*"

# sets a TMUX_COPY_MODE that is used as a global variable
get_tmux_copy_mode() {
	TMUX_COPY_MODE="$(tmux show-option -gwv mode-keys)"
}

go_to_the_beginning_of_current_line() {
	tmux send-key 'C-a'
}

enter_tmux_copy_mode() {
	tmux copy-mode
}

start_tmux_selection() {
	if [ "$TMUX_COPY_MODE" == "vi" ]; then
		# vi copy mode
		tmux send-key 'Space'
	else
		# emacs copy mode
		tmux send-key 'C-Space'
	fi
}

end_of_line_in_copy_mode() {
	if [ "$TMUX_COPY_MODE" == "vi" ]; then
		# vi copy mode
		tmux send-key '$'
	else
		# emacs copy mode
		tmux send-key 'C-e'
	fi
}

yank_to_clipboard() {
	tmux send-key "$(yank_key)"
}

go_to_the_end_of_current_line() {
	tmux send-keys 'C-e'
}

display_notice() {
	display_message 'Line copied to clipboard!'
}

yank_current_line() {
	go_to_the_beginning_of_current_line
	enter_tmux_copy_mode
	start_tmux_selection
	end_of_line_in_copy_mode
	yank_to_clipboard
	go_to_the_end_of_current_line
	display_notice
}

main() {
	get_tmux_copy_mode
	yank_current_line
}
main
