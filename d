#!/usr/bin/env fish
# d - "Delete" (trash) a file, also removing it from any TMSU database.

set -- script "$(basename (status filename))"

argparse -n "$script" 'h/help' -- $argv

if set -q _flag_h
    echo "$script  - "Delete" (trash) a file, also removing it from any TMSU database."
    echo "Usage: $script [arguments]"
    echo
    echo "  -h/--help - Print help and exit."
    exit
end

if command -q tmsu
    tmsu repair -R -p $argv 2>/dev/null
end

trash-put $argv
