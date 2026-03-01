# /weekly-review

產生完整的週回顧報告，涵蓋健康、知識工作、目標進度。

## 觸發條件
- 使用者說「weekly review」「做週報」
- 使用者明確要求週回顧

## 不要觸發
- 使用者只想看健康數據 → `/health-check`
- 使用者只想看月度健康 → `/monthly-health-review`
- 使用者想記錄今天的健康 → `/health-log`
- 使用者想看 Inbox 狀態 → `/inbox-status`

## 執行步驟

### 1. 確定日期範圍
- 計算當前週數（ISO week）
- 日期範圍：週一到週日

### 2. 收集健康數據
讀取 `Health/00_Log/` 中該週的所有 health logs，計算：
- 平均值：體重、睡眠、能量、專注
- 趨勢：與上週比較
- 運動頻率

### 3. 收集知識工作
- 讀取 `00_Inbox/` 中該週新增的項目
- 讀取 `01_Digest/` 中該週新增的項目

### 4. 檢查目標進度
讀取 `Goals/00_Active/` 中的目標，計算完成度。

### 4.5 掃描過期項目

#### 投資論述
讀取 `Investing/00_Positions/` 所有 thesis 的 frontmatter：
- `last_updated` 超過 14 天 → 標記為「需要回顧」⚠️
- `last_updated` 超過 30 天 → 標記為「嚴重過期」🔴

#### 決策紀錄
讀取 `Decisions/` 所有決策的 frontmatter：
- `review_date` 已過 → 標記為「需要回顧」⚠️
- `outcome` 為空 → 標記為「缺少結果紀錄」

#### 在週報中顯示
在報告的「知識工作」section 後加 `## ⏰ 過期提醒`，列出所有過期項目。
若無過期項目，不顯示此 section。

### 5. 分析相關性
- 睡眠時長 vs 專注分數
- 運動 vs 隔天能量
- 當資料點 > 5 個時，計算相關係數

### 6. 產生報告
使用模板 `_Templates/tpl-weekly-review.md`（模板較長，保留外部引用）。
儲存到 `Reviews/weekly-YYYY-WXX.md`

## 檔案位置
- 模板：`_Templates/tpl-weekly-review.md`
- 輸出：`Reviews/weekly-YYYY-WXX.md`

## Skill 網絡
- 健康數據：`/health-log`（每日紀錄）、`/health-check`（快速檢查）、`/monthly-health-review`（月報）
- 知識工作：`/inbox-status`（待處理清單）、`/digest`（已完成摘要）
- 目標進度：`/goal`（目標追蹤）
- 分析支援：health-analyst agent（健康趨勢）、knowledge-synthesizer agent（知識整合）
- 相關 MOC：[[moc-investing]]、[[moc-learning]]

## 累積規則（自我改善迴路）

每次週報被使用者糾正或稱讚時，更新這個區塊。

### Don'ts（失敗教訓）
<!-- 格式：- [日期] 問題描述 → 應該怎麼做 -->

### Do's（成功公式）
<!-- 格式：- [日期] 什麼做對了 → 為什麼有效 -->
