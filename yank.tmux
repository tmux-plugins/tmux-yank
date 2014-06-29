#!/usr/bin/env bash

CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

source "$CURRENT_DIR/scripts/key_binding_helpers.sh"

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

set_copy_mode_bindings() {
	local copy_command="$1"
	tmux bind-key -t vi-copy "$(yank_key)"     copy-pipe "$copy_command"
	tmux bind-key -t vi-copy "$(put_key)"      copy-pipe "tmux paste-buffer"
	tmux bind-key -t vi-copy "$(yank_put_key)" copy-pipe "$copy_command; tmux paste-buffer"

	tmux bind-key -t emacs-copy "$(yank_key)"     copy-pipe "$copy_command"
	tmux bind-key -t emacs-copy "$(put_key)"      copy-pipe "tmux paste-buffer"
	tmux bind-key -t emacs-copy "$(yank_put_key)" copy-pipe "$copy_command; tmux paste-buffer"
}

set_copy_line_bindings() {
	tmux bind-key "$(yank_line_key)" run-shell "$CURRENT_DIR/scripts/copy_line.sh"
}

main() {
	local copy_command="$(clipboard_copy_command)"
	error_handling_if_command_not_present "$copy_command"
	set_copy_mode_bindings "$copy_command"
	set_copy_line_bindings
}
main
