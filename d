#!/usr/bin/env fish
# d - "Delete" (trash) a file, also removing it from any TMSU database.

set -- script "$(path basename (status filename))"

argparse -n "$script" 'h/help' -- $argv

if set -q _flag_h
    echo "$script - \"Delete\" (trash) a file, also removing it from any TMSU database."
    echo "Usage: $script [arguments]"
    echo
    echo "  -h/--help - Print help and exit."
    exit
end

# commented this because it might delete tags inadvertently
# if command -q tmsu
#     tmsu repair -R -p $argv 2>/dev/null
# end

set os (uname)

if test "$os" = 'Linux'
    trash-put $argv
else if test "$os" = 'Darwin'
    trash $argv
else
    echo "$script: Error: Unsupported OS: $os" >&2
    exit 1
end
