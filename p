#!/usr/bin/env fish

# p - "play". play something with mpv, joining its twitch chat via irc (weechat) if it's a twitch stream.
# once the stream is stopped, the channel will be exited.
# this is just a wrapper for mpv and doesn't alter its behavior other than that.
# you'll need to have weechat's fifo plugin enabled for this to work.

# usage:
# p <mpv-arguments...>

# example:
# play my twitch stream and join its chat:
# p 'https://www.twitch.tv/defaultxr/'

# code:

argparse -n p --ignore-unknown 'h/help' -- $argv

if test -n "$_flag_h"
    echo "p - play something with mpv."
    echo "Usage: p [arguments]"
    echo
    echo "  -h/--help - Print help and exit."
    exit
end

set url $argv[1]
set user ""
set is_twitch (test -e ~/.weechat/weechat_fifo; and string match --quiet --regex -- '^https\?://\(www.\|go.\)\?twitch.tv/' $url;echo $status)


if test "$is_twitch" = '0'
    set user (string lower (string split / $url)[4])
    echo Joining \#$user...
    echo "*/window 1" >~/.weechat/weechat_fifo
    echo "irc.server.twitch */join #$user" >~/.weechat/weechat_fifo
end

mpv $argv

if test "$is_twitch" = '0'
    echo Closing \#$user...
    echo "irc.server.twitch */close irc.twitch.#$user" >~/.weechat/weechat_fifo
end
