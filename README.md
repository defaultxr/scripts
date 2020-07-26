# scripts
Various small scripts I've written.

The sources of these scripts contain usage information and examples. Some of the scripts also have configuration options that you may need or want to change.

They're written in a variety of languages, but maybe I'd make bash versions of them at some point (even though Bash sucks).

More may be added soon.

* `a2v` (bash) - "audio to video". generate a video from a sound file and an image. useful, for example, if you want to upload a track to youtube.
* `auto-rotate-image` (fish) - correct broken rotation in image files.
* `c` (fish) - convenient interface to the clipboard.
* `filter` (perl6) - filter a list of filenames (stdin separated by newlines), outputting only those whose extensions match a specified type.
* `mpls` (fish) - list tracks in mpd's current playlist, also showing an indicator next to the current track.
* `p` (fish) - "play". play something with mpv, joining its twitch chat via irc (weechat) if it's a twitch stream.
* `pgr` (fish) - "process grep". similar to `pgrep` but the output is human-readable rather than meant for scripts.
* `randomsong` (sh) - get a list of N random songs from your music directory.
* `rfile` (fish) - echo a random file from the current directory or from any subdirectories N deep.
* `romanize` (python) - romanize Japanese text to help with learning pronunciation.
* `run-if-not` (fish) - run a program only if it isn't already running.
* `sshot` (fish) - take a screenshot of the whole screen or of a region. unlike scrot it doesn't cause junk to show up near the edges of the screenshot.
* `translate-selected` (fish) - pop up a window showing the translation of the selected text.
* `v` (fish) - view images with sxiv. passes the rest of the images in the directory to sxiv as well. you can also specify a directory instead.
* `vol` (fish) - change alsa volume conveniently and intuitively.
