#!/usr/bin/env bash
# layout.sh - helpers para layout

calc_left_width() {
    LEFT_WIDTH="${ASCII_WIDTH:-0}"
    for line in "${LEFT_RENDER[@]}"; do
        (( ${#line} > LEFT_WIDTH )) && LEFT_WIDTH=${#line}
    done
}

init_layout() {
    PADDING=${PADDING:-4}
    calc_left_width
    INFO_COL=$((LEFT_WIDTH + PADDING))
}
