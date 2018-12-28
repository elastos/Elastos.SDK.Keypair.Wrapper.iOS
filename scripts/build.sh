#!/bin/bash - 

set -o errexit
set -o nounset

SCRIPT_DIR=$(cd $(dirname "${BASH_SOURCE[0]}") && pwd);
PROJECT_DIR=$(dirname "${SCRIPT_DIR}");
BUILD_NAME="$PROJECT_DIR/build";

PROJECT_NAME="ElastosOrgWalletLib";
PROJECT_BUILDTYPE="Release";

TARGET_PATH="$BUILD_NAME/${PROJECT_NAME}.framework";

cd "$PROJECT_DIR";
xcodebuild -target "lib" -configuration "${PROJECT_BUILDTYPE}" -arch arm64  -sdk "iphoneos"; # defines_module=yes
xcodebuild -target "lib" -configuration "${PROJECT_BUILDTYPE}" -arch x86_64 -sdk "iphonesimulator"; # defines_module=yes

rm -rf "$TARGET_PATH" && mkdir -p "$TARGET_PATH";
cp -r "$BUILD_NAME/${PROJECT_BUILDTYPE}-iphonesimulator/${PROJECT_NAME}.framework/"* "$TARGET_PATH/";
cp -r "$BUILD_NAME/${PROJECT_BUILDTYPE}-iphoneos/${PROJECT_NAME}.framework/"* "$TARGET_PATH/";

rm "$TARGET_PATH/${PROJECT_NAME}";
rm -rf "$TARGET_PATH/_CodeSignature";
lipo -create -output "$TARGET_PATH/$PROJECT_NAME" \
	"$BUILD_NAME/${PROJECT_BUILDTYPE}-iphoneos/${PROJECT_NAME}.framework/${PROJECT_NAME}" \
	"$BUILD_NAME/${PROJECT_BUILDTYPE}-iphonesimulator/${PROJECT_NAME}.framework/${PROJECT_NAME}" \

echo "Done!!!";

