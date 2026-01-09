#!/usr/bin/env bash
# logoLoader.sh - detecta nome simplificado da distro

simplify_distro_name() {
    local pretty
    pretty=$(awk -F= '/^PRETTY_NAME/{print $2}' /etc/os-release | tr -d '"')
    pretty=$(echo "$pretty" | sed 's/[[:space:]]*(.*)//; s/[[:space:]]*[0-9]\+\(\.[0-9]\+\)*[[:space:]]*\(LTS\)\?//g; s/(GNU\/Linux|Linux)[[:space:]]*//g')
    pretty=$(echo "$pretty" | awk '{print $1 " " ($2 ~ /^(OS|Linux)$/ ? $2 : "")}' | sed 's/[[:space:]]*$//')
    case "$pretty" in 
        Ubuntu*) echo "ubuntu" ;;
        "Zorin OS"*) echo "zorin" ;;
        "Linux Mint"*) echo "mint" ;;
        "Pop!_OS"*) echo "pop_os" ;;
        Fedora*) echo "fedora" ;;
        Debian*) echo "debian" ;;
        "Arch Linux"*) echo "arch" ;;
        "Manjaro Linux"*) echo "manjaro" ;;
        openSUSE*) echo "opensuse" ;;
        "elementary OS"*) echo "elementary" ;;
        "KDE neon"*) echo "neon" ;;
        "Rocky Linux"*) echo "rocky" ;;
        AlmaLinux*) echo "alma" ;;
        "CentOS"*) echo "cent" ;;
        Gentoo*) echo "gentoo" ;;
        Void*) echo "void" ;;
        NixOS*) echo "nix" ;;
        EndeavourOS*) echo "endeavour" ;;
        *) echo "$pretty" ;;
    esac
}

simplify_distro_name | tr '[:upper:]' '[:lower:]'
