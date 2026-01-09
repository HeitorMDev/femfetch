# Maintainer: Your Name <youremail@example.com>
pkgname=femfetch
pkgver=1.0
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
    cd "$srcdir/femfetch-1.0"
    echo "0.1"
}

build() {
    cd "$srcdir/femfetch-1.0"
    # nothing to compile, all scripts are interpreted
    :
}

package() {
    cd "$srcdir/femfetch-1.0/main"

    # -------------------------------
    # Executables
    # -------------------------------
    install -Dm755 "src/femfetch" "$pkgdir/usr/bin/femfetch"
    install -Dm755 -t "$pkgdir/usr/bin/" "src/loadGIF"           # rawGifer
    install -Dm755 -t "$pkgdir/usr/bin/" "src/AsciiGen"          # AsciiGen

    # -------------------------------
    # Libraries / helpers
    # -------------------------------
    install -d "$pkgdir/usr/share/femfetch/lib"
    install -Dm644 data/lib/* "$pkgdir/usr/share/femfetch/lib/"


    # -------------------------------
    # AsciiGIF tools
    # -------------------------------
    install -Dm755 -t "$pkgdir/usr/share/femfetch/AsciiGIF" "data/asciitools/renderJ.py"        # asgif, renderJ.py
    install -Dm755 -t "$pkgdir/usr/share/femfetch/AsciiGIF" "data/asciitools/asgif"

    # -------------------------------
    # Anim killer script
    # -------------------------------
    install -Dm755 "data/helpers/animKiller.sh" "$pkgdir/usr/share/femfetch/animKiller.sh"

    # -------------------------------
    # Frames and GIFs
    # -------------------------------
    install -d "$pkgdir/usr/share/femfetch/frames"
    install -d "$pkgdir/usr/share/femfetch/distros"
    install -d "$pkgdir/usr/share/femfetch/ascii"
    cp -r data/ascii/* "$pkgdir/usr/share/femfetch/ascii/"
    cp -r data/distros/* "$pkgdir/usr/share/femfetch/distros/"

    # -------------------------------
    # ASCII header
    # -------------------------------
    install -Dm644 "data/femfetch_ascii.txt" "$pkgdir/usr/share/femfetch/femfetch_ascii.txt"

    # -------------------------------
    # Configuration
    # -------------------------------
    install -d "$pkgdir/etc/femfetch"
    install -Dm644 "config/femfetch.conf" "$pkgdir/etc/femfetch/femfetch.conf"

    # -------------------------------
    # Paths helper
    # -------------------------------
    install -Dm755 "data/helpers/paths.sh" "$pkgdir/usr/share/femfetch/paths.sh"
}
