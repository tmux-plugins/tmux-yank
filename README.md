# Tmux Yank

Enables copying to system clipboard in Tmux. Works on Linux and OS X.

Key bindings:
- `prefix + y` - copies text from the command line to clipboard. It does **not**
  mess up the command you're writing.<br/>
  This feature works for any shell or repl where `readline` is enabled.
  To test this check if `Ctrl-a` binding takes you to the start of the line.
  This should work for all popular shells/repls, but please try out it for your
  specific scenario.<br/>
  Tested and working for:
  - shells: `bash`, `zsh` (with `bindkey -e`), `tcsh`
  - repls: `irb`, `pry`, `node`, `psql`, `python`, `php -a`, `coffee`
  - remote shells: `ssh`, [mosh](http://mosh.mit.edu/)

**copy mode** bindings:
- `y` - copy selection to system clipboard
- `Ctrl-y` - "put" selection - equivalent to copying a selection, and pasting it to the command line
- `Alt-y` - performs both of the above: copy to system clipboard and
  put to command line

#### OS X requirements

- [reattach-to-user-namespace](https://github.com/ChrisJohnsen/tmux-MacOSX-pasteboard)<br/>
  If you already don't have this, then install:
  `$ brew install reattach-to-user-namespace`.

#### Linux requirements

- `xclip` command<br/>
  You most likely already have `xclip`, but if not:
  - Debian / Ubuntu: `$ sudo apt-get install xclip`
  - Red hat / CentOS: `$ yum install xclip`

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

Tmux yank works well with [tmux copycat](https://github.com/tmux-plugins/tmux-copycat).

### License

[MIT](LICENSE.md)
