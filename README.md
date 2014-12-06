# Tmux Yank

Enables copying to system clipboard in Tmux. Works on Linux and OS X.

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

**copy mode** bindings:
- `y` - copy selection to system clipboard
- `Y` (shift-y) - "put" selection - equivalent to copying a selection, and
  pasting it to the command line
- `Alt-y` - performs both of the above: copy to system clipboard and
  put to command line

#### OS X requirements

- [reattach-to-user-namespace](https://github.com/ChrisJohnsen/tmux-MacOSX-pasteboard)<br/>
  If you don't have this already, then install:
  `$ brew install reattach-to-user-namespace`.

#### Linux requirements

- `xclip` command<br/>
  You most likely already have `xclip`, but if not:
  - Debian / Ubuntu: `$ sudo apt-get install xclip`
  - Red hat / CentOS: `$ yum install xclip`

### Copy command

**OS X**

Copying to clipboard is done using `pbcopy`.

**Linux**

Copying to clipboard is done using `xclip -selection c` command by default.

If copying is different on your system, and you need the command to be i.e.
`xclip -selection normal`, here's how to customize:

    # in .tmux.conf
    set -g @yank_selection "primary"

### Notes

**Mouse Support**

When making a selection using tmux `mode-mouse on` or `mode-mouse copy-mode`, you cannot rely on the default 'release mouse after selection to copy' behavior.  Instead, press `y` before releasing mouse.

### Installation with [Tmux Plugin Manager](https://github.com/tmux-plugins/tpm) (recommended)

Add plugin to the list of TPM plugins in `.tmux.conf`:

    set -g @tpm_plugins "          \
      tmux-plugins/tpm             \
      tmux-plugins/tmux-yank       \
    "

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

Tmux yank works well with
[tmux copycat](https://github.com/tmux-plugins/tmux-copycat) and
[tmux-open](https://github.com/tmux-plugins/tmux-open) plugins.

### License

[MIT](LICENSE.md)
