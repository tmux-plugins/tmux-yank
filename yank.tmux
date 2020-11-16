#!/usr/bin/env bash

CURRENT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SCRIPTS_DIR="${CURRENT_DIR}/scripts"
HELPERS_DIR="${CURRENT_DIR}/scripts"

# Try to find the executable path of the currently running
# tmux server, fallback to just "tmux" if not found or no
# procfs aviliable (non-linux).
export TMUX_CMD_PATH=$(realpath "/proc/$(tmux display -p '#{pid}')/exe" 2> /dev/null || echo "tmux" | sed -z '$ s/\n$//')
echo "tmux executable used: $TMUX_CMD_PATH"

# shellcheck source=scripts/helpers.sh
source "${HELPERS_DIR}/helpers.sh"

clipboard_copy_without_newline_command() {
    local copy_command="$1"
    printf "tr -d '\\n' | %s" "$copy_command"
}

set_error_bindings() {
    local key_bindings key
    key_bindings="$(yank_key) $(put_key) $(yank_put_key)"
    for key in $key_bindings; do
        if tmux_is_at_least 2.4; then
            $TMUX_CMD_PATH bind-key -T copy-mode-vi "$key" send-keys -X copy-pipe-and-cancel "$TMUX_CMD_PATH display-message 'Error! tmux-yank dependencies not installed!'"
            $TMUX_CMD_PATH bind-key -T copy-mode "$key" send-keys -X copy-pipe-and-cancel "$TMUX_CMD_PATH display-message 'Error! tmux-yank dependencies not installed!'"
        else
            $TMUX_CMD_PATH bind-key -t vi-copy "$key" copy-pipe "$TMUX_CMD_PATH display-message 'Error! tmux-yank dependencies not installed!'"
            $TMUX_CMD_PATH bind-key -t emacs-copy "$key" copy-pipe "$TMUX_CMD_PATH display-message 'Error! tmux-yank dependencies not installed!'"
        fi
    done
}

error_handling_if_command_not_present() {
    local copy_command="$1"
    if [ -z "$copy_command" ]; then
        set_error_bindings
        exit 0
    fi
}

# `yank_without_newline` binding isn't intended to be used by the user. It is
# a helper for `copy_line` command.
set_copy_mode_bindings() {
    local copy_command="$1"
    local copy_wo_newline_command
    copy_wo_newline_command="$(clipboard_copy_without_newline_command "$copy_command")"
    local copy_command_mouse
    copy_command_mouse="$(clipboard_copy_command "true")"
    if tmux_is_at_least 2.4; then
        $TMUX_CMD_PATH bind-key -T copy-mode-vi "$(yank_key)" send-keys -X "$(yank_action)" "$copy_command"
        $TMUX_CMD_PATH bind-key -T copy-mode-vi "$(put_key)" send-keys -X copy-pipe-and-cancel "$TMUX_CMD_PATH paste-buffer"
        $TMUX_CMD_PATH bind-key -T copy-mode-vi "$(yank_put_key)" send-keys -X copy-pipe-and-cancel "$copy_command; $TMUX_CMD_PATH paste-buffer"
        $TMUX_CMD_PATH bind-key -T copy-mode-vi "$(yank_wo_newline_key)" send-keys -X "$(yank_action)" "$copy_wo_newline_command"
        if [[ "$(yank_with_mouse)" == "on" ]]; then
            $TMUX_CMD_PATH bind-key -T copy-mode-vi MouseDragEnd1Pane send-keys -X "$(yank_action)" "$copy_command_mouse"
        fi

        $TMUX_CMD_PATH bind-key -T copy-mode "$(yank_key)" send-keys -X "$(yank_action)" "$copy_command"
        $TMUX_CMD_PATH bind-key -T copy-mode "$(put_key)" send-keys -X copy-pipe-and-cancel "$TMUX_CMD_PATH paste-buffer"
        $TMUX_CMD_PATH bind-key -T copy-mode "$(yank_put_key)" send-keys -X copy-pipe-and-cancel "$copy_command; $TMUX_CMD_PATH paste-buffer"
        $TMUX_CMD_PATH bind-key -T copy-mode "$(yank_wo_newline_key)" send-keys -X "$(yank_action)" "$copy_wo_newline_command"
        if [[ "$(yank_with_mouse)" == "on" ]]; then
            $TMUX_CMD_PATH bind-key -T copy-mode MouseDragEnd1Pane send-keys -X "$(yank_action)" "$copy_command_mouse"
        fi
    else
        $TMUX_CMD_PATH bind-key -t vi-copy "$(yank_key)" copy-pipe "$copy_command"
        $TMUX_CMD_PATH bind-key -t vi-copy "$(put_key)" copy-pipe "$TMUX_CMD_PATH paste-buffer"
        $TMUX_CMD_PATH bind-key -t vi-copy "$(yank_put_key)" copy-pipe "$copy_command; $TMUX_CMD_PATH paste-buffer"
        $TMUX_CMD_PATH bind-key -t vi-copy "$(yank_wo_newline_key)" copy-pipe "$copy_wo_newline_command"
        if [[ "$(yank_with_mouse)" == "on" ]]; then
            $TMUX_CMD_PATH bind-key -t vi-copy MouseDragEnd1Pane copy-pipe "$copy_command_mouse"
        fi

        $TMUX_CMD_PATH bind-key -t emacs-copy "$(yank_key)" copy-pipe "$copy_command"
        $TMUX_CMD_PATH bind-key -t emacs-copy "$(put_key)" copy-pipe "$TMUX_CMD_PATH paste-buffer"
        $TMUX_CMD_PATH bind-key -t emacs-copy "$(yank_put_key)" copy-pipe "$copy_command; $TMUX_CMD_PATH paste-buffer"
        $TMUX_CMD_PATH bind-key -t emacs-copy "$(yank_wo_newline_key)" copy-pipe "$copy_wo_newline_command"
        if [[ "$(yank_with_mouse)" == "on" ]]; then
            $TMUX_CMD_PATH bind-key -t emacs-copy MouseDragEnd1Pane copy-pipe "$copy_command_mouse"
        fi
    fi
}

set_normal_bindings() {
    $TMUX_CMD_PATH bind-key "$(yank_line_key)" run-shell -b "$SCRIPTS_DIR/copy_line.sh"
    $TMUX_CMD_PATH bind-key "$(yank_pane_pwd_key)" run-shell -b "$SCRIPTS_DIR/copy_pane_pwd.sh"
}

main() {
    local copy_command
    copy_command="$(clipboard_copy_command)"
    error_handling_if_command_not_present "$copy_command"
    set_copy_mode_bindings "$copy_command"
    set_normal_bindings
}
main
