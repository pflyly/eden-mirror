#!/bin/sh

# SPDX-FileCopyrightText: 2025 eden Emulator Project
# SPDX-License-Identifier: GPL-3.0-or-later

set -ex

if [[ $# != 2 ]]; then
    >&2 echo "Invalid arguments!"
    echo "Usage: $0 eden <build dir>"
    exit 1
fi

BUILD_APP="$1"
BUILD_DIR=$(realpath "$2")
DEPLOY_LINUX_FOLDER="${BUILD_DIR}/deploy-linux"
DEPLOY_LINUX_APPDIR_FOLDER="${BUILD_DIR}/deploy-linux/AppDir"
BIN_FOLDER="${BUILD_DIR}/bin"
BIN_EXE="${BIN_FOLDER}/${BUILD_APP}"

mkdir -p "${DEPLOY_LINUX_FOLDER}"
rm -rf "${DEPLOY_LINUX_APPDIR_FOLDER}"

cd "${BUILD_DIR}"

# deploy/install to deploy-linux/AppDir
DESTDIR="${DEPLOY_LINUX_APPDIR_FOLDER}" ninja install

cd "${DEPLOY_LINUX_FOLDER}"

# remove -cmd executable, not needed for AppImage
rm -fv "${DEPLOY_LINUX_APPDIR_FOLDER}/usr/bin/${BUILD_APP}-cli"

# Add Qt 6 specific environment variables
export QT_QPA_PLATFORM="wayland;xcb"
export EXTRA_PLATFORM_PLUGINS="libqwayland-egl.so;libqwayland-generic.so;libqxcb.so"
export EXTRA_QT_PLUGINS="svg;wayland-decoration-client;wayland-graphics-integration-client;wayland-shell-integration;waylandcompositor;xcb-gl-integration;platformthemes/libqt6ct.so"

# Update linuxdeploy commands for Qt 6
export QMAKE="/usr/bin/qmake6"
export QT_SELECT=6

# This assumes you have linuxdeploy-plugin-qt in ~/.local/bin
cp ~/.local/bin/linuxdeploy-plugin* .

# remove NO_STRIP=1 if linuxdeploy is updated, see: https://github.com/linuxdeploy/linuxdeploy/issues/272
NO_STRIP=1 APPIMAGE_EXTRACT_AND_RUN=1 linuxdeploy --appdir ./AppDir --plugin qt --plugin checkrt

# remove libwayland-client because it has platform-dependent exports and breaks other OSes
rm -fv ./AppDir/usr/lib/libwayland-client.so*

# remove libvulkan because it causes issues with gamescope
rm -fv ./AppDir/usr/lib/libvulkan.so*

rm linuxdeploy-plugin*