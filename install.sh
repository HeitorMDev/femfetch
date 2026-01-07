#!/usr/bin/env bash
set -e

# -------------------------------
# Config
# -------------------------------
PREFIX="/usr/local"
BIN_DIR="$PREFIX/bin"
SHARE_DIR="$PREFIX/share/femfetch"
ETC_DIR="/etc/femfetch"

echo "==> Installing femfetch..."

# -------------------------------
# Sanity checks
# -------------------------------
if [[ $EUID -ne 0 ]]; then
    echo "Run as root (use sudo)"
    exit 1
fi

# -------------------------------
# Executables
# -------------------------------
install -Dm755 bin/femfetch "$BIN_DIR/femfetch"

install -d "$BIN_DIR/AsciiGIF"
install -Dm755 loadGIF   "$BIN_DIR/AsciiGIF/loadGIF"
install -Dm755 AsciiGen  "$BIN_DIR/AsciiGIF/AsciiGen"

# -------------------------------
# Libraries / helpers
# -------------------------------
install -d "$SHARE_DIR/lib"
install -Dm755 lib/* "$SHARE_DIR/lib/"

# -------------------------------
# AsciiGIF tools
# -------------------------------
install -d "$SHARE_DIR/AsciiGIF"
install -Dm755 AsciiGIF/* "$SHARE_DIR/AsciiGIF/"

# -------------------------------
# Anim killer
# -------------------------------
install -Dm755 animKiller.sh "$SHARE_DIR/animKiller.sh"

# -------------------------------
# Frames / ASCII / Distros
# -------------------------------
install -d "$SHARE_DIR/frames"
install -d "$SHARE_DIR/ascii"
install -d "$SHARE_DIR/distros"

cp -r ascii/*   "$SHARE_DIR/ascii/"
cp -r frames/*  "$SHARE_DIR/frames/"
cp -r distros/* "$SHARE_DIR/distros/"

# -------------------------------
# ASCII header
# -------------------------------
install -Dm644 femfetch_ascii.txt "$SHARE_DIR/femfetch_ascii.txt"

# -------------------------------
# Configuration
# -------------------------------
install -d "$ETC_DIR"

if [[ ! -f "$ETC_DIR/femfetch.conf" ]]; then
    install -Dm644 femfetch.conf "$ETC_DIR/femfetch.conf"
else
    echo "Config already exists, skipping femfetch.conf"
fi

# -------------------------------
# Info script
# -------------------------------
install -Dm755 bin/femfetch-info.sh "$SHARE_DIR/lib/femfetch-info.sh"

# -------------------------------
# Paths helper
# -------------------------------
install -Dm755 paths.sh "$SHARE_DIR/paths.sh"

# -------------------------------
# Done
# -------------------------------
echo "==> femfetch installed successfully"
echo "Run: femfetch"
