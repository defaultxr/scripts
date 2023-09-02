# scripts

My personal collection of scripts.

They range in complexity and usefulness; some of them are little more than aliases, while others contain a lot more logic and functionality. They should all support a `-h` or `--help` argument to display a summary and basic help information. Some of the scripts have configuration options at the top of the file that you may need or want to change. They're written in a variety of languages, but mostly [Fish](https://fishshell.com/), because Fish is great.

Even though I wrote them primarily for myself, all of these scripts should still be usable (and--hopefully--useful) to others. As long as you have the script's requirements, it should work just as well for you. Please don't hesitate to open an issue if you find any problems with them.

Some of the scripts in this collection I find most useful are [`a2v`](#a2v), [`ask-yes-no`](#ask-yes-no), [`c`](#c), [`capture-audio`](#capture-audio), [`check-df`](#check-df), [`check-memory-usage`](#check-memory-usage), [`convert-audio`](#convert-audio), [`define-selected`](#define-selected), [`dirdiff`](#dirdiff), [`filter`](#filter), the [`findtype`](#findtype) suite, [`git-multi-log`](#git-multi-log), [`git-pull-subdirs`](#git-pull-subdirs), [`input-passthru`](#input-passthru), [`loc`](#loc), [`lyrics`](#lyrics), [`lyrics-gui`](#lyrics-gui), [`move-gui`](#move-gui), [`myip`](#myip), [`p`](#p), [`pgr`](#pgr), [`recently`](#recently), [`rename-gui`](#rename-gui), [`run-if-not`](#run-if-not), [`set-wallpaper`](#set-wallpaper), [`speak`](#speak), [`sshot`](#sshot), [`ssuspend`](#ssuspend), [`synonyms`](#synonyms), [`tag-gui`](#tag-gui), [`text-gui`](#text-gui), [`translate-selected`](#translate-selected), [`trash-confirm`](#trash-confirm), [`v`](#v), [`vol`](#vol), and [`xeph`](#xeph).

The full list of scripts follows. Each is listed with its requirements and a short description.

## `a2v`

fish, ffmpeg

"Audio to video". generate a video from a sound file and an image. Useful, for example, if you want to upload music to YouTube or other sites.

## `a2v-multi`

fish, a2v, parallel

Run a2v on multiple audio files in parallel using [GNU parallel](https://www.gnu.org/software/parallel/). `nice`s the processes to run with a lower priority, to not disturb other processes on your system.

## `abbreviate-path`

fish

Abbreviate the path passed as an argument. Similar to fish's built-in `prompt_pwd` function.

## `ask-yes-no`

fish

Ask the user a yes or no question and return true (`0`) if yes, false (`1`) otherwise.

## `auto-rotate-image`

fish, convert (imagemagick)

Automatically correct image rotation based on its metadata.

## `autocrop`

fish, convert (imagemagick)

Automatically trim blank edges of an image. Copies the original image to /tmp first in case you want to restore it later.

## `bak`

fish

Quickly make a .bak backup copy of the specified file(s).

## `c`

fish, xclip (when on linux)

A convenient interface to the clipboard.

## `c-`

fish

Alias for `c -`; copy standard input to the clipboard.

## `capture-audio`

fish, jack_capture, convert-audio

Capture the audio output going to the speakers and record it to a file.

## `check-battery`

fish, notify-send (libnotify)

Check the battery and notify if it's low. May be useful to set as a cron job.

## `check-df`

fish

Check disk free; print a message if free space of any partitions are below a threshold. May be useful run from your shell init file.

## `check-memory-usage`

fish, notify-send (libnotify)

Check current memory and swap usage and notify if it's low. May be useful to set as a cron job.

## `content-aware-scale`

fish, convert (imagemagick)

Content-aware scale a video. See [ImageMagick's documentation](https://www.imagemagick.org/Usage/resize/#liquid-rescale) for more information about what this does, but basically, it can be used to make a video look silly. Examples: [one](https://www.youtube.com/watch?v=PwKABG6Wzdo), [two](https://www.youtube.com/watch?v=LYbgKh01daA), [three](https://www.youtube.com/watch?v=BCxzQF47dYQ).

## `convert-audio`

fish, ffmpeg

Convert a set of audio files into a specified audio format, preserving tags. Uses GNU Parallel to parallelize the jobs to convert as fast as possible, `nice`ing the processes to run with a lower priority, to not disturb other processes on your system.

## `d`

fish, trash-put (trash-cli)

"Delete" (trash) a file, also removing it from any TMSU database.

## `define-selected`

fish, dictd, xclip, text-gui

Define the specified or selected word, showing the result in a popup dialog.

## `dirdiff`

fish

List files that only exist in one of the two specified dirs. This script supports comparing directories over SSH, i.e.: `dirdiff /path/to/dir host:/path/to/dir`

## `dirtour`

fish

Print the first file from each directory in CWD. With an argument, print a random file from each directory instead of the first one.

## `eman`

fish

Open a man page in Emacs.

## `eww`

fish, emacs

Emacs Web Wowser; open a URL in Emacs' web browser, [eww](https://www.gnu.org/software/emacs/manual/html_mono/eww.html).

## `filter`

raku

Filter a list of filenames, outputting only those whose extension denotes a specified "type" (i.e. audio, image, video, etc).

## `find-broken-symlinks`

fish, find

Get a list of symlinks whose target does not exist. This is basically just an easier-to-remember alias for `find -xtype l`.

## `finda`

fish, bfs or find

Find audio files.

## `findc`

fish, bfs or find

Find compressed files.

## `findd`

fish, bfs or find

Find directories.

## `findi`

fish, bfs or find

Find image files.

## `findmedia`

fish, bfs or find

Find media files (audio, images, video).

## `findtype`

fish, bfs or find

Find files of a specified type. This is used by `finda`, `findc`, `findd`, etc; it's simpler to just use those scripts instead of this one directly.

## `findu`

fish, bfs or find

Find unsorted files (anything not found by `finda`, `findc`, `findd`, etc).

## `findv`

fish, bfs or find

Find video files.

## `findvis`

fish, bfs or find

Find visual files (images, video).

## `fixperms`

fish

Recursively fix permissions on a file or directory.

## `git-multi-log`

fish, git

Merge and sort git log summaries for multiple repos.

## `http-server`

fish, python

Quickly spin up a basic HTTP server for a directory.

## `loc`

fish, bfs or find

Locate files by searching their names case-insensitively with [`bfs`](https://github.com/tavianator/bfs) or `find`.

## `locate-dominating-file`

fish

Look up in the directory hierarchy for a specified file. This can be used, for example, to check if we're in a git repository, by locating `.git`.

## `lsa`

fish, bfs or find

List audio files.

## `lsc`

fish, bfs or find

List compressed files.

## `lsd`

fish, bfs or find

List directories.

## `lsi`

fish, bfs or find

List image files.

## `lsu`

fish, bfs or find

List files of an unknown "type"; everything not audio, compressed, directories, images, or video. See also: `lsa`, `lsc`, `lsd`, `lsi`, `lsv`, `lsvis`.

## `lsv`

fish, bfs or find

List video files.

## `lsvis`

fish, bfs or find

List visual files (images, video).

## `lyrics`

fish, clyrics, ffprobe (ffmpeg)

Get the lyrics for the specified or currently-playing song.

## `lyrics-gui`

fish, text-gui

Open a window showing the lyrics of MPD's current track.

## `move-gui`

fish, zenity

Move a file using a file selector gui. Accepts a list of files either as arguments or from stdin if `-` is the first argument.

## `mpls`

fish, mpc (mpd)

List tracks in mpd's current playlist.

## `myip`

fish, curl

Get your current public IP address.

## `p`

fish, mpv

Play media with mpv, joining its twitch chat via IRC (weechat) if it's a twitch stream. Once the stream is stopped, exits the channel.

## `pgr`

fish

`grep` for processes that match the arguments. Basically like `pgrep` but its output is meant to be readable by humans.

## `qr`

fish, qrencode

Generate a QR code from a file or input. With `-w` or `--wifi` flag, generate a qr code to connect to the current wifi network with the provided password.

## `qrc`

fish, qrencode

Generate a QR code from the text in the clipboard.

## `randomsong`

fish

Get a list of N random songs from your music directory.

## `recently`

fish

Get a list of recently-modified files in this directory and subdirectories, most recent first.

## `remove-unneeded-packages`

fish, pacman

Ask to remove all system packages installed as dependencies that are no longer needed.

## `rename-gui`

fish, zenity

Rename a file via a GUI popup.

## `rfile`

fish

Output a random file in the current directory. An argument can be provided to specify the number of subdirectories to look for a random file.

## `rg-package-files`

fish, pacman, rg

Run ripgrep on all of the files (not directories) installed by a package.

## `romanize`

python, romkan

Romanize Japanese text from arguments or stdin. May be helpful for learning Japanese pronunciation.

## `run-if-not`

fish

Run a program if it's not already running.

## `set-title`

fish

Set the terminal window title.

## `set-wallpaper`

fish, hsetroot, feh

Set the desktop background, either to a solid color, or to a specified image.

## `speak`

fish, espeak or say (when on macos) or flite

Speak text using a text-to-speech engine.

## `sshot`

fish, scrot, slop, c

Take a screenshot of the whole screen, a window, or a(n interactively-selected) region. unlike scrot it doesn't cause junk to show up near the edges of the screenshot.

## `ssuspend`

fish, xset

"Screen suspend". Simply turns off your monitor(s).

## `synonyms`

fish, dictd

Get synonyms for a word.

## `tag-count`

fish, tmsu

Print all TMSU tags next to a count of their uses.

## `tag-gui`

python, tkinter (tcl/tk), tmsu

Edit the [`TMSU`](https://github.com/oniony/TMSU) tags for the specified file(s) with a tab-completing gui. Shows the filename (or the common directory if tagging multiple) and the previous set of tags, and allows you to edit their tags, with tab-completion of tag names.

## `text-gui`

python, tkinter (tcl/tk)

Show arbitrary text in a simple GUI. May be useful in scripts bound to window manager shortcuts or the like. The text is editable, and keybindings can be specified with `--action` arguments.

## `tmsu-mv`

fish, tmsu

Move a file, then run `tmsu repair` for the new name and location.

## `tmsu-rm`

fish, tmsu

Trash or delete a file, then run `tmsu repair` to remove it from the database.

## `translate-selected`

fish, translate-shell, xclip, text-gui

Translate the selected text, showing the result in a popup dialog.

## `trash-confirm`

fish, trash-put (trash-cli)

Ask the user to confirm trashing the specified file(s), then trash them.

## `v`

fish, nsxiv

View images or directories of images with [`nsxiv`](https://github.com/nsxiv/nsxiv). passes the rest of the images in the directory as well.

## `vol`

fish, pactl (libpulse)

Change system volume. This might be a bit more convenient and intuitive than typing crap like `amixer -c 2 set PCM +2%`.

## `xeph`

fish, xephyr

Run a program in [Xephyr](https://wiki.archlinux.org/title/Xephyr), starting Xephyr if necessary.

