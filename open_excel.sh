#!/bin/bash
# 1. Clean out single quotes added by mailcap
CLEAN_PATH=$(echo "$1" | tr -d "'")

# 2. Extract file extension (.xlsx or .xls)
EXT="${CLEAN_PATH##*.}"
[ "$EXT" = "$CLEAN_PATH" ] && EXT="xlsx" # Default to xlsx if missing

# 3. Copy file to cache directory so Windows permissions don't block /tmp/
TARGET_DIR="$HOME/.cache/neomutt_office"
mkdir -p "$TARGET_DIR"
TARGET_FILE="$TARGET_DIR/preview.${EXT}"
cp "$CLEAN_PATH" "$TARGET_FILE"

# 4. Convert Linux path to Windows format
WIN_PATH=$(wslpath -w "$TARGET_FILE")

# 5. Option A: Launch using Windows default app association (Excel, Calc, etc.)
#nohup cmd.exe /c start "" "$WIN_PATH" >/dev/null 2>&1 &

# Option B: If you prefer to target EXCEL.EXE explicitly instead, uncomment this line:
nohup "/mnt/c/Program Files/Microsoft Office/root/Office16/EXCEL.EXE" "$WIN_PATH" >/dev/null 2>&1 &
