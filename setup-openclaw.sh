#!/bin/bash

# OpenClaw ワークスペース・設定ファイルのシンボリックリンク作成スクリプト
#
# 各ワークスペースと設定ファイルを ~/.openclaw/ 以下に配置します

set -e

# 定義
PROJECT_DIR="/home/john/programming/companyArchitecture"
OPENCLAW_DIR="$HOME/.openclaw"

# ワークスペースのリスト
WORKSPACES=(
    "workspace-value-orchestrator"
    "workspace-algorithmic-architect"
    "workspace-cognitive-designer"
    "workspace-strategic-catalyst"
    "workspace-adaptive-operator"
    "workspace-discord-interface"
)

# 絵文字での表示
echo "🔧 OpenClaw ワークスペース設定を開始します..."
echo ""

# ~/.openclaw ディレクトリが存在しない場合は作成
if [ ! -d "$OPENCLAW_DIR" ]; then
    echo "📁 ~/.openclaw ディレクトリを作成します"
    mkdir -p "$OPENCLAW_DIR"
fi

# ワークスペースのシンボリックリンク作成
echo "📎 ワークスペースのシンボリックリンクを作成します:"
echo ""

for ws in "${WORKSPACES[@]}"; do
    SOURCE="$PROJECT_DIR/$ws"
    TARGET="$OPENCLAW_DIR/$ws"

    # 既存のリンクやディレクトリを確認
    if [ -e "$TARGET" ]; then
        if [ -L "$TARGET" ]; then
            # 既存のシンボリックリンクを削除
            echo "  🔗 既存のリンクを削除: $ws"
            rm "$TARGET"
        else
            # ディレクトリやファイルが存在する場合はバックアップ
            echo "  ⚠️  既存のディレクトリをバックアップします: $ws"
            mv "$TARGET" "${TARGET}.backup.$(date +%Y%m%d%H%M%S)"
        fi
    fi

    # シンボリックリンク作成
    echo "  ✅ $ws → ~/.openclaw/"
    ln -s "$SOURCE" "$TARGET"
done

echo ""

# openclaw.json のシンボリックリンク作成
OPENCLAW_JSON_SOURCE="$PROJECT_DIR/openclaw.json"
OPENCLAW_JSON_TARGET="$OPENCLAW_DIR/openclaw.json"

if [ -e "$OPENCLAW_JSON_TARGET" ]; then
    if [ -L "$OPENCLAW_JSON_TARGET" ]; then
        echo "🔗 既存の openclaw.json リンクを削除"
        rm "$OPENCLAW_JSON_TARGET"
    else
        echo "⚠️  既存の openclaw.json をバックアップします"
        mv "$OPENCLAW_JSON_TARGET" "${OPENCLAW_JSON_TARGET}.backup.$(date +%Y%m%d%H%M%S)"
    fi
fi

echo "✅ openclaw.json → ~/.openclaw/openclaw.json"
ln -s "$OPENCLAW_JSON_SOURCE" "$OPENCLAW_JSON_TARGET"

echo ""
echo "🎉 設定完了！"
echo ""
echo "🔄 設定を再読み込みするには、OpenClaw を再起動してください"
