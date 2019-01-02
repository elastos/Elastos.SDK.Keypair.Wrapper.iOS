#!/bin/bash - 

set -o errexit
set -o nounset

SCRIPT_DIR=$(cd $(dirname "${BASH_SOURCE[0]}") && pwd);
PROJECT_DIR=$(dirname "${SCRIPT_DIR}");
BUILD_NAME="$PROJECT_DIR/build";

PROJECT_NAME="ElastosOrgWalletLib";
PROJECT_BUILDTYPE="Release";
PROJECT_REVISION="$(git rev-list --count HEAD)";
PROJECT_VERSION="v0.1.$PROJECT_REVISION";

TARGET_PATH="$BUILD_NAME/${PROJECT_NAME}-${PROJECT_VERSION}.framework";

cd "$PROJECT_DIR";
export CURRENT_PROJECT_VERSION=${PROJECT_REVISION};
export CURRENT_PROJECT_VERSIONNAME=${PROJECT_VERSION/v/};
xcodebuild -target "lib" -configuration "${PROJECT_BUILDTYPE}" -arch arm64  -sdk "iphoneos" \
	CURRENT_PROJECT_VERSION=${PROJECT_REVISION} CURRENT_PROJECT_VERSIONNAME=${PROJECT_VERSION/v/};
xcodebuild -target "lib" -configuration "${PROJECT_BUILDTYPE}" -arch x86_64 -sdk "iphonesimulator" \
	CURRENT_PROJECT_VERSION=${PROJECT_REVISION} CURRENT_PROJECT_VERSIONNAME=${PROJECT_VERSION/v/};

rm -rf "$TARGET_PATH" && mkdir -p "$TARGET_PATH";
cp -r "$BUILD_NAME/${PROJECT_BUILDTYPE}-iphonesimulator/${PROJECT_NAME}.framework/"* "$TARGET_PATH/";
cp -r "$BUILD_NAME/${PROJECT_BUILDTYPE}-iphoneos/${PROJECT_NAME}.framework/"* "$TARGET_PATH/";

rm "$TARGET_PATH/${PROJECT_NAME}";
rm -rf "$TARGET_PATH/_CodeSignature";
lipo -create -output "$TARGET_PATH/$PROJECT_NAME" \
	"$BUILD_NAME/${PROJECT_BUILDTYPE}-iphoneos/${PROJECT_NAME}.framework/${PROJECT_NAME}" \
	"$BUILD_NAME/${PROJECT_BUILDTYPE}-iphonesimulator/${PROJECT_NAME}.framework/${PROJECT_NAME}";
git tag --force ${PROJECT_VERSION}

echo "Done!!!";

