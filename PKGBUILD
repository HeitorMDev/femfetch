# Maintainer: Your Name <youremail@example.com>
pkgname=femfetch
pkgver=0.9b
pkgrel=1
pkgdesc="A flashy terminal system info fetcher with ASCII/GIF animations"
arch=('x86_64')
url="https://github.com/HeitorMDev/femfetch"
license=('MIT')
depends=('bash' 'python' 'imagemagick' 'figlet')
makedepends=('git')
source=("https://github.com/HeitorMDev/femfetch/archive/refs/tags/v$pkgver.tar.gz")
sha256sums=('SKIP') # replace with actual sha256sum

pkgver() {
    cd "$srcdir/femfetch-0.9b"
    echo "0.9b"
}

build() {
    cd "$srcdir/femfetch-0.9b"
    # nothing to compile, all scripts are interpreted
    :
}

package() {
    cd "$srcdir/femfetch-0.9b"

    # -------------------------------
    # Executables
    # -------------------------------
    install -Dm755 "bin/femfetch" "$pkgdir/usr/bin/femfetch"
    install -Dm755 "bin/femfetch-info.sh" "$pkgdir/usr/bin/femfetch-info.sh"

    # -------------------------------
    # Libraries / helpers
    # -------------------------------
    install -Dm755 -t "$pkgdir/usr/share/femfetch/lib" lib/*

    # -------------------------------
    # AsciiGIF tools
    # -------------------------------
    install -Dm755 -t "$pkgdir/usr/share/femfetch/AsciiGIF" AsciiGIF/*        # asgif, renderJ.py
    install -Dm755 -t "$pkgdir/usr/share/femfetch/AsciiGIF" loadGIF           # rawGifer
    install -Dm755 -t "$pkgdir/usr/share/femfetch/AsciiGIF" AsciiGen          # AsciiGen


    # -------------------------------
    # Anim killer script
    # -------------------------------
    install -Dm755 "animKiller.sh" "$pkgdir/usr/share/femfetch/animKiller.sh"

    # -------------------------------
    # Frames and GIFs
    # -------------------------------
    install -d "$pkgdir/usr/share/femfetch/frames"
    install -d "$pkgdir/usr/share/femfetch/distros"
    cp -r ascii/* "$pkgdir/usr/share/femfetch/ascii/"
    cp -r distros/* "$pkgdir/usr/share/femfetch/distros/"

    # -------------------------------
    # ASCII header
    # -------------------------------
    install -Dm644 "femfetch_ascii.txt" "$pkgdir/usr/share/femfetch/femfetch_ascii.txt"

    # -------------------------------
    # Configuration
    # -------------------------------
    install -Dm644 "femfetch.conf" "$pkgdir/etc/femfetch.conf"

    # -------------------------------
    # Paths helper
    # -------------------------------
    install -Dm755 "paths.sh" "$pkgdir/usr/share/femfetch/paths.sh"
}
