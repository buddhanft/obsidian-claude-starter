# /inbox-status

檢查 Inbox 處理狀態，顯示待處理項目數量。

## 觸發條件
- 使用者說「inbox status」「inbox 有多少」
- 使用者想知道有多少東西還沒處理

## 不要觸發
- 使用者想處理某篇 Inbox → `/digest`
- 使用者想抓新的 Twitter 內容 → `/twitter-capture`
- 使用者想看知識工作總覽 → `/weekly-review`

## 執行步驟

### 1. 計算 Inbox 數量
計算 `00_Inbox/` 中的檔案數量（排除 `_Archive/`）。

### 2. 計算 Digest 數量
計算 `01_Digest/` 中的檔案數量。

### 3. 找出未處理項目
比對 Inbox 和 Digest，找出還沒有對應 Digest 的 Inbox 項目。

### 3.5 按年齡分層

用檔名中的日期（`-YYYY-MM.md`）計算每篇 Inbox 的年齡：
- **新鮮**（< 14 天）：正常待處理
- **老化**（14-30 天）：建議盡快 digest 或歸檔
- **過期**（> 30 天）：建議歸檔到 `00_Inbox/_Archive/`

### 4. 顯示摘要
```
📥 Inbox: X 項（待處理 Z 項）

  🟢 新鮮 (< 14 天): A 項
  🟡 老化 (14-30 天): B 項
  🔴 過期 (> 30 天): C 項 — 建議歸檔

📜 Digest: Y 項
```

如果過期 > 20 項，主動建議：
「有 C 篇 Inbox 超過一個月沒處理。要不要我列出來，你決定哪些歸檔、哪些 digest？」

### 5. 列出待處理清單（可選）
如果使用者想看，列出還沒處理的 Inbox 項目（按年齡分組顯示）。

## 輸出格式
直接在對話中顯示，**不建立新檔案**。

## 檔案位置
- Inbox：`00_Inbox/`
- Digest：`01_Digest/`

## Skill 網絡
- 處理項目：`/digest`（做摘要）
- 新增項目：`/twitter-capture`（擷取推文）
- 週報整合：`/weekly-review`（知識工作部分）
- 知識整合：knowledge-synthesizer agent（多篇關聯分析）
