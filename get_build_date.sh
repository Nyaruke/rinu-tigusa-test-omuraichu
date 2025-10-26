#!/usr/bin/env bash

# build.prop のパス
BUILD_PROP="out/target/product/a04br3/system/build.prop"

# 対象のキー
KEY="ro.build.date.utc"

# ファイルが存在するかチェック
if [ ! -f "$BUILD_PROP" ]; then
    echo "エラー: $BUILD_PROP が見つかりません。" >&2
    exit 1
fi

# grep でキー検索 → sed で値抽出
VALUE=$(grep "^$KEY=" "$BUILD_PROP" | head -n1 | sed -e "s/^$KEY=//" -e 's/#.*$//' -e 's/^[[:space:]]*//' -e 's/[[:space:]]*$//')

# 値が空でないかチェック
if [ -z "$VALUE" ]; then
    echo "エラー: $KEY が見つかりません。" >&2
    exit 1
else
    echo "$VALUE"
    exit 0
fi
