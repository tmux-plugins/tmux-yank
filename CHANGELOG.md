# Changelog

### master
- add 'copy pane current directory' feature

### v2.2.0, Oct 12, 2015
- add support for custom copy command (if xclip and others aren't accessible, and you want to have your
  custom copy command)
- add cygwin support via `putclip` command

### v2.1.0, Jun 17, 2015
- add support for `xsel` on linux (@ctjhoa)
- make `reattach-to-user-namespace` on OS X optional (@bosr)
- support for shell `vi` mode (@xnaveira)
- deprecate `Alt-y`

### v2.0.0, Dec 06, 2014
- change copy mode "put selection" key binding to `Y` so that vi mode `Ctrl-y`
  is not overriden.

### v1.0.0, Dec 06, 2014
- simplify README
- remove screencast from the master branch because it's too large for download.
  The screencast is moved to the separate `screencast` branch and can be cloned
  from there.
- show error message if plugin dependencies aren't insalled
- update README related plugins list
- update README to show how to update xclip selection on Linux
- add vagrant-related setup files for testing on Linux

### v0.0.4, Jul 29, 2014
- update readme to reflect github organization change
- add screencast script file
- import screencast project
- add `video/README.md`
- put screencast in the readme

### v0.0.3, Jun 29, 2014

- adds wait time for 'yank line' when in the remote shell (ssh, mosh) so yank
  line is more correct
- fix bug when yank-line is used in the last line in buffer. New 'solution' is
  implemented for copying multiple lines.
- code cleanup
- yank-line never yanks 'newline' char for multiple-line commands in shell (this
  is actually tmux/bash bug).

### v0.0.2, Jun 25, 2014

- updated readme
- for OS X, also check if 'reattach-to-user-namespace' is installed
- add a feature for copying current command line to clipboard

### v0.0.1, Jun 24, 2014

- first working version
