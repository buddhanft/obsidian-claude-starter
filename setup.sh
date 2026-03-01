#!/bin/bash
# Vault Starter Kit Setup
# 用法：把 _starter-kit 的內容複製到你的 vault 目錄後，執行 bash setup.sh

VAULT_DIR="$(pwd)"

echo "=== Vault Starter Kit Setup ==="
echo "將在 $VAULT_DIR 建立 vault 結構"
echo ""

# 建立資料夾結構
dirs=(
  "00_Inbox"
  "01_Digest"
  "02_Thinking"
  "03_Output"
  "Health/00_Log"
  "Goals/00_Active"
  "Decisions"
  "Reviews"
  "Investing/00_Positions"
  "Investing/01_Watchlist"
  "Investing/02_Principles"
  "Investing/03_Research"
  "Investing/04_Retrospectives"
  "_workflow"
  ".claude/handoffs"
)

for dir in "${dirs[@]}"; do
  if [ ! -d "$VAULT_DIR/$dir" ]; then
    mkdir -p "$VAULT_DIR/$dir"
    touch "$VAULT_DIR/$dir/.gitkeep"
    echo "  ✓ $dir/"
  else
    echo "  - $dir/（已存在）"
  fi
done

echo ""
echo "=== Setup 完成 ==="
echo ""
echo "下一步："
echo "  1. 用 Obsidian 開啟此資料夾"
echo "  2. 編輯 .claude/me.md，填入你的個人資訊"
echo "  3. 在此目錄執行 claude 開始使用"
echo "  4. 試試 /digest 或 /health-log"
echo ""
echo "詳細說明見 README.md"
