# Changelog

### master
- update readme to reflect github organization change
- add screencast script file
- import screencast project
- add `video/README.md`

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
