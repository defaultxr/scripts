#!/usr/bin/env fish
# c - Simplified clipboard interface.
# Works on Unixes supported by xclip and on macOS.
# By default, simply outputs the clipboard contents.
# With - as an argument, sets the clipboard to the text received on standard input.
# Use -p to use the primary selection instead of clipboard (doesn't work on macOS).
# requirements: xclip (unless on macOS)

set -- script "$(path basename (status filename))"

argparse -n "$script" 'h/help' 'p/primary' 'i/input' -- $argv

if set -q _flag_h
    echo "$script - Simplified clipboard interface"
    echo "Usage: $script [arguments]"
    echo
    echo "  -h/--help    - Print help and exit."
    echo "  -p/--primary - Use primary selection (selected text) instead of clipboard."
    echo "  -/-i/--input - Send stdin to the clipboard."
    exit
end

set uname (uname)

set selection (if set -q _flag_p; echo -n primary; else; echo -n clipboard; end)

if set -q _flag_i; or contains -- '-' $argv
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
