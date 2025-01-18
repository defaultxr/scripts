#!/usr/bin/env fish
# v - View images.
# Unlike calling nsxiv directly, this script will make sure you can always see all images in the directory of the specified image.
# If you specify a directory, all the images in that directory will be available.
# If you provide a list of files, only those files will be available.
# If nsxiv is not available, falls back to "open".

# Usage:
# v [dirname or filename]

# Examples:
#
# Get list of files in the current directory and start with the first one:
# v
#
# Get list of files from STDIN and start with the first one:
# v -
#
# Get list of files from the directory named DIRNAME and start with the first one:
# v DIRNAME
#
# Get list of files from the directory containing FILENAME and show FILENAME, preserving order:
# v FILENAME
#
# Only view FILE1, FILE2, and FILE3:
# v FILE1 FILE2 FILE

# settings:

# The default flags to provide to nsxiv
set flags -a -b

# code:

set -- script "$(path basename (status filename))"

argparse -n "$script" --ignore-unknown 'h/help' 'T/title=' -- $argv

if set -q _flag_h
    echo "$script - View images."
    echo "Usage: $script [arguments]"
    echo
    echo "  -h/--help  - Print help and exit."
    echo "  -T/--title - Set the window's title."
    exit
end

set title "$_flag_T"

set args $argv

function find-images -d "Get the list of images in the specified directory."
    find $argv[1]/ -maxdepth 1 \( -iname '*.jpeg' -or -iname '*.jpg' -or -iname '*.gif' -or -iname '*.png' -or -iname '*.bmp' -or -iname '*.webp' -or -iname '*.ppm' \) -exec readlink -f {} \; | sort -n
end

function make-title -d "Echo a title string for the nsxiv window."
    if set -q _flag_T
        echo "$_flag_T"
    else if test (count $args) -lt 1
        echo "$script "(abbreviate-path (pwd))
    else
        echo "$script - [$(count $args) files]"
    end
end

function open-nsxiv -d "Open files with nsxiv."
    if test (count $argv) -eq 0 # no args.
        set filename "$(status filename)"
        command "$filename" .
    else if test (count $argv) -gt 1 # more than one argument
        set -x NSXIV_TITLE (make-title)
        exec nsxiv $flags $argv # FIX: directories don't work for this
    else if test $argv[1] = '-' # argument was '-' - read list of files from stdin.
        set -x NSXIV_TITLE (make-title)
        exec nsxiv $flags -i
    else if test -d $argv[1] # it's a directory - view all images inside.
        # exec nsxiv $argv[1]
        set -x NSXIV_TITLE (make-title)
        find-images $argv[1] | nsxiv $flags -i
        exit
    else if test -f $argv[1] # it's a file - view all images in that directory, showing the file first.
        set dir (dirname $argv[1])
        set listing (find-images $dir)
        if not set idx (contains -i -- (readlink -f $argv[1]) $listing)
            echo "$script: $argv[1] not found or unsupported image format."
            exit 1
        end
        set -x NSXIV_TITLE (make-title)
        for i in $listing
            echo $i
        end | nsxiv $flags -n $idx -i
    end
end

function open-fallback -d "If nsxiv is not available, fallback to \"open\"."
    open $argv
end

if command -qs nsxiv
    open-nsxiv $argv
else
    open-fallback $argv
end
