#!/bin/bash
# Takes a half-res screenshot, upscales+blurs it, uses as lock background.
TMPFILE=$(mktemp /tmp/lock-XXXXXX.png)
grim -s 0.5 "$TMPFILE"
convert "$TMPFILE" -scale 200% -blur 0x14 -fill black -colorize 20 "$TMPFILE"
swaylock --image "$TMPFILE"
rm -f "$TMPFILE"
