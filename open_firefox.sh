#!/bin/bash
# 1. Clean out quotes added by mailcap
CLEAN_PATH=$(echo "$1" | tr -d "'")

# 2. Copy temp HTML file to a persistent user directory so Windows permissions don't block it
TARGET_DIR="$HOME/.cache/neomutt_html"
mkdir -p "$TARGET_DIR"
TARGET_FILE="$TARGET_DIR/preview.html"
cp "$CLEAN_PATH" "$TARGET_FILE"

# 3. Convert Linux path to Windows format using the UNC path (works across all WSL versions)
WIN_PATH=$(wslpath -w "$TARGET_FILE")

# 4. Detach process cleanly with nohup so NeoMutt doesn't kill Firefox on exit
nohup "/mnt/c/Program Files/Mozilla Firefox/firefox.exe" "$WIN_PATH" >/dev/null 2>&1 &
