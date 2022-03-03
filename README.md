# scripts

A collection of various convenience scripts I've written for myself.

Each script contains usage information in its source, and most of them also support `-h`/`--help` to display a basic summary on the command line. Some of the scripts also have configuration options at the top that you may need or want to change.

They're written in a variety of languages, but mostly [fish](https://fishshell.com/) because fish is great.

* `a2v` (fish) - "audio to video". generate a video from a sound file and an image. Useful, for example, to upload music to YouTube.
* `abbreviate-path` (fish) - abbreviate the path passed as an argument.
* `auto-rotate-image` (fish) - correct broken rotation in image files.
* `c` (fish) - convenient interface to the clipboard.
* `define-selected` (fish) - define the selected text, showing the result in a popup dialog.
* `filter` (raku) - filter a list of filenames (stdin separated by newlines), outputting only those whose extensions match a specified type.
* `loc` (fish) - locate files by searching their names case-insensitively with [`bfs`](https://github.com/tavianator/bfs) or `find`.
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
* `ssuspend` (fish) - "screen suspend"; power off your monitor(s).
* `tag-gui` (python) - edit the [`tmsu`](https://github.com/oniony/TMSU) tags for a file with a tab-completing gui.
* `text-gui` (python) - show arbitrary text in a popup window.
* `translate-selected` (fish) - translate the selected text, showing the result in a popup dialog.
* `v` (fish) - view images or directories of images with [`nsxiv`](https://github.com/nsxiv/nsxiv). passes the rest of the images in the directory as well.
* `vol` (fish) - change alsa volume conveniently and intuitively.
