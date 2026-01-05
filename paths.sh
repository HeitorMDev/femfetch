#!/usr/bin/env bash
# paths.sh - Centralizes all paths for femfetch
# ==========================================================
# This script defines and prepares all directories used by femfetch.
# It ensures portability by using XDG standard paths when available.

# -------------------------------
# XDG-compliant configuration and data directories
# -------------------------------
CONFIG_DIR="${XDG_CONFIG_HOME:-$HOME/.config}/femfetch"
# CONFIG_DIR: Where user-specific configuration files are stored.
# Uses $XDG_CONFIG_HOME if defined, otherwise defaults to $HOME/.config/femfetch

DATA_DIR="${XDG_DATA_HOME:-$HOME/.local/share}/femfetch"
# DATA_DIR: Base directory for storing femfetch data (frames, gifs, pids, ascii)
# Uses $XDG_DATA_HOME if defined, otherwise defaults to $HOME/.local/share/femfetch

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

LIB_DIR="$SCRIPT_DIR/lib"
# LIB_DIR: Directory where helper libraries or scripts are located

# -------------------------------
# Ensure all required directories exist
# -------------------------------
mkdir -p "$CONFIG_DIR" "$DATA_DIR" "$FRAME_DIR" "$DISTRO_GIF_DIR" "$PID_DIR" "$ASCII_DIR"
# Creates all directories if they do not exist
# -p ensures parent directories are created without error if they already exist
