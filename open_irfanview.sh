#!/bin/bash
# 1. Clean out single quotes added by mailcap
CLEAN_PATH=$(echo "$1" | tr -d "'")

# 2. Get the file extension and copy to a persistent user directory
EXT="${CLEAN_PATH##*.}"
TARGET_DIR="$HOME/.cache/neomutt_media"
mkdir -p "$TARGET_DIR"
TARGET_FILE="$TARGET_DIR/preview.${EXT}"
cp "$CLEAN_PATH" "$TARGET_FILE"

# 3. Convert Linux path to Windows format
WIN_PATH=$(wslpath -w "$TARGET_FILE")

# 4. Detach process cleanly so NeoMutt returns focus smoothly
nohup "/mnt/c/Program Files/IrfanView/i_view64.exe" "$WIN_PATH" >/dev/null 2>&1 &
