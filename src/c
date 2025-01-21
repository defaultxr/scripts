#!/usr/bin/env fish
# c - Simplified clipboard interface.
# Works on Unixes supported by xclip and on macOS.
# By default, simply outputs the clipboard contents.
# With - as an argument, sets the clipboard to the text received on standard input.
# Use -p to use the primary selection instead of clipboard (doesn't work on macOS).
# requirements: xclip (unless on macOS)

set -- script "$(path basename (status filename))"

argparse -n "$script" 'h/help' 'p/primary' 'i/input' 'a/args' -- $argv

if set -q _flag_h
    echo "$script - Simplified clipboard interface"
    echo "Usage: $script [arguments]"
    echo
    echo "  -h/--help    - Print help and exit."
    echo "  -p/--primary - Use primary selection (selected text) instead of clipboard."
    echo "  -/-i/--input - Send stdin to the clipboard."
    echo "  -a/--args    - Send arguments to the clipboard."
    exit
end

set uname (uname)

set selection (if set -q _flag_p; echo -n primary; else; echo -n clipboard; end)

function copy -d "Copy stdin to clipboard."
    if test "$uname" = 'Darwin'
        pbcopy
    else if test "$XDG_SESSION_TYPE" = 'wayland'
        wl-copy
    else
        xclip -i -selection $selection
    end
end

if set -q _flag_a
    string trim --right (string join ' ' $argv) | copy # FIX: not sure why it doesn't trim newlines from the right side??
    exit
end

if set -q _flag_i; or contains -- '-' $argv
    copy
else
    if test "$uname" = 'Darwin'
        pbpaste
    else if test "$XDG_SESSION_TYPE" = 'wayland'
        wl-paste
    else
        xclip -o -selection $selection
    end
end
