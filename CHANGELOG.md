Change Log
==========

[master]
--------

### Added

-   Tmux 2.4 support (@docwhat, @edi9999)
-   Windows Subsystem for Linux (WSL) support via `clip.exe` (@lukewang1024)
-   "copy pane current directory" feature (@bruno-)
-   `yank_line` and `yank_pane_pwd` fork to prevent xclip from hanging Tmux (@leoalekseyev)
*   `yank_line` no longer cares if you use emacs or vi in copy-mode.

### Fixed

-   Detect git builds of tmux version ≥ 2.4 (@maximbaz PR#89)

[v2.2.0] 2015-10-12
-------------------

### Added

-   Support for custom copy command (if `xclip` and others aren't
    accessible, and you want to have your custom copy command)
-   Cygwin support via `putclip` command

[v2.1.0] 2015-06-17
-------------------

### Added

-   Add support for `xsel` on Linux (@ctjhoa)
-   Support for shell `vi` mode (@xnaveira)

### Updated

-   Make `reattach-to-user-namespace` on OS X optional (@bosr)
-   Deprecate <kbd>Alt</kbd>–<kbd>y</kbd>

[v2.0.0] 2014-12-06
-------------------

### Fixed

-   Change copy mode "put selection" key binding to <kbd>Y</kbd> so that vi
    mode <kbd>Control</kbd>–<kbd>y</kbd> is not overridden.

[v1.0.0] 2014-12-06
-------------------

### Added

-   Show error message if plugin dependencies aren't installed.
-   Vagrant setup for manually testing Linux.

### Updated

-   `README`
    -   Related plugin list
    -   Instructions on updating `xclip` for Linux.

### Removed

-   The screen-cast is moved into `screencast` branch.

[v0.0.4] 2014-07-29
-------------------

### Updated

-   `README` documentation; including a screen-cast.

[v0.0.3] 2014-06-29
-------------------

### Added

-   Wait when doing "yank line" when using a remote shell (`ssh`, `mosh`) to
    ensure screen is updated.

### Fixed

-   Handle `yank-line` when used on the last line of buffer: copy multiple
    lines.
-   `yank-line` never yanks 'newline' char for multiple-line commands in
    shell (this is actually tmux/bash bug).

### Updated

-   Code cleanup.

[v0.0.2] 2014-06-25
-------------------

### Updated

    - `README`

### Added

    - In OS X: Check if `reattach-to-user-namespace` is installed.
    - "copy current command line" feature.

[v0.0.1] 2014-06-24
-------------------

-   First working version.

Notes
-----

This change log is kept in <http://keepachangelog.com/> format.

  [master]: https://github.com/tmux-plugins/tmux-yank/compare/v2.2.0...HEAD
  [v2.2.0]: https://github.com/tmux-plugins/tmux-yank/compare/v2.1.0...v2.2.0
  [v2.1.0]: https://github.com/tmux-plugins/tmux-yank/compare/v2.0.0...v2.1.0
  [v2.0.0]: https://github.com/tmux-plugins/tmux-yank/compare/v1.0.0...v2.0.0
  [v1.0.0]: https://github.com/tmux-plugins/tmux-yank/compare/v0.0.4...v1.0.0
  [v0.0.4]: https://github.com/tmux-plugins/tmux-yank/compare/v0.0.3...v0.0.4
  [v0.0.3]: https://github.com/tmux-plugins/tmux-yank/compare/v0.0.2...v0.0.3
  [v0.0.2]: https://github.com/tmux-plugins/tmux-yank/compare/v0.0.1...v0.0.2
  [v0.0.1]: https://github.com/tmux-plugins/tmux-yank/commits/v0.0.1
