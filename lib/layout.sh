#!/usr/bin/env bash
# layout.sh - helpers para layout

calc_left_width() {
    LEFT_WIDTH="${ASCII_WIDTH:-0}"
    for line in "${LEFT_RENDER[@]}"; do
        (( ${#line} > LEFT_WIDTH )) && LEFT_WIDTH=${#line}
    done
}

strip_ansi() {
    sed -r 's/\x1B\[[0-9;?]*[ -/]*[@-~]//g'
}

calc_max_group_width() {
    local -n group=$1
    local max=0
    local label value clean len

    for label in "${group[@]}"; do
        [[ ${SHOW[$label]:-0} != 1 || -z ${info_values[$label]} ]] && continue

        value="${info_values[$label]#"${info_values[$label]%%[![:space:]]*}"}"

        clean=$(printf "%-${max_label}s %s" "$label" "$value" | strip_ansi)
        len=${#clean}

        (( len > max )) && max=$len
    done

    echo "$max"
}

init_layout() {
    PADDING=${PADDING:-4}
    calc_left_width
    INFO_COL=$((LEFT_WIDTH + PADDING))
}
