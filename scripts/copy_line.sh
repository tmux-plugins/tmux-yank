#!/usr/bin/env bash

CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
HELPERS_DIR="$CURRENT_DIR"
TMUX_COPY_MODE=""

REMOTE_SHELL_WAIT_TIME="0.4"

# shellcheck source=scripts/helpers.sh
source "${HELPERS_DIR}/helpers.sh"

# sets a TMUX_COPY_MODE that is used as a global variable
get_tmux_copy_mode() {
    TMUX_COPY_MODE="$(tmux show-option -gwv mode-keys)"
}

# The command when on ssh with latency. To make it work in this case too,
# sleep is added.
add_sleep_for_remote_shells() {
    local pane_command
    pane_command="$(tmux display-message -p '#{pane_current_command}')"
    if [[ "$pane_command" =~ (ssh|mosh) ]]; then
        sleep "$REMOTE_SHELL_WAIT_TIME"
    fi
}

go_to_the_beginning_of_current_line() {
    if [ "$(shell_mode)" == "emacs" ]; then
        tmux send-key 'C-a'
    else
        tmux send-key 'Escape' '0'
    fi
}

enter_tmux_copy_mode() {
    tmux copy-mode
}

start_tmux_selection() {
    if tmux_is_at_least 2.4; then
        tmux send -X begin-selection
    elif [ "$TMUX_COPY_MODE" == "vi" ]; then
        # vi copy mode
        tmux send-key 'Space'
    else
        # emacs copy mode
        tmux send-key 'C-Space'
    fi
}

# works when command spans accross multiple lines
end_of_line_in_copy_mode() {
    if tmux_is_at_least 2.4; then
        tmux send -X -N 150 'cursor-down'		# 'down' key. 'vi' mode is faster so we're
        # jumping more lines than emacs.
        tmux send -X 'end-of-line'		# End of line (just in case we are already at the last line).
        tmux send -X 'previous-word'		# Beginning of the previous word.
        tmux send -X 'next-word-end'		# End of next word.
    elif [ "$TMUX_COPY_MODE" == "vi" ]; then
        # vi copy mode
        # This sequence of keys consistently selects multiple lines
        tmux send-key '150'		# Go to the bottom of scrollback buffer by using
        tmux send-key 'j'		# 'down' key. 'vi' mode is faster so we're
        # jumping more lines than emacs.
        tmux send-key '$'		# End of line (just in case we are already at the last line).
        tmux send-key 'b'		# Beginning of the previous word.
        tmux send-key 'e'		# End of next word.
    else
        # emacs copy mode
        for (( c=1; c<='30'; c++ )); do		# go to the bottom of scrollback buffer
            tmux send-key 'C-n'
        done
        tmux send-key 'C-e'
        tmux send-key 'M-b'
        tmux send-key 'M-f'
    fi
}

yank_to_clipboard() {
    if tmux_is_at_least 2.4; then
        tmux send -X copy-pipe-and-cancel "$(clipboard_copy_command)"
    else
        tmux send-key "$(yank_wo_newline_key)"
    fi
}

go_to_the_end_of_current_line() {
    if [ "$(shell_mode)" == "emacs" ]; then
        tmux send-keys 'C-e'
    else
        tmux send-keys '$' 'a'
    fi
}

yank_current_line() {
    go_to_the_beginning_of_current_line
    add_sleep_for_remote_shells
    enter_tmux_copy_mode
    start_tmux_selection
    end_of_line_in_copy_mode
    yank_to_clipboard
    go_to_the_end_of_current_line
    display_message 'Line copied to clipboard!'
}

main() {
    get_tmux_copy_mode
    yank_current_line
}
main
