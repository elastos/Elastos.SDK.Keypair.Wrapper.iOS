#!/bin/bash

set -o errexit
set -o nounset

CURRENT_DIR=$(cd $(dirname "${BASH_SOURCE[0]}") && pwd);
PROJECT_DIR=$(dirname "$CURRENT_DIR")
DEPENDS_DIR="$PROJECT_DIR/depends";

git -C "$PROJECT_DIR" submodule init;
git -C "$PROJECT_DIR" submodule update;

export PACKAGE_PLATFORM=iOS;
"$DEPENDS_DIR/Elastos.SDK.Keypair.C/scripts/package-mobile.sh" --with-filecoin;

rm -rf "$PROJECT_DIR/frameworks";
mkdir "$PROJECT_DIR/frameworks";

cp -rv "$DEPENDS_DIR/Elastos.SDK.Keypair.C/build/package/Elastos.SDK.Keypair.C.framework" "$PROJECT_DIR/frameworks";
