#!bash
# shellcheck disable=SC2239

CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# shellcheck source=scripts/tmux_cmd_path.sh
source "$CURRENT_DIR/tmux_cmd_path.sh"

yank_line="y"
yank_line_option="@yank_line"

yank_pane_pwd="Y"
yank_pane_pwd_option="@yank_pane_pwd"

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

yank_selection_mouse_default="primary"
yank_selection_mouse_option="@yank_selection_mouse"

yank_with_mouse_default="on"
yank_with_mouse_option="@yank_with_mouse"

yank_action_default="copy-pipe-and-cancel"
yank_action_option="@yank_action"

shell_mode_default="emacs"
shell_mode_option="@shell_mode"

custom_copy_command_default=""
custom_copy_command_option="@custom_copy_command"

override_copy_command_default=""
override_copy_command_option="@override_copy_command"

# helper functions
get_tmux_option() {
    local option="$1"
    local default_value="$2"
    local option_value
    option_value=$($TMUX_CMD_PATH show-option -gqv "$option")
    if [ -z "$option_value" ]; then
        echo "$default_value"
    else
        echo "$option_value"
    fi
}

yank_line_key() {
    get_tmux_option "$yank_line_option" "$yank_line"
}

yank_pane_pwd_key() {
    get_tmux_option "$yank_pane_pwd_option" "$yank_pane_pwd"
}

yank_key() {
    get_tmux_option "$yank_option" "$yank_default"
}

put_key() {
    get_tmux_option "$put_option" "$put_default"
}

yank_put_key() {
    get_tmux_option "$yank_put_option" "$yank_put_default"
}

yank_wo_newline_key() {
    get_tmux_option "$yank_wo_newline_option" "$yank_wo_newline_default"
}

yank_selection() {
    get_tmux_option "$yank_selection_option" "$yank_selection_default"
}

yank_selection_mouse() {
    get_tmux_option "$yank_selection_mouse_option" "$yank_selection_mouse_default"
}

yank_with_mouse() {
    get_tmux_option "$yank_with_mouse_option" "$yank_with_mouse_default"
}

yank_action() {
    get_tmux_option "$yank_action_option" "$yank_action_default"
}

shell_mode() {
    get_tmux_option "$shell_mode_option" "$shell_mode_default"
}

custom_copy_command() {
    get_tmux_option "$custom_copy_command_option" "$custom_copy_command_default"
}

override_copy_command() {
    get_tmux_option "$override_copy_command_option" "$override_copy_command_default"
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
    local saved_display_time
    saved_display_time=$(get_tmux_option "display-time" "750")

    # sets message display time to 5 seconds
    $TMUX_CMD_PATH set-option -gq display-time "$display_duration"

    # displays message
    $TMUX_CMD_PATH display-message "$message"

    # restores original 'display-time' value
    $TMUX_CMD_PATH set-option -gq display-time "$saved_display_time"
}

command_exists() {
    local command="$1"
    type "$command" >/dev/null 2>&1
}

clipboard_copy_command() {
    local mouse="${1:-false}"
    # installing reattach-to-user-namespace is recommended on OS X
    if [ -n "$(override_copy_command)" ]; then
        override_copy_command
    elif command_exists "pbcopy"; then
        if command_exists "reattach-to-user-namespace"; then
            echo "reattach-to-user-namespace pbcopy"
        else
            echo "pbcopy"
        fi
    elif command_exists "clip.exe"; then # WSL clipboard command
        echo "cat | clip.exe"
    elif command_exists "wl-copy"; then # wl-clipboard: Wayland clipboard utilities
        echo "wl-copy"
    elif command_exists "xsel"; then
        local xsel_selection
        if [[ $mouse == "true" ]]; then
            xsel_selection="$(yank_selection_mouse)"
        else
            xsel_selection="$(yank_selection)"
        fi
        echo "xsel -i --$xsel_selection"
    elif command_exists "xclip"; then
        local xclip_selection
        if [[ $mouse == "true" ]]; then
            xclip_selection="$(yank_selection_mouse)"
        else
            xclip_selection="$(yank_selection)"
        fi
        echo "xclip -selection $xclip_selection"
    elif command_exists "putclip"; then # cygwin clipboard command
        echo "putclip"
    elif [ -n "$(custom_copy_command)" ]; then
        custom_copy_command
    fi
}

# Cache the TMUX version for speed.
tmux_version="$($TMUX_CMD_PATH -V | cut -d ' ' -f 2 | sed 's/next-//')"

tmux_is_at_least() {
    if [[ $tmux_version == "$1" ]] || [[ $tmux_version == master ]]; then
        return 0
    fi

    local i
    local -a current_version wanted_version
    IFS='.' read -ra current_version <<<"$tmux_version"
    IFS='.' read -ra wanted_version <<<"$1"

    # fill empty fields in current_version with zeros
    for ((i = ${#current_version[@]}; i < ${#wanted_version[@]}; i++)); do
        current_version[i]=0
    done

    # fill empty fields in wanted_version with zeros
    for ((i = ${#wanted_version[@]}; i < ${#current_version[@]}; i++)); do
        wanted_version[i]=0
    done

    for ((i = 0; i < ${#current_version[@]}; i++)); do
        if ((10#${current_version[i]} < 10#${wanted_version[i]})); then
            return 1
        fi
        if ((10#${current_version[i]} > 10#${wanted_version[i]})); then
            return 0
        fi
    done
    return 0
}
