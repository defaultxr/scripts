#!/usr/bin/env fish
# e - Edit the specified file(s).

# settings:

# list of hostnames of local workstations (i.e. machines that Emacs will be running on, as opposed to remote servers that you will SSH/Tramp into)
set local_hostnames

# plist of remote machines, mapping their hostname to their short names
set remote_machines

# code:

set -- script "$(path basename (status filename))"

argparse -n $script 'h/help' 'd/diff' 'f/foreground' -- $argv

if set -q _flag_h
    echo "$script - Edit the specified file(s)."
    echo "Usage: $script [arguments]"
    echo
    echo "  -h/--help       - Print help and exit."
    echo "  -d/--diff       - Diff two files."
    echo "  -f/--foreground - Don't exit this invocation of $script until the file is closed."
    exit
end

set foreground $_flag_f

function tramp_prefix -d 'Get the tramp prefix for Emacs if not in $local_hostnames.'
    set -l shortname (plist-get "$hostname" $remote_machines)
    if test -z "$shortname"
        set shortname "$hostname"
    end
    if not contains $shortname $local_hostnames
        echo "/ssh:$shortname:"
    end
end

function run_emacs -d "Actually call emacsclient"
    if test -n "$foreground"
        emacsclient --tramp="$(tramp_prefix)" $argv
    else
        emacsclient --tramp="$(tramp_prefix)" $argv >/dev/null &
    end
end

function ediff -d "Run ediff."
    set -l prefix (tramp_prefix)
    emacsclient -f ~/.emacs.d/server/server --eval "(ediff-files \"$prefix$argv[1]\" \"$prefix$argv[2]\")"
end

if test (count $argv) -lt 1
    warn -t "$script" -l 'error' "Error: No filename provided."
    exit 1
end

# stumpish 'eval (stumpwm::save-es-called-win)' 2>/dev/null

if test $argv[-1] = '-'
    set tmp (mktemp)
    and cat > $tmp
    and run_emacs $tmp
    # rm $tmp # if auto-revert-mode is enabled, auto-deleting the file will also clear the buffer.
else
    if set -q _flag_d
        ediff "$argv[1]" "$argv[2]"
    else
        run_emacs $argv
    end
end

