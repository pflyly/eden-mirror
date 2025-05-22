@echo off

set chain=%1
set qt_dir=%2
set qt_host=%3
set ffmpeg_dir=%4

if not defined DevEnvDir (
	CALL "C:\Program Files\Microsoft Visual Studio\2022\Community\VC\Auxiliary\Build\vcvarsall.bat" %chain%
)

CALL mkdir build

@REM TODO: enable QtWebEngine and translations, awaiting Qt builds
CALL cmake -S . -B build\%chain% ^
-DCMAKE_BUILD_TYPE=Release ^
-DENABLE_QT_TRANSLATION=OFF ^
-DUSE_DISCORD_PRESENCE=ON ^
-DYUZU_USE_BUNDLED_QT=OFF ^
-DYUZU_USE_QT_MULTIMEDIA=ON ^
-DYUZU_USE_QT_WEB_ENGINE=OFF ^
-DYUZU_USE_BUNDLED_VCPKG=ON ^
-DYUZU_USE_BUNDLED_SDL2=OFF ^
-DYUZU_USE_EXTERNAL_SDL2=ON ^
-DFFmpeg_PATH=%ffmpeg_dir% ^
-DYUZU_ENABLE_LTO=ON ^
-G "Ninja" ^
-DYUZU_TESTS=OFF ^
-DQt6_DIR=%qt_dir% ^
-DCMAKE_WINDOWS_EXPORT_ALL_SYMBOLS=ON ^
-DQT_TARGET_PATH=%qt_dir% ^
-DQT_HOST_PATH=%qt_host%

CALL cmake --build build\%chain%
