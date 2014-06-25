#!/usr/bin/env bash

CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

yank_default="y"
yank_option="@yank"

put_default="C-y"
put_option="@put"

yank_put_default="M-y"
yank_put_option="@yank_put"

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

yank_key() {
	echo "$(get_tmux_option "$yank_option" "$yank_default")"
}

put_key() {
	echo "$(get_tmux_option "$put_option" "$put_default")"
}

yank_put_key() {
	echo "$(get_tmux_option "$yank_put_option" "$yank_put_default")"
}

command_exists() {
	local command="$1"
	type "$command" >/dev/null 2>&1
}

clipboard_copy_command() {
	if command_exists "xclip"; then
		echo "xclip"
	# reattach-to-user-namespace is required for OS X
	elif command_exists "pbcopy" && command_exists "reattach-to-user-namespace"; then
		echo "reattach-to-user-namespace pbcopy"
	fi
}

set_error_bindings() {
	local key_bindings="$(yank_key) $(put_key) $(yank_put_key)"
	local key
	for key in $key_bindings; do
		tmux bind-key -t vi-copy    "$key" copy-pipe "$CURRENT_DIR/scripts/tmux_yank_error_message.sh"
		tmux bind-key -t emacs-copy "$key" copy-pipe "$CURRENT_DIR/scripts/tmux_yank_error_message.sh"
	done
}

error_handling_if_command_not_present() {
	local copy_command="$1"
	if [ -z "$copy_command" ]; then
		set_error_bindings
		exit 0
	fi
}

set_bindings() {
	local copy_command="$1"
	tmux bind-key -t vi-copy "$(yank_key)"     copy-pipe "$copy_command"
	tmux bind-key -t vi-copy "$(put_key)"      copy-pipe "tmux paste-buffer"
	tmux bind-key -t vi-copy "$(yank_put_key)" copy-pipe "$copy_command; tmux paste-buffer"

	tmux bind-key -t emacs-copy "$(yank_key)"     copy-pipe "$copy_command"
	tmux bind-key -t emacs-copy "$(put_key)"      copy-pipe "tmux paste-buffer"
	tmux bind-key -t emacs-copy "$(yank_put_key)" copy-pipe "$copy_command; tmux paste-buffer"
}

main() {
	local copy_command="$(clipboard_copy_command)"
	error_handling_if_command_not_present "$copy_command"
	set_bindings "$copy_command"
}
main
