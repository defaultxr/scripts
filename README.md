# scripts

Various small scripts I've written.

Each script contains usage information and examples in its source. Some of the scripts also have configuration options that you may need or want to change.

They're written in a variety of languages, but mostly [fish](https://fishshell.com/) because fish is great.

* `a2v` (bash) - "audio to video". generate a video from a sound file and an image. useful, for example, if you want to upload a track to youtube.
* `auto-rotate-image` (fish) - correct broken rotation in image files.
* `c` (fish) - convenient interface to the clipboard.
* `filter` (raku) - filter a list of filenames (stdin separated by newlines), outputting only those whose extensions match a specified type.
* `loc` (fish) - locate files by searching their names case-insensitively with `bfs` or `find`.
* `locate-dominating-file` (fish) - look up in the directory hierarchy for a specified file.
* `move-gui` (fish) - move a file or files with a gui.
* `mpls` (fish) - list tracks in mpd's current playlist, also showing an indicator next to the current track.
* `p` (fish) - "play". play something with mpv, joining its twitch chat via irc (weechat) if it's a twitch stream.
* `pgr` (fish) - "process grep". similar to `pgrep` but the output is human-readable rather than meant for scripts.
* `randomsong` (sh) - get a list of N random songs from your music directory.
* `rename-gui` (fish) - rename a file with a gui.
* `rfile` (fish) - echo a random file from the current directory or from any subdirectories N deep.
* `romanize` (python) - romanize Japanese text to help with learning pronunciation.
* `run-if-not` (fish) - run a program only if it isn't already running.
* `sshot` (fish) - take a screenshot of the whole screen or of a region. unlike scrot it doesn't cause junk to show up near the edges of the screenshot.
* `ssuspend` (fish) - suspend your monitor(s).
* `translate-selected` (fish) - pop up a window showing the translation of the selected text.
* `v` (fish) - view images with sxiv. passes the rest of the images in the directory to sxiv as well. you can also specify a directory instead.
* `vol` (fish) - change alsa volume conveniently and intuitively.
