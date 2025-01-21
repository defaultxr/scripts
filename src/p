#!/usr/bin/env fish
# p - Play media.
# This is basically just a wrapper for mpv, or timidity if the media is MIDI files.
# If the media is a twitch.tv URL, also joins its twitch chat through IRC in WeeChat.
# You'll need to have WeeChat's FIFO plugin enabled for this to work.
# Once the stream is stopped, also exits the the chat.

# Usage:
# p [arguments] files/URLs

# Example:
# Play my Twitch stream and join its chat:
# p 'https://www.twitch.tv/defaultxr/'

# code:

set -- script "$(path basename (status filename))"

argparse -n "$script" --ignore-unknown 'h/help' 'midi' 'X/use-x11' -- $argv

if set -q _flag_h
    echo "$script - Play media."
    echo "Usage: $script [arguments] files/URLs"
    echo
    echo "  -h/--help    - Print help and exit."
    echo "  --midi       - Play files as MIDI, using timidity instead of mpv (automatically done if all inputs have .mid or .midi file extensions)."
    echo "  -X/--use-x11 - Open mpv on X11, even if Wayland is running (automatically done if \$XDG_SESSION_TYPE is not \"wayland\")."
    exit
end

set argv_count (count $argv)
set is_stdin (test "$argv_count" -gt '0'; and test "$argv[1]" = '-'; or test "$argv[1]" = '--playlist=-'; echo $status)
set -l dash_index (contains --index - $argv) # remove the dash from the arguments so we don't try to play it as a file.
if test $status -eq 0
    set -e argv[$dash_index]
end
set url $argv[1]
set user ""
set is_twitch (test -e ~/.weechat/weechat_fifo; and string match --quiet --regex -- '^https\?://\(www.\|go.\)\?twitch.tv/' $url; echo $status)
set weechat_open (pgrep weechat; echo $status)

echo $argv

if test "$is_twitch" = '0'; and test "$weechat_open" = '0'
    set user (string lower (string split '/' $url)[4])
    echo Joining \#$user...
    echo "*/window 1" >~/.weechat/weechat_fifo
    echo "irc.server.twitch */join #$user" >~/.weechat/weechat_fifo
end

set-title "$script $argv"

function contains_only_midi -d "True if all of the input filenames/URLs have MIDI file extensions."
    if test $argv_count = '0'; or test "$is_stdin" = '0' # if no arguments or stdin, we default to false
        return 1
    end
    set -l arg_count 0
    for arg in $argv
        if string match --quiet -- '-*' "$arg" # ignore flags
            continue
        end
        set arg_count (math $arg_count + 1)
        if not string match -qi '*.mid' "$arg"; and not string match -qi '*.midi' "$arg"
            return 1
        end
    end
    if test $arg_count = '0'
        return 1
    end
    return 0
end

# set -- title_args --title="p $argv" # FIX: path resolve the filenames?

set mpv_extra_args

mkdir -p ~/misc/log/mpv/
set -a -- mpv_extra_args --log-file=~/misc/log/mpv/mpv-$(date '+%Y-%m-%d-%H-%M').log

if test "$is_stdin" = '0'
    set -a -- mpv_extra_args --playlist=-
end

# if set -q _flag_X; or not test $XDG_SESSION_TYPE = 'wayland'
#     set -a -- mpv_extra_args --gpu-context=x11egl
# end

# LD_PRELOAD=`jemalloc-config --libdir`/libjemalloc.so.`jemalloc-config --revision` mpv --no-config /nas/some-big-video-file.mkv

if set -q _flag_m; or contains_only_midi $argv
    timidity $argv
else
    # the LD_PRELOAD stuff is from https://github.com/mpv-player/mpv/issues/11931#issuecomment-1668905911
    # LD_PRELOAD=(jemalloc-config --libdir)/libjemalloc.so.(jemalloc-config --revision)
    mpv $title_args $mpv_extra_args $argv
end

if test "$is_twitch" = '0'; and test "$weechat_open" = '0'
    echo Closing \#$user...
    echo "irc.server.twitch */close irc.twitch.#$user" >~/.weechat/weechat_fifo
end
