# Tmux Yank

Enables copying to system clipboard in Tmux.

Tested and working on Linux, OSX and Cygwin.

### Screencast

[![screencast screenshot](/video/screencast_img.png)](https://vimeo.com/102039099)

Note: screencast shows using the "put selection" feature with `Ctrl-y` key
binding in copy mode. In `v2.0.0` this key binding was changed to `Y` (shift-y).

### Key bindings

- `prefix + y` - copies text from the command line to clipboard.<br/>
  Works with all popular shells/repls. Tested with:
  - shells: `bash`, `zsh` (with `bindkey -e`), `tcsh`
  - repls: `irb`, `pry`, `node`, `psql`, `python`, `php -a`, `coffee`
  - remote shells: `ssh`, [mosh](http://mosh.mit.edu/)
  - vim/neovim command line (requires
    [vim-husk](https://github.com/bruno-/vim-husk) or
    [vim-rsi](https://github.com/tpope/vim-rsi) plugin)

- `prefix + Y` (shift-y) - copy pane current working directory to clipboard.

**copy mode** bindings:
- `y` - copy selection to system clipboard
- `Y` (shift-y) - "put" selection - equivalent to copying a selection, and
  pasting it to the command line
- `Alt-y` - performs both of the above: copy to system clipboard and
  put to command line (deprecated, not useful)

#### OS X requirements

- [reattach-to-user-namespace](https://github.com/ChrisJohnsen/tmux-MacOSX-pasteboard)<br/>
  Install with brew `$ brew install reattach-to-user-namespace` or
  macports `$ sudo port install tmux-pasteboard`.

  *Note*: Beginning with OSX Yosemite (10.10), `pbcopy` is reported to work
  correctly with `tmux`, so we believe `reattach-to-user-namespace` is not
  needed anymore. Please install it in case the plugin doesn't work for you.

#### Linux requirements

- `xclip` OR `xsel` command<br/>
  You most likely already have one of them, but if not:
  - Debian / Ubuntu: `$ sudo apt-get install xclip` or `$ sudo apt-get install xsel`
  - Red hat / CentOS: `$ yum install xclip` or `$ yum install xsel`

#### Cygwin requirements

- `putclip` command<br/>
  Get the command by installing `cygutils-extra` package with Cygwin's
  `setup*.exe`.

### Notes

**Mouse Support**

When making a selection using tmux `mode-mouse on` or `mode-mouse copy-mode`,
you cannot rely on the default 'release mouse after selection to copy' behavior.
Instead, press `y` before releasing mouse.

**Shell vi mode compatibility**

    # in .tmux.conf
    set -g @shell_mode 'vi'

**Linux clipboard**

Copying to clipboard is done using `xclip -selection clipboard` or
`xsel --clipboard` command by default.

If copying is different on your system, and you need the command to be i.e.
`xclip -selection primary` or `xsel -i --primary`, here's how to customize:

    # in .tmux.conf
    set -g @yank_selection 'primary'

Use full names as option ('primary', 'secondary', 'clipboard')

### Installation with [Tmux Plugin Manager](https://github.com/tmux-plugins/tpm) (recommended)

Add plugin to the list of TPM plugins in `.tmux.conf`:

    set -g @plugin 'tmux-plugins/tmux-yank'

Hit `prefix + I` to fetch the plugin and source it. You should now be able to
use the plugin.

### Manual Installation

Clone the repo:

    $ git clone https://github.com/tmux-plugins/tmux-yank ~/clone/path

Add this line to the bottom of `.tmux.conf`:

    run-shell ~/clone/path/yank.tmux

Reload TMUX environment:

    # type this in terminal
    $ tmux source-file ~/.tmux.conf

You should now be able to use the plugin.

### Other Tmux goodies

- [tmux-copycat](https://github.com/tmux-plugins/tmux-copycat) - a plugin for
  regex searches in tmux and fast match selection
- [tmux-open](https://github.com/tmux-plugins/tmux-open) - a plugin for quickly
  opening highlighted file or a url
- [tmux-continuum](https://github.com/tmux-plugins/tmux-continuum) - automatic
  restoring and continuous saving of tmux env

You might want to follow [@brunosutic](https://twitter.com/brunosutic) on
twitter if you want to hear about new tmux plugins or feature updates.

### License

[MIT](LICENSE.md)
