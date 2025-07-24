#!/bin/bash
# Custom git commands installation script

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BIN_DIR="$SCRIPT_DIR/../bin"

# Make bin scripts executable
chmod +x "$BIN_DIR"/*

echo "Custom git commands made executable!"
echo "Available commands in $BIN_DIR:"
ls -la "$BIN_DIR"/git-*
