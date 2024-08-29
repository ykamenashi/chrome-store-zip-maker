#!/bin/bash

TMP_STORE_DIR="$HOME/tmp/chrome-addon-packing"

usage(){
    echo "Usage: $0 <directory>"
    exit 0
}

if [ $# -ne 1 ]; then
    usage
fi

COPY_SOURCE_DIR="$1"
BARE_DIR_NAME=$(basename "$COPY_SOURCE_DIR")
COPY_DEST_DIR="$TMP_STORE_DIR/$BARE_DIR_NAME"

if [ ! -d "$TMP_STORE_DIR" ]; then
    mkdir -p "$TMP_STORE_DIR"
fi

if [ -d "$TMP_STORE_DIR/$1" ]; then
    rm -rf "${TMP_STORE_DIR}/${COPY_SOURCE_DIR:?}"
fi

cp -r "$COPY_SOURCE_DIR" "$COPY_DEST_DIR"
rm -rf "$COPY_DEST_DIR/.git"

TIMESTAMP=$(date +%Y%m%d%H%M%S)

zip -r "$TMP_STORE_DIR/$BARE_DIR_NAME-$TIMESTAMP.zip" "$COPY_DEST_DIR"

open "$TMP_STORE_DIR"

exit 0