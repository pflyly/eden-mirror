#!/bin/sh

if [[ $# != 2 ]]; then
    >&2 echo "Invalid arguments!"
    echo "Usage: $0 <build dir> v3"
    exit 1
fi

BUILD_DIR=$(realpath "$1")

export BASE_ARCH="$(uname -m)"
export ARCH="$BASE_ARCH"

EDEN_TAG=$(git describe --tags --abbrev=0)
echo "Making stable \"$EDEN_TAG\" build"
# git checkout "$EDEN_TAG"
VERSION="$(echo "$EDEN_TAG")"

URUNTIME="https://github.com/VHSgunzo/uruntime/releases/latest/download/uruntime-appimage-dwarfs-$ARCH"

if [ "$ARCH" = 'x86_64' ]; then
	if [ "$2" = 'v3' ]; then
		ARCH="${ARCH}_v3"
	fi
fi

./.ci/linux/appimage-light.sh eden $BUILD_DIR

# accounts for gentoo madness
cp /usr/lib*/libSDL3.so* $BUILD_DIR/deploy-linux/AppDir/usr/lib/ # Copying libsdl3 to target AppDir

# Prepare uruntime
wget -q "$URUNTIME" -O ./uruntime
chmod +x ./uruntime

# Add update info to runtime
UPINFO='gh-releases-zsync|eden-emulator|Releases|latest|*.AppImage.zsync'

echo "Adding update information \"$UPINFO\" to runtime..."
./uruntime --appimage-addupdinfo "$UPINFO"

# Turn AppDir into appimage
echo "Generating AppImage..."
./uruntime --appimage-mkdwarfs -f --set-owner 0 --set-group 0 --no-history --no-create-timestamp --compression zstd:level=22 -S26 -B32 \
--header uruntime -i $BUILD_DIR/deploy-linux/AppDir -o Eden-Light-"$VERSION"-"$ARCH".AppImage

echo "Generating zsync file..."
zsyncmake Eden-Light-"$VERSION"-"$ARCH".AppImage -u Eden-Light-"$VERSION"-"$ARCH".AppImage

echo "All Done!"
