#!/bin/fish

# v - view images with sxiv.
# unlike calling sxiv directly, this script will make sure you can always see all images in the directory of the image you specify.
# if you specify a directory, all the images in that directory will be available.

# FIX: if more than one image is specified, only show the images listed.

# usage:
# v [dirname or filename]

# examples:
# 'v' - get list of files in the current directory and start with the first one.
# 'v -' - get list of files from STDIN and start with the first one.
# 'v DIRNAME' - get list of files from the directory named DIRNAME and start with the first one.
# 'v FILENAME' - get list of files from the directory containing FILENAME and show FILENAME, preserving order.

# code:

function indexof -d "Gets index of first argument in the list of the rest of the arguments."
    set x 0
    set needle (basename $argv[1])
    for i in $argv[2..-1]
        set x (calc -p "$x + 1")
        if test (basename $i) = $needle
            echo -n $x
            return
        end
    end
    echo -n -1
end

function find-images -d "Finds images in ARGV[1]."
    find $argv[1]/ -maxdepth 1 -iname '*.jpeg' -or -iname '*.jpg' -or -iname '*.gif' -or -iname '*.png' -or -iname '*.bmp' | sort -n
end

if test (count $argv) -eq 0 # no args.
    v .
else if test $argv[1] = '-' # argument was '-' - read list of files from stdin.
    exec sxiv -a -i -b;
    exit;
else if test -d $argv[1] # it's a directory - view all images inside.
    find-images $argv[1] | v -
    exit
else if test -f $argv[1] # it's a file - view all images in that directory, showing the file first.
    set dir (dirname $argv[1])
    set listing (find-images $dir)
    set idx (indexof $argv[1] $listing)
    for i in $listing
        echo $i
    end | sxiv -n $idx -a -i -b;
end