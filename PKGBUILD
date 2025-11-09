pkgname=arch_helper
pkgver=1.0.0
pkgrel=1
pkgdesc="A new arch script and installation client for my red40arch project."
arch=('any')
url="https://github.com/esmodea/arch-helper"
license=('GPL3')
depends=('gtk3' 'util-linux' 'xz')
source=("https://github.com/esmodea/arch-helper.git")
md5sums=('SKIP')

package() {
    cd "$srcdir/../$pkgname"
    flutter pub get
    flutter build linux
    install -Dm755 build/linux/x64/release/bundle/arch_helper "$pkgdir/usr/bin/$pkgname"
    install -d -Dm755 build/linux/x64/release/bundle/lib "$pkgdir/usr/bin/lib"
    install -d -Dm755 build/linux/x64/release/bundle/data "$pkgdir/usr/bin/data"
    install -d -Dm755 build/linux/x64/release/bundle/data/flutter_assets "$pkgdir/usr/bin/data/flutter_assets"
    install -d -Dm755 build/linux/x64/release/bundle/data/flutter_assets/fonts "$pkgdir/usr/bin/data/flutter_assets/fonts"
    install -d -Dm755 build/linux/x64/release/bundle/data/flutter_assets/shaders "$pkgdir/usr/bin/data/flutter_assets/shaders"
    install -Dm755 build/linux/x64/release/bundle/lib/libflutter_linux_gtk.so "$pkgdir/usr/bin/lib/libflutter_linux_gtk.so"
    install -Dm755 build/linux/x64/release/bundle/lib/libapp.so "$pkgdir/usr/bin/lib/libapp.so"
    install -Dm755 build/linux/x64/release/bundle/data/icudtl.dat "$pkgdir/usr/bin/data/icudtl.dat"
    install -Dm755 build/linux/x64/release/bundle/data/flutter_assets/AssetManifest.bin "$pkgdir/usr/bin/data/flutter_assets/AssetManifest.bin"
    install -Dm755 build/linux/x64/release/bundle/data/flutter_assets/AssetManifest.json "$pkgdir/usr/bin/data/flutter_assets/AssetManifest.json"
    install -Dm755 build/linux/x64/release/bundle/data/flutter_assets/FontManifest.json "$pkgdir/usr/bin/data/flutter_assets/FontManifest.json"
    install -Dm755 build/linux/x64/release/bundle/data/flutter_assets/NativeAssetsManifest.json "$pkgdir/usr/bin/data/flutter_assets/NativeAssetsManifest.json"
    install -Dm755 build/linux/x64/release/bundle/data/flutter_assets/NOTICES.Z "$pkgdir/usr/bin/data/flutter_assets/NOTICES.Z"
    install -Dm755 build/linux/x64/release/bundle/data/flutter_assets/version.json "$pkgdir/usr/bin/data/flutter_assets/version.json"
    install -Dm755 build/linux/x64/release/bundle/data/flutter_assets/shaders/ink_sparkle.frag "$pkgdir/usr/bin/data/flutter_assets/shaders/ink_sparkle.frag"
    install -Dm755 build/linux/x64/release/bundle/data/flutter_assets/fonts/MaterialIcons-Regular.otf "$pkgdir/usr/bin/data/flutter_assets/fonts/MaterialIcons-Regular.otf"
}
