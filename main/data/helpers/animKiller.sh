#!/usr/bin/env bash
# animKiller.sh - mata animação GIF em background

PID_render=$2
PID_fem=$1

source "$(dirname "$(readlink -f "$0")")/paths.sh"

while [[ -n "$PID_fem" && -d /proc/$PID_fem ]]; do
    sleep 0.05
done

[[ -n "$PID_render" ]] && kill "$PID_render" 2>/dev/null
exit 0
