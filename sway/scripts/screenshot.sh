#!/bin/bash
# usage: screenshot.sh [region|screen] [file|clipboard]
SAVE_DIR="$HOME/Pictures/Screenshots"
mkdir -p "$SAVE_DIR"
TIMESTAMP=$(date +%Y%m%d_%H%M%S)
FILE="$SAVE_DIR/$TIMESTAMP.png"

capture() {
    case "$1" in
        region) grim -g "$(slurp -d)" "$2" ;;
        screen) grim "$2" ;;
    esac
}

case "$2" in
    file)
        if capture "$1" "$FILE"; then
            notify-send "Screenshot saved" "$FILE" \
                --icon="$FILE" --expire-time=3000
        fi
        ;;
    clipboard)
        TMPFILE=$(mktemp /tmp/screenshot-XXXXXX.png)
        if capture "$1" "$TMPFILE"; then
            wl-copy < "$TMPFILE"
            notify-send "Screenshot copied" "Copied to clipboard" \
                --icon="$TMPFILE" --expire-time=3000
        fi
        rm -f "$TMPFILE"
        ;;
esac
