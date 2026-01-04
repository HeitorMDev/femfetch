#!/usr/bin/env bash
simplify_gpu_short() {
    local gpu="$1"
    gpu="${gpu/Intel Corporation /Intel }"
    gpu="${gpu/Advanced Micro Devices, Inc. /AMD }"
    gpu="${gpu/NVIDIA Corporation /NVIDIA }"
    gpu="$(sed -E 's/\(rev[^)]*\)//g' <<<"$gpu")"
    echo "$gpu"
}

info_os()       { awk -F= '/^PRETTY_NAME/{print $2}' /etc/os-release | tr -d '"'; }
info_host()     { cat /sys/class/dmi/id/product_name 2>/dev/null; }
info_kernel()   { uname -r; }
info_uptime()   { uptime -p | sed 's/up //'; }
info_packages() { pacman -Qq | wc -l; }
info_shell()    { basename "$SHELL"; }
info_terminal() { echo "$TERM"; }
info_display()  { xrandr | awk '/ connected/{print $1}'; }
info_wm()       { echo "${XDG_CURRENT_DESKTOP:-unknown}"; }
info_theme()    { gsettings get org.gnome.desktop.interface gtk-theme 2>/dev/null | tr -d "'"; }
info_icons()    { gsettings get org.gnome.desktop.interface icon-theme 2>/dev/null | tr -d "'"; }
info_font()     { gsettings get org.gnome.desktop.interface font-name 2>/dev/null | tr -d "'"; }
info_cursor()   { gsettings get org.gnome.desktop.interface cursor-theme 2>/dev/null | tr -d "'"; }
info_cpu()      { lscpu | awk -F: '/Model name/{print $2}' | sed 's/^ //'; }
info_gpu()      { simplify_gpu_short "$(lspci 2>/dev/null | grep -Ei 'vga|3d' | head -n1 | cut -d: -f3-)"; }
info_memory()   { free -h | awk '/Mem:/ {print $3 "/" $2}'; }
info_swap()     { free -h | awk '/Swap:/ {print $3 "/" $2}'; }
info_disk()     { df -h / | awk 'NR==2 {print $3 "/" $2}'; }
info_local_ip() { ip route get 1.1.1.1 | awk '{print $7; exit}'; }
info_locale()   { echo "$LANG"; }