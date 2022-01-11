#!/usr/bin/env fish
# c - clipboard
# a simple interface to the clipboard.
# works on unixes supported by xclip and mac os.
# by default, simply outputs the clipboard contents.
# use - as an argument to send stdin to the clipboard.
# use -p to use the primary selection instead of clipboard (except on mac os).
# on linux, requires xclip.

argparse -n c 'p/primary' -- $argv

set uname (uname)

set selection (if test -n "$_flag_p"; echo -n primary; else; echo -n clipboard; end)

if test -n "$_flag_i"; or contains -- '-' $argv
    if test "$uname" = 'Darwin'
        pbcopy
    else
        xclip -i -selection $selection
    end
else
    if test "$uname" = 'Darwin'
        pbpaste
    else
        xclip -o -selection $selection
    end
end
