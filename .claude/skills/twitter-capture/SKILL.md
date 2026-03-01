# /twitter-capture

擷取 Twitter/X thread 內容，判斷後詢問是否存入 Inbox。

## 觸發條件
- 使用者貼 Twitter/X 連結
- 使用者說「幫我抓這個 thread」

## 不要觸發
- 不是 Twitter/X 的連結 → 提醒使用者這個 skill 只處理 Twitter
- 使用者已經明確說不要存 → 直接對話討論

## 執行步驟

### 1. 開啟頁面
使用 browser MCP 導航到 Twitter/X URL。

### 2. 擷取快照
使用 browser snapshot 取得頁面內容。

### 3. 提取 Thread 內容
- 提取所有推文文字
- 保留發文順序
- 記錄作者資訊

### 4. 先做判斷，再問使用者
**不要直接建檔。** 先：
1. 摘要內容重點（2-3 句）
2. 給出你的判斷（這篇值不值得存、為什麼）
3. 如果值得存，建議分類（投資/效率/思維/技術/健康）
4. 問使用者：「要存到 Inbox 嗎？」

### 5. 使用者確認後建立 Inbox 檔案
命名規則：`{分類}-{標題關鍵字}-{作者}-{YYYY-MM}.md`

### 6. 儲存
儲存到 `00_Inbox/`

### 7. 後續建議
告知使用者可以用 `/digest` 來產生摘要。

## 檔案位置
- 輸出：`00_Inbox/`
- 命名規則：見 `.claude/rules/naming-conventions.md`

## Skill 網絡
- 下游：`/digest`（對擷取的內容做摘要）
- 監控：`/inbox-status`（追蹤 Inbox 累積量）
- 輸出至：[[moc-技術]]、[[moc-investing]]、[[moc-learning]]（依分類）
