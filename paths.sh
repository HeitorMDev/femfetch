#!/usr/bin/env bash
# paths.sh - Centralizes all paths for femfetch
# ==========================================================
# This script defines and prepares all directories used by femfetch..

# -------------------------------
# configuration and data directories
# -------------------------------
if [[ -e "$HOME/.config/femfetch/femfetch.conf" ]]; then
    CONFIG_DIR="$HOME/.config/femfetch/"
else
    CONFIG_DIR="/etc/femfetch"
fi
# CONFIG_DIR: Where user-specific configuration files are stored.

DATA_DIR="/usr/share/femfetch"
# DATA_DIR: Base directory for storing femfetch data (frames, gifs, pids, ascii)

# -------------------------------
# Specific data subdirectories
# -------------------------------
FRAME_DIR="$DATA_DIR/frames"              
# FRAME_DIR: Stores extracted or generated ASCII frames

DISTRO_GIF_DIR="$DATA_DIR/distros"        
# DISTRO_GIF_DIR: Stores distro-specific GIFs for animation preview

PID_DIR="$DATA_DIR/pid"                   
# PID_DIR: Temporary PID files to control background animations or scripts

ASCII_DIR="$DATA_DIR/ascii"               
# ASCII_DIR: Final ASCII files or outputs (if needed for caching or rendering)

# -------------------------------
# Script-related directories
# -------------------------------
SCRIPT_DIR="$(dirname "$(readlink -f "$0")")"
# SCRIPT_DIR: Absolute path to the directory containing this script
# readlink -f resolves symbolic links to get the real path

LIB_DIR="/usr/share/femfetch/lib"
# LIB_DIR: Directory where helper libraries or scripts are located

# -------------------------------
# Ensure all required directories exist
# -------------------------------
# Creates all directories if they do not exist
# -p ensures parent directories are created without error if they already exist
