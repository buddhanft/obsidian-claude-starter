# /monthly-health-review

產生月度健康報告，含統計、趨勢、目標對比。

## 觸發條件
- 使用者說「monthly health review」「這個月健康報告」
- 使用者明確要求月度健康總結

## 不要觸發
- 使用者想快速看最近幾天 → `/health-check`
- 使用者想做週報（含知識工作等） → `/weekly-review`
- 使用者問健康問題 → health-analyst agent
- 月份還沒結束且使用者沒特別要求 → 提醒等月底再做

## 執行步驟

### 1. 收集數據
讀取 `Health/00_Log/` 中該月所有 health logs。

### 2. 計算統計
- 體重趨勢（月初 vs 月底）
- 體脂趨勢
- 骨骼肌變化
- 血壓平均
- 步數達成率（達到 10,000 步的天數比例）
- 睡眠平均

### 3. 對比目標
讀取 `Goals/00_Active/` 中的健康目標，比較進度。

### 4. 分析模式與相關性
- 找出好的模式（例如：運動日隔天能量較高）
- 找出需要改善的地方

### 5. 產生建議
根據數據提供下個月的具體建議。

### 6. 儲存
儲存到 `Reviews/monthly-health-YYYY-MM.md`

## 檔案位置
- 資料來源：`Health/00_Log/*.md`
- 輸出：`Reviews/monthly-health-YYYY-MM.md`

## Skill 網絡
- 每日紀錄：`/health-log`（建立紀錄）
- 快速檢查：`/health-check`（近 7 天摘要）
- 深度分析：health-analyst agent
- 週報整合：`/weekly-review`（健康部分）
