# Tmux yank screencast script

1 - Intro - what's the plugin about
===================================
Actions
-------
- none, just clear screen

Script
------
In this screencast we'll demo a tmux yank plugin.

This plugin enables you to copy some text from tmux to the system clipboard,
along with some extra functionality we'll show.
It was made to complement tmux copycat plugin which we'll also be using for
selection in this screencast.

2 - problems with vanilla tmux and `y`
==============================
Actions
-------
- $ echo 'example url https://github.com/tmux-plugins/tmux-yank'
- highlight url
- enter
- paste url

- remove url
- highlight url again
- 'y'
- paste with cmd + v

Script
------
Let's show a problem scenario you might be having with tmux.

I'll generate some example output with a url in the terminal.

Okay, now I want to copy that url and open it in the browser.
By using tmux copycat saved search I'll quickly select the url.

I'll press enter, a "bajnding" for copy.
I can now paste it in tmux by pressing prefix + right angle bracket.

That works, but there's a problem. Tmux paste works only within tmux. Pressing
prefix + right angle bracket won't work in the browser where I actually want the
above url to be.


Ideally, when I copy some text in tmux, I want it to be available for paste
anywhere on the system with control-v or command-v if I'm on a Mac.

Enter tmux-yank which enables just that.
I'll select the url again.

Tmux-yank provides a convenient "bajnding" so that pressing 'y' in copy mode
copies the text and makes it available in system clipboard.

I'm on a mac so I'll press command-v and there you have you have it.
It goes without saying that this paste will work in the browser.


Personally, I use tmux-yank copying all the time so I don't have to think in
terms of being in tmux versus working with the rest of the system.

And also, this way I can avoid tmux default paste binding 'prefix + right angle
bracket' because it is a bit clunky and unintuitive.

3 - showing 'ctrl-y'
====================
Actions
-------
- git status -sb (file1.txt, file2.txt, file3.txt)
- git add
- highlight last file
- y
- paste and enter to git add a file

- clear screen
- git status -sb
- git add
- highlight last file
- ctrl-y and git add a file

- cmd - v

Script
------
Let's show another feature.

I'll invoke git status command for the project I'm in.
Now I want to git add only the last file.

I'll select the last file, yank and paste.

Do you think we can optimize this?

Often with tmux there's a need to copy a selection, and paste it to the command
line immediately.

Tmux-yank provides a so called 'put selection' command. Let's demo it.

I'll highlight another git status file and press control-y.
The selection is immediately 'put' to the command line. That's one step, instead
of two.


A nice side-effect of 'put selection' command is that it preserves the system
clipboard content.
If I press command-v now you'll see that the clipboard still contains the
previous entry. 'put selection' command didn't overwrite it.

4. show 'line yank'
===================
Actions
-------
- clear pane scrollback
- split window
- echo 'some command'
- ctrl-p to show the last command
- prefix + y

- go the the pane on the right
- cmd - v

Script
------
The last tmux-yank feature I'd like to show is 'line yank'.

It enables you to quickly copy the current command line to system clipoard.
The nice thing is, it also works for commands that strech multiple lines.

But here's the basic example. I'll write a simple command.

Okay, that works. Now, I want to execute that same command in the pane on the
right. I could of course type the command again, but that's tedious and I could
make a typo.

Another solution is mouse selection, but that's just slow and lame.


I'll use the 'line yank' feature.
I'll press prefix + 'y' and the command is copied. Notice there were no changes
to the command itself - it is intact.

In the second pane on the right I can paste the line with command - v.

5. show 'line yank' with the production server
==============================================
Actions
-------
- left pane - local psql console
- right pane - psql console on developsta
- prepared create_table command on the left
- execute the command, it's ok
- show the command again
- show that mouse selection is innefective
- prefix + y

- switch to right pane
- paste
- enter

Script
------
One scenario where I find line yank feature really useful is when I have to
execute a command on the production server.

Here I have the local environment in the left pane, and I'm connected to
the production server in the right pane.

The task I want to perform is creating a database table on the
production server.
Frankly, I feel hesitatnt to type that command straight on production.

I'd rather first try and debug it locally, and then execute it on production.

Let's do that then. I'll open a database console locally and type the command.


Oh, it looks like I have a typo. It's good I tried this locally first.

Ok, the command works and is now ready. How do I now run in on production?
Typing this again, with the possibility of making a typo is not an option.
Let's try mouse selection.

Hm, that won't work either. It seems I can't scope mouse
selection to the left pane.

Let's now try line yank with prefix + 'y'.
Notice we're copying a multi-line command.

I'll paste it in the right pane.

That looks ok, so I'll execute it.. and it's good.

6. Outro
========
Actions
-------
- just a blank screen

Script
------
That's it for this screencast. I hope you'll find tmux-yank useful.
