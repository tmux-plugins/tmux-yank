#!/usr/bin/env bash

CURRENT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
HELPERS_DIR="$CURRENT_DIR"

# shellcheck source=scripts/helpers.sh
source "${HELPERS_DIR}/helpers.sh"

pane_current_path() {
    tmux display -p -F "#{pane_current_path}"
}

display_notice() {
    display_message 'PWD copied to clipboard!'
}

main() {
    local copy_command
    # shellcheck disable=SC2119
    copy_command="$(clipboard_copy_command)"
    # $copy_command below should not be quoted
    if type "clip.exe" >/dev/null 2>&1; then # WSL clipboard command
        pane_current_path | tr -d '\n' | clip.exe
    else
        pane_current_path | tr -d '\n' | $copy_command
    fi
    display_notice
}
main
