#!/usr/bin/env fish
# c - clipboard
# basically just an interface to the clipboard; works on linux and mac os
# just "c" to output the clipboard, or "c -" to send stdin to the clipboard.
# requires 'xclip' on linux

set uname (uname)

if test "$argv[1]" = '-'
    if test "$uname" = 'Darwin'
        pbcopy
    else
        xclip -i -selection clipboard
    end
else
    if test "$uname" = 'Darwin'
        pbpaste
    else
        xclip -o -selection clipboard
    end
end
