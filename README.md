[![Build
Status](https://travis-ci.org/tmux-plugins/tmux-yank.svg?branch=master)](https://travis-ci.org/tmux-plugins/tmux-yank)
[![GitHub
release](https://img.shields.io/github/release/tmux-plugins/tmux-yank.svg)](https://github.com/tmux-plugins/tmux-yank/releases)
[![GitHub
issues](https://img.shields.io/github/issues/tmux-plugins/tmux-yank.svg)](https://github.com/tmux-plugins/tmux-yank/issues)

tmux-yank
=========

Copy to the system clipboard in [`tmux`](https://tmux.github.io/).

Supports:

-   Linux
-   macOS
-   Cygwin
-   Windows Subsystem for Linux (WSL)
-   Termux

Installing
----------

### Via TPM (recommended)

The easiest way to install `tmux-yank` is via the [Tmux Plugin
Manager](https://github.com/tmux-plugins/tpm).

1.  Add plugin to the list of TPM plugins in `.tmux.conf`:

    ``` tmux
    set -g @plugin 'tmux-plugins/tmux-yank'
    ```

2.  Use <kbd>prefix</kbd>–<kbd>I</kbd> install `tmux-yank`. You should now
    be able to `tmux-yank` immediately.
3.  When you want to update `tmux-yank` use <kbd>prefix</kbd>–<kbd>U</kbd>.

### Manual Installation

1.  Clone the repository

    ``` sh
    $ git clone https://github.com/tmux-plugins/tmux-yank ~/clone/path
    ```

2.  Add this line to the bottom of `.tmux.conf`

    ``` tmux
    run-shell ~/clone/path/yank.tmux
    ```

3.  Reload the `tmux` environment

    ``` sh
    # type this inside tmux
    $ tmux source-file ~/.tmux.conf
    ```

You should now be able to use `tmux-yank` immediately.

Requirements
------------

In order for `tmux-yank` to work, there must be a program that store data in
the system clipboard.

### macOS

-   [`reattach-to-user-namespace`](https://github.com/ChrisJohnsen/tmux-MacOSX-pasteboard)

**Note**: Some versions of macOS (aka OS X) have been reported to work
without `reattach-to-user-namespace`. It doesn't hurt to have it installed.

-   OS X 10.8: Mountain Lion – *required*
-   OS X 10.9: Mavericks – *required*
-   OS X 10.10: Yosemite – *not required*
-   OS X 10.11: El Capitan – *not required*
-   macOS 10.12: Sierra – *required*
-   macOS 10.14: Mojave - *required*
-   macOS 10.15: Catalina - *not required*

The easiest way to use `reattach-to-user-namespace` with `tmux` is use to
use the [`tmux-sensible`](https://github.com/tmux-plugins/tmux-sensible)
plugin.

To use it manually, use:

``` tmux
# ~/.tmux.conf
set-option -g default-command "reattach-to-user-namespace -l $SHELL"
```

If you have `tmux` 1.5 or newer and are using
[iTerm2](https://www.iterm2.com/) version 3 or newer then the <kbd>y</kbd>
in `copy-mode` and mouse selection will work without `tmux-yank`.

To enable this:

1.  Go into iTerm2's preferences.
2.  Go to the "General" tab.
3.  Check "Applications in terminal may access clipboard"
4.  In `tmux`, ensure `set-clipboard` is turned on:

    ``` sh
    $ tmux show-options -g -s set-clipboard
    set-clipboard on
    ```

#### [HomeBrew](https://brew.sh/) (recommended)

``` sh
$ brew install reattach-to-user-namespace
```

#### MacPorts

``` sh
$ sudo port install tmux-pasteboard
```

### Linux

-   `xsel` (recommended) or `xclip` (for X).
-   `wl-copy` from [wl-clipboard](https://github.com/bugaevc/wl-clipboard) (for Wayland)

If you have `tmux` 1.5 or newer and are using `xterm`, the <kbd>y</kbd> in
`copy-mode` and mouse selection will work without `tmux-yank`. See the
`tmux(1)` man page entry for the `set-clipboard` option.

#### Debian & Ubuntu

``` sh
$ sudo apt-get install xsel # or xclip
```

#### RedHat & CentOS

``` sh
$ sudo yum install xsel # or xclip
```

### Cygwin

-   (*optional*) `putclip` which is part of the `cygutils-extra` package.

### Windows Subsystem for Linux (WSL)

-   `clip.exe` is shipped with Windows Subsystem for Linux.

### Termux

Install [Termux:API](https://github.com/termux/termux-api) plugin and
`termux-api` package.
``` sh
$ pkg install termux-api
```

Configuration
-------------

### Key bindings

-   Normal Mode
    -   <kbd>prefix</kbd>–<kbd>y</kbd> — copies text from the command line
        to the clipboard.

        Works with all popular shells/repls. Tested with:

        -   shells: `bash`, `zsh` (with `bindkey -e`), `tcsh`
        -   repls: `irb`, `pry`, `node`, `psql`, `python`, `php -a`,
            `coffee`
        -   remote shells: `ssh`, [mosh](http://mosh.mit.edu/)
        -   vim/neovim command line (requires
            [vim-husk](https://github.com/bruno-/vim-husk) or
            [vim-rsi](https://github.com/tpope/vim-rsi) plugin)

    -   <kbd>prefix</kbd>–<kbd>Y</kbd> — copy the current pane's current
        working directory to the clipboard.

-   Copy Mode
    -   <kbd>y</kbd> — copy selection to system clipboard.
    -   <kbd>Y</kbd> (shift-y) — "put" selection. Equivalent to copying a
        selection, and pasting it to the command line.


### Default and Preferred Clipboard Programs

tmux-yank does its best to detect a reasonable choice for a clipboard
program on your OS.

If tmux-yank can't detect a known clipboard program then it uses the
`@custom_copy_command` tmux option as your clipboard program if set.

If you need to always override tmux-yank's choice for a clipboard program,
then you can set `@override_copy_command` to force tmux-yank to use whatever
you want.

Note that both programs _must_ accept `STDIN` for the text to be copied.

An example of setting `@override_copy_command`:

``` tmux
# ~/.tmux.conf

set -g @custom_copy_command 'my-clipboard-copy --some-arg'
# or
set -g @override_copy_command 'my-clipboard-copy --some-arg'
```

### Linux Clipboards

Linux has several cut-and-paste clipboards: `primary`, `secondary`, and
`clipboard` (default in tmux-yank is `clipboard`).

You can change this by setting `@yank_selection`:

``` tmux
# ~/.tmux.conf

set -g @yank_selection 'primary' # or 'secondary' or 'clipboard'
```

With mouse support turned on (see below) the default clipboard for mouse
selections is `primary`.

You can change this by setting `@yank_selection_mouse`:

``` tmux
# ~/.tmux.conf

set -g @yank_selection_mouse 'clipboard' # or 'primary' or 'secondary'
```

### Controlling Yank Behavior

By default, `tmux-yank` will exit copy mode after yanking text. If you wish to
remain in copy mode, you can set `@yank_action`:

``` tmux
# ~/.tmux.conf

set -g @yank_action 'copy-pipe' # or 'copy-pipe-and-cancel' for the default
```

### Mouse Support

`tmux-yank` has mouse support enabled by default. It will only work if `tmux`'s
built-in mouse support is also enabled (with `mouse on` since `tmux` 2.1, or
`mode-mouse on` in older versions).

To yank with the mouse, click and drag with the primary button to begin
selection, and release to yank.

If you would prefer to disable this behavior, or provide your own bindings for
the `MouseDragEnd1Pane` event, you can do so with:

``` tmux
# ~/.tmux.conf

set -g @yank_with_mouse off # or 'on'
```

If you want to remain in copy mode after making a mouse selection, set
`@yank_action` as described above.

### vi mode support

If using `tmux` 2.3 or older *and* using vi keys then you'll have add the
following configuration setting:

``` tmux
# ~/.tmux.conf

set -g @shell_mode 'vi'
```

This isn't needed with `tmux` 2.4 or newer.

### Screen-cast

[![screencast
screenshot](/video/screencast_img.png)](https://vimeo.com/102039099)

**Note**: The screen-cast uses <kbd>Control</kbd>–<kbd>y</kbd> for
"put selection". Use <kbd>Y</kbd> in `v2.0.0` and later.

### Other tmux plugins

-   [tmux-copycat](https://github.com/tmux-plugins/tmux-copycat) - a plugin
    for regular expression searches in tmux and fast match selection
-   [tmux-open](https://github.com/tmux-plugins/tmux-open) - a plugin for
    quickly opening highlighted file or a URL
-   [tmux-continuum](https://github.com/tmux-plugins/tmux-continuum) -
    automatic restoring and continuous saving of tmux environment.

### License

[MIT](LICENSE.md)
