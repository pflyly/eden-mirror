HOST_DIR=$1
QT_DIR=$2

cd eden-windows-msvc
cp "/c/Program Files (x86)/Windows Kits/10/bin/10.0.22621.0/arm64/dxcompiler.dll" .
for i in `$HOST_DIR/bin/windeployqt.exe ./eden.exe --no-plugins  --no-compiler-runtime --no-opengl-sw --no-system-d3d-compiler --no-translations --verbose 1 --dry-run | grep "Updating .*dll" | cut -d" " -f2 | cut -d"." -f1-2`
do
    cp $QT_DIR/bin/$i .
done

PLUGIN_DIRS=`$HOST_DIR/bin/windeployqt.exe ./eden.exe --no-libraries --plugindir plugins --no-compiler-runtime --no-opengl-sw --no-system-d3d-compiler --no-translations --verbose 1 --dry-run | grep "Creating directory" | cut -d" " -f3 | cut -d"." -f1`
for i in $PLUGIN_DIRS
do
    mkdir -p $i
done

for i in `$HOST_DIR/bin/windeployqt.exe ./eden.exe --no-libraries --no-compiler-runtime --no-opengl-sw --no-system-d3d-compiler --no-translations --list source --dry-run`
do
    PLUGIN=$(cut -d "\\" -f5- <<< $i)
    cp $QT_DIR/$PLUGIN ./$PLUGIN
done

## Zip
cd ..
GITDATE=$(git show -s --date=short --format='%ad' | tr -d "-")
GITREV=$(git show -s --format='%h')

BUILD_ZIP="eden-windows-msvc-$GITDATE-$GITREV-aarch64.zip"
7z a -tzip artifacts/$BUILD_ZIP eden-windows-msvc/*
