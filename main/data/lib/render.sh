#!/usr/bin/env bash
# render.sh - Helper functions for printing system info in terminal
# ================================================================
# Provides functions to render user/host info, grouped info blocks,
# separators, and color previews for ASCII/terminal output.

# -------------------------------
# Print user@host line at specific coordinates
# -------------------------------

print_user_host() { 
    local line="$1" pad="$2" usr_line="$3"
    # Move the cursor to the specified line and column (pad)
    tput cup "$line" "$pad"
    # Print the text with accent color and reset formatting
    printf "%b%s%b" "$C_ACCENT" "$usr_line" "$C_RESET"
}

# -------------------------------
# Print a group of info fields to stdout
# -------------------------------
print_group() {
    local -n group="$1"
    local start_line="$2"
    local idx=0

    for label in "${group[@]}"; do
        [[ "${SHOW[$label]:-0}" != 1 || -z "${info_values[$label]}" ]] && continue

        local value="${info_values[$label]}"
        value="${value#"${value%%[![:space:]]*}"}"

        # Cursor no início da label
        tput cup $((start_line + idx)) "$INFO_COL"

        if [[ "$SPACE_LABELINFO" == "yes" ]]; then
            # OS Arch Linux
            printf "%b%s %b" "$C_LABEL" "$label" "$C_RESET"
            value_col=$VALUE_START_COL
        else
            # OS > Arch Linux
            printf "%b%s %b%b%s%b" "$C_LABEL" "$label" "$C_RESET" "$C_VALUE" "$POINTER_CHAR" "$C_RESET"
            value_col=$((INFO_COL + ${#label} + ${#POINTER_CHAR} + 1))
        fi

        # Print value
        tput cup $((start_line + idx)) "$value_col"
        printf "%b%s%b" "$C_VALUE" " $value" "$C_RESET"

        ((idx++))
    done
}



# -------------------------------
# Print a group of info fields to stderr (for debug or overlay)
# -------------------------------
print_group_n() {
    local -n group=$1 
    local start_line=$2 idx=0

    for label in "${group[@]}"; do
        [[ ${SHOW[$label]:-0} != 1 || -z ${info_values[$label]} ]] && continue
        ((idx++))
    done

    echo "$idx"
}

# -------------------------------
# Print a horizontal separator line for groups
# -------------------------------
print_separator() {
    local sep=$1
    local width
    # Calculate max width for the group (from a helper function)
    width=$(calc_max_group_width "$sep")

    # Move cursor and print a line of dashes with color
    tput cup "$SKIPPING_LINES" "$INFO_COL"
    printf "%b%*s%b\n" "$C_VALUE" "$width" "" "$C_RESET" | tr ' ' '-'

    ((SKIPPING_LINES++))  # Increment skipped line counter
}

# -------------------------------
# Render a small color palette or character preview
# -------------------------------
color_render() {
    local line="$1"
    local col="$2"
    local char="  "
    local c
    local start_col="$col"

    # linha 1 (0–7)
    tput cup "$line" "$col"
    for c in {0..7}; do
        printf "%b%s%b" "\e[48;5;${c}m" "$char" "\e[0m"
        ((col+=${#char}))
        tput cup "$line" "$col"
    done

    # linha 2 (8–15)
    ((line++))
    col="$start_col"
    tput cup "$line" "$col"
    for c in {8..15}; do
        printf "%b%s%b" "\e[48;5;${c}m" "$char" "\e[0m"
        ((col+=${#char}))
        tput cup "$line" "$col"
    done
}




