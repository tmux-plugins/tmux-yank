# Tmux Yank

Enables copying to system clipboard in Tmux. Works on Linux and OS X.

Copy mode mappings:
- `y` - copy selection to system clipboard
- `C-y` - "put" selection to the command line
- `M-y` (Alt + y) - performs both of the above: copy to system clipboard and
  put to command line

### Requirements

#### OS X

- [reattach-to-user-namespace](https://github.com/ChrisJohnsen/tmux-MacOSX-pasteboard)<br/>
  If you already don't have this installed, then:
  `$ brew install reattach-to-user-namespace`.

#### Linux

- `xclip` command<br/>
  You most likely already have `xclip`, but if not install with:
  - Debian / Ubuntu: `$ sudo apt-get install xclip`
  - Red hat / CentOS: `$ yum install xclip`

### Installation with [Tmux Plugin Manager](https://github.com/bruno-/tpm) (recommended)

Add plugin to the list of TPM plugins in `.tmux.conf`:

    set -g @tpm_plugins "              \
      bruno-/tpm                       \
      bruno-/tmux_yank                 \
    "

Hit `prefix + I` to fetch the plugin and source it. You should now be able to
use the plugin.

### Manual Installation

Clone the repo:

    $ git clone https://github.com/bruno-/tmux_yank ~/clone/path

Add this line to the bottom of `.tmux.conf`:

    run-shell ~/clone/path/yank.tmux

Reload TMUX environment:

    # type this in terminal
    $ tmux source-file ~/.tmux.conf

You should now be able to use the plugin.

### Other Tmux goodies

Tmux yank works well with [tmux copycat](https://github.com/bruno-/tmux_copycat).

### License

[MIT](LICENSE.md)
