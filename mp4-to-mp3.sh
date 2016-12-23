#!/usr/bin/env bash
# -*- coding: utf-8 -*- 

# Extract audio component from an mp4 video into mp4 format
# Tag the new mp3 with metadata for listening in iTunes or Spotify
# 

# ***************************************************************************
# DEPENDENCIES 
# brew install ffmpeg --with-fdk-aac --with-ffplay --with-freetype --with-libass --with-libquvi --with-libvorbis --with-libvpx --with-opus --with-x265
# brew install sox
# brew install id3lib
# *************************************************************************** 

usage="$(basename "$0") [-h]  <mp4> <track> <song> 

Description: Extract audio from mp4 into mp3

Arguments:
    <mp4>        An mp4 file from which to extract audio
    <track>      Track number e.g. if it's a song from an album this is the song number
    <song>       Title or name of the song

Options:
    -h  Show help"

# Global metadata fields for a given album
# These tags appear in iTunes or Spotify when populated
ARTIST="Sex Pistols"
ALBUM="Never Mind the Bollocks, Here's the Sex Pistols"
YEAR="1977"
TOTAL="11"     # Total number of tracks on the album
GENRE="43"     # 43 is punk 
# genre codes found here: https://secure.php.net/manual/en/function.id3-get-genre-list.php


if [ "$1" == "-h" ] || [ "$1" == "" ]; then
    echo "$usage"
    exit 0
fi

if [ "$1" != "" ]; then
    INFILE="$1"
else
    echo -e "ERROR: mp4 file required but none given\n" >&2
    echo "$usage" >&2
    exit 1
fi

if [ "$2" != "" ]; then
    TRACK="$2"
else
    echo -e "ERROR: Track number required but none given\n" >&2
    echo "$usage" >&2
    exit 1
fi

if [ "$3" != "" ]; then
    SONG="$3"
else
    echo -e "ERROR: Song title required but none given\n" >&2
    echo "$usage" >&2
    exit 1
fi

# Filenaming convention to use for all mp3 and mp4 files you're working with
FMT="NUM. TITLE - $ARTIST - $ALBUM - $YEAR.mp4"

echo "renaming"
new_mp4=${FMT/"NUM"/$TRACK}
new_mp4=${new_mp4/"TITLE"/$SONG}
new_mp4="$(dirname "$1")/$new_mp4"

mv "$INFILE" "$new_mp4"
echo "$INFILE => $new_mp4"

echo "converting to mp3"
mkdir -p "$ALBUM"
outfile="$ALBUM/$(basename "$new_mp4" .mp4).mp3"
ffmpeg -i "$new_mp4" -vn -ab 250k "$outfile"
echo "done"
echo

echo "tagging"

# add metadata tags to your new mp3
id3tag \
    --track="$TRACK" \
    --song="$SONG" \
    --artist="$ARTIST" \
    --album="$ALBUM" \
    --year="$YEAR" \
    --total="$TOTAL" \
    --genre="$GENRE" "$outfile"
echo "done"
echo
