#!/usr/bin/env fish

# v - view images with nsxiv.
# unlike calling nsxiv directly, this script will make sure you can always see all images in the directory of the image you specify.
# if you specify a directory, all the images in that directory will be available.

# usage:
# v [dirname or filename]

# examples:
# 'v' - get list of files in the current directory and start with the first one.
# 'v -' - get list of files from STDIN and start with the first one.
# 'v DIRNAME' - get list of files from the directory named DIRNAME and start with the first one.
# 'v FILENAME' - get list of files from the directory containing FILENAME and show FILENAME, preserving order.
# 'v FILE1 FILE2 FILE' - only view FILE1, FILE2, and FILE3.

# configuration:

# the default flags to provide to nsxiv
set flags -a -b

# code:

argparse -n v 'h/help' 'T/title=' -- $argv

if test -n "$_flag_h"
    echo "v - view images with nsxiv."
    echo "Usage: v [arguments]"
    echo
    echo "  -h/--help  - Print help and exit."
    echo "  -T/--title - Set the window's title."
    exit
end

set title "$_flag_T"

set args $argv

function find-images -d "Get the list of images in the specified directory."
    find $argv[1]/ -maxdepth 1 \( -iname '*.jpeg' -or -iname '*.jpg' -or -iname '*.gif' -or -iname '*.png' -or -iname '*.bmp' -or -iname '*.webp' \) -exec readlink -f {} \; | sort -n
end

function make-title -d "Echo a title string for the nsxiv window."
    if test -n "$_flag_T"
        echo "$_flag_T"
    else if test (count $args) -lt 1
        echo "v "(abbreviate-path (pwd))
    # else if test (count $args) = 1
    #     echo "v "(abbreviate-path (realpath $args[1]))
    else
        echo "v"
    end
end

if test (count $argv) -eq 0 # no args.
    v .
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
        echo "v: $argv[1] not found or unsupported image format."
        exit 1
    end
    set -x NSXIV_TITLE (make-title)
    for i in $listing
        echo $i
    end | nsxiv $flags -n $idx -i
end
