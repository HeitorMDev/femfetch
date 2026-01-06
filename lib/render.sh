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
    local -n group=$1 start_line=$2 idx=0

    for label in "${group[@]}"; do
        # Skip if field is disabled or empty
        [[ ${SHOW[$label]:-0} != 1 || -z ${info_values[$label]} ]] && continue

        # Trim leading spaces from the value
        local value="${info_values[$label]#"${info_values[$label]%%[![:space:]]*}"}"

        # Move cursor to the label column and print label with color
        if [[ "$SPACE_LABELINFO" != "yes" ]]; then
            tput cup $((start_line + idx)) "$INFO_COL"
            printf "%b%-${max_label}s%s%b" "$C_LABEL" "$label" "$POINTER_CHAR" "$C_RESET"
        else
            tput cup $((start_line + idx)) "$INFO_COL"
            printf "%b%-${max_label}s%b" "$C_LABEL" "$label" "$C_RESET"
        fi

        # Move cursor to the value column and print the value with color
        tput cup $((start_line + idx)) "$VALUE_START_COL"
        printf "%b%s%b" "$C_VALUE" "$value" "$C_RESET"

        ((idx++))
    done

    # Return the number of printed lines
}

# -------------------------------
# Print a group of info fields to stderr (for debug or overlay)
# -------------------------------
print_group_n() {
    local -n group=$1 start_line=$2 idx=0

    for label in "${group[@]}"; do
        [[ ${SHOW[$label]:-0} != 1 || -z ${info_values[$label]} ]] && continue
        local value="${info_values[$label]#"${info_values[$label]%%[![:space:]]*}"}"

        tput cup $((start_line + idx)) "$INFO_COL" >&2
        printf "%b%-${max_label}s%b" "$C_LABEL" "$label" "$C_RESET" >&2

        tput cup $((start_line + idx)) "$VALUE_START_COL" >&2
        printf "%b%s%b" "$C_VALUE" "$value" "$C_RESET" >&2

        ((idx++))
    done

    echo "$idx"
}

# -------------------------------
# Print a horizontal separator line for groups
# -------------------------------
print_separator() {
    sep=$1

    local width
    # Calculate max width for the group (from a helper function)
    width=$(calc_max_group_width sep)

    # Move cursor and print a line of dashes with color
    tput cup "$SKIPPING_LINES" "$INFO_COL"
    printf "%b%*s%b\n" "$C_VALUE" "$width" "$C_RESET" | tr ' ' '-'

    ((SKIPPING_LINES++))  # Increment skipped line counter
}

# -------------------------------
# Render a small color palette or character preview
# -------------------------------
color_render() {
    local pad="$1" char="$2" PALETTE_MODE="$3"

    # Add spacing before the palette
    printf '\n\n%*s' "$pad" ""

    # Print first row (colors 0-7)
    case "$PALETTE_MODE" in
        fg) for c in {0..7}; do printf "\e[38;5;%sm%s\e[0m" "$c" "$char"; done ;;
        bg) for c in {0..7}; do printf "\e[48;5;%sm%s\e[0m" "$c" "$char"; done ;;
        emoji) for c in {0..7}; do printf "%s" "$char"; done ;;
    esac

    # Move to next row with same padding
    printf '\n%*s' "$pad" ""

    # Print second row (colors 8-15)
    case "$PALETTE_MODE" in
        fg) for c in {8..15}; do printf "\e[38;5;%sm%s\e[0m" "$c" "$char"; done ;;
        bg) for c in {8..15}; do printf "\e[48;5;%sm%s\e[0m" "$c" "$char"; done ;;
        emoji) for c in {0..7}; do printf "%s" "$char"; done ;;
    esac

    # Final newline
    printf '\n'
}
