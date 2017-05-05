CHANGELOG
=========

### master

-   Add 'copy pane current directory' feature

### v2.2.0, Oct 12, 2015

-   Add support for custom copy command (if `xclip` and others aren't
    accessible, and you want to have your custom copy command)
-   Add Cygwin support via `putclip` command

### v2.1.0, Jun 17, 2015

-   Add support for `xsel` on Linux (@ctjhoa)
-   Make `reattach-to-user-namespace` on OS X optional (@bosr)
-   Support for shell `vi` mode (@xnaveira)
-   Deprecate <kbd>Alt</kbd>–<kbd>y</kbd>

### v2.0.0, Dec 06, 2014

-   Change copy mode *put selection* key binding to <kbd>Y</kbd> so that vi
    mode <kbd>Ctrl</kbd>–<kbd>y</kbd> is not overridden.

### v1.0.0, Dec 06, 2014

-   Remove screen-cast from the master branch because it's too large for
    download. The screen-cast is moved to the separate `screencast` branch
    and can be cloned from there.
-   Show error message if plugin dependencies aren't installed.
-   Update `README` related plugins list
-   Update `README` to show how to update `xclip` selection on Linux
-   Add vagrant-related setup files for testing on Linux

### v0.0.4, Jul 29, 2014

-   Update `README` to reflect GitHub organization change
-   Add screen-cast script file
-   Import screen-cast project
-   Add `video/README.md`
-   Put screen-cast in the `README`

### v0.0.3, Jun 29, 2014

-   Adds wait time for 'yank line' when in the remote shell (`ssh`, `mosh`)
    to capture the most accurate value.
-   Fix bug when yank-line is used in the last line in buffer. New
    'solution' is implemented for copying multiple lines.
-   Code cleanup.
-   yank-line never yanks 'newline' char for multiple-line commands in shell
    (this is actually tmux/bash bug).

### v0.0.2, Jun 25, 2014

-   Updated `README`.
-   For OS X, also check if `reattach-to-user-namespace` is installed.
-   Add a feature for copying current command line to clipboard.

### v0.0.1, Jun 24, 2014

-   First working version.
