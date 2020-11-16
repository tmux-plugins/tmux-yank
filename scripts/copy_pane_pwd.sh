#!/usr/bin/env bash

CURRENT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
HELPERS_DIR="$CURRENT_DIR"

source "$CURRENT_DIR/tmux_cmd_path.sh"

# shellcheck source=scripts/helpers.sh
source "${HELPERS_DIR}/helpers.sh"

pane_current_path() {
    $TMUX_CMD_PATH display -p -F "#{pane_current_path}"
}

display_notice() {
    display_message 'PWD copied to clipboard!'
}

main() {
    local copy_command
    local payload
    # shellcheck disable=SC2119
    copy_command="$(clipboard_copy_command)"
    payload="$(pane_current_path | tr -d '\n')"
    # $copy_command below should not be quoted
    echo "$payload" | $copy_command
    $TMUX_CMD_PATH set-buffer "$payload"
    display_notice
}
main
