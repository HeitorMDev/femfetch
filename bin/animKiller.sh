#!/usr/bin/env bash
# animKiller.sh - mata animação GIF em background

source "$(dirname "$(readlink -f "$0")")/paths.sh"

PID_GIF_FILE="$PID_DIR/PID.txt"
PID_FET_FILE="$PID_DIR/PID_SELF.txt"

PID_GIF=$(cat "$PID_GIF_FILE" 2>/dev/null || echo "")
PID_FET=$(cat "$PID_FET_FILE" 2>/dev/null || echo "")

while [[ -n "$PID_FET" && -d /proc/$PID_FET ]]; do
    sleep 0.05
done

[[ -n "$PID_GIF" ]] && kill "$PID_GIF" 2>/dev/null

> "$PID_DIR/PID_THIS.txt"
> "$PID_GIF_FILE"
exit 0
