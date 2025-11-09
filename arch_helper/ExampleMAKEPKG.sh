# Maintainer: Your Name <your.email@example.com>
pkgname=arch_helper
pkgver=1.0.0
pkgrel=1
pkgdesc="A brief description of what arch_helper does."
arch=('x86_64')
url="https://example.com/arch_helper"
license=('MIT')
depends=('flutter')
makedepends=('flutter')
source=("https://example.com/arch_helper/archive/v$pkgver.tar.gz")
sha256sums=('SKIP') # You should compute the checksum or skip to install

package() {
    cd "$srcdir/arch_helper-$pkgver"
    flutter build linux --release
    install -Dm755 build/linux/x64/release/bundle/arch_helper "$pkgdir/usr/bin/arch_helper"
    install -Dm644 "$srcdir/arch_helper.desktop" "$pkgdir/usr/share/applications/arch_helper.desktop"
    install -Dm644 build/linux/x64/release/bundle/icons/* "$pkgdir/usr/share/icons/hicolor/"
}
