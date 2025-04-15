#! /bin/bash
set -e

# Parse options
for i in "$@"
do
case $i in
    -l|--clang)
        export BUILD_USE_CLANG=1
        echo "-> Using Clang for compilation."
    ;;
    -o|--thin-lto)
        export BUILD_USE_THIN_LTO=1
        echo "-> Thin link time optimization enabled."
    ;;
    -O|--fat-lto)
        export BUILD_USE_FAT_LTO=1
        echo "-> Fat link time optimization enabled."
    ;;
    -p|--use-cpm)
        export BUILD_USE_CPM=1
        echo "-> Using CPM to download most dependencies."
    ;;
    -k|--keep-rootfs)
        BUILD_KEEP_ROOTFS=1
        echo "-> Not deleting rootfs after successful build."
    ;;
    *)
        echo "Usage: $0 [--clang/-l] [--thin-lto/-o] [--fat-lto/-O] [--use-cpm/-p] [--keep-rootfs/-k]"
        exit 1
    ;;
esac
done

# Make sure options are valid
if [ "$BUILD_USE_THIN_LTO" = 1 ] && [ "$BUILD_USE_CLANG" != 1 ]; then
    echo "Thin LTO can't be used without Clang!"
    exit 2
fi
if [ "$BUILD_USE_THIN_LTO" = 1 ] && [ "$BUILD_USE_FAT_LTO" = 1 ]; then
    echo "Only either thin or fat LTO can be used!"
    exit 2
fi

# Get torzu source dir
TORZU_SOURCE_DIR="$(realpath "$(dirname "${BASH_SOURCE[0]}")")"
echo "-> Source dir is $TORZU_SOURCE_DIR"
rm -rf "$TORZU_SOURCE_DIR/AppImageBuilder/build"

# Generate debian rootfs
cd /tmp
echo "Cleaning up before build..."
rm -rf torzu-debian-appimage-rootfs
[ -d rootfs-torzu-appimage-build ] ||
    debootstrap stable rootfs-torzu-appimage-build http://deb.debian.org/debian/
bwrap --bind rootfs-torzu-appimage-build / \
      --unshare-pid \
      --dev-bind /dev /dev --proc /proc --tmpfs /tmp --ro-bind /sys /sys --dev-bind /run /run \
      --tmpfs /var/tmp \
      --chmod 1777 /tmp \
      --ro-bind /etc/resolv.conf /etc/resolv.conf \
      --ro-bind "$TORZU_SOURCE_DIR" /tmp/torzu-src-ro \
      --chdir / \
      --tmpfs /home \
      --setenv HOME /home \
      --bind /tmp /tmp/hosttmp \
        /tmp/torzu-src-ro/AppImage-build-debian-inner.sh
appimagetool torzu-debian-appimage-rootfs torzu.AppImage
echo "AppImage generated at /tmp/torzu.AppImage! Cleaning up..."
rm -rf torzu-debian-appimage-rootfs
if [ ! "$BUILD_KEEP_ROOTFS" = 1 ]; then
        rm -rf rootfs-torzu-appimage-build
fi
