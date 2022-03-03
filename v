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

argparse -n v 'T/title=' -- $argv

set title "$_flag_T"

set args $argv

function indexof -d "Gets index of first argument in the list of the rest of the arguments."
    set x 0
    set needle (basename $argv[1])
    for i in $argv[2..-1]
        set x (expr $x + 1)
        if test (basename $i) = $needle
            echo -n $x
            return
        end
    end
    echo -n -1
end

function find-images -d "Finds images in the specified directory."
    find $argv[1]/ -maxdepth 1 -iname '*.jpeg' -or -iname '*.jpg' -or -iname '*.gif' -or -iname '*.png' -or -iname '*.bmp' -or -iname '*.webp' | sort -n
end

function make-title -d "Return a title string for the nsxiv window."
    if test -n "$title"
        set title "$title"
    else if test (count $args) -lt 1
        set title "v "(pwd)
    else
        set title "v "(realpath $args)
    end
    set title (echo $title | sed 's@/home/modula@~@' | sed 's@/f-anime/@/f-a/@'| sed 's@~/misc/Ptest/@~/m/P/@')
    echo $title
end

if test (count $argv) -eq 0 # no args.
    v .
else if test (count $argv) -gt 1 # more than one argument
    exec env NSXIV_TITLE=(make-title) nsxiv $flags $argv # FIX: directories don't work for this
else if test $argv[1] = '-' # argument was '-' - read list of files from stdin.
    exec env NSXIV_TITLE=(make-title) nsxiv $flags -i
else if test -d $argv[1] # it's a directory - view all images inside.
    # exec nsxiv $argv[1]
    find-images $argv[1] | env NSXIV_TITLE=(make-title) nsxiv $flags -i
    exit
else if test -f $argv[1] # it's a file - view all images in that directory, showing the file first.
    set dir (dirname $argv[1])
    set listing (find-images $dir)
    set idx (indexof $argv[1] $listing)
    if test $idx = -1
        echo "$argv[1] not found or unsupported image format."
        set idx ""
    else
        set idx "-n $idx"
    end
    for i in $listing
        echo $i
    end | env NSXIV_TITLE=(make-title) nsxiv $flags $idx -i
end
