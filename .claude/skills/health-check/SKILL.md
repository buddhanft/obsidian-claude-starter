# /health-check

顯示最近 7 天的健康數據摘要。只顯示，不建立檔案。

## 觸發條件
- 使用者說「health check」「看一下最近健康狀況」
- 使用者想快速看最近幾天的健康趨勢

## 不要觸發
- 使用者想建立今天的紀錄 → `/health-log`
- 使用者想看完整月報 → `/monthly-health-review`
- 使用者問營養/運動/biohack 問題 → health-analyst agent
- 使用者想看特定日期的詳細紀錄 → 直接讀該日 health log

## 執行步驟

### 1. 收集數據
讀取 `Health/00_Log/` 中最近 7 天的 health logs。

### 2. 解析 YAML frontmatter
取得各項數據欄位（見 `.claude/rules/health-log-format.md`）。

### 3. 顯示摘要表格
在對話中顯示：
- 體重趨勢
- 睡眠平均
- 能量平均（早/下午）
- 步數達成
- 運動次數

### 4. 標記異常
- 睡眠 < 6 小時
- 能量 < 5
- 體重突然變化 > 1kg

### 5. 觀察模式
簡短說明觀察到的模式（如：運動日隔天能量較高）。

## 輸出格式
直接在對話中顯示表格，**不建立新檔案**。

## 相關檔案
- 資料來源：`Health/00_Log/*.md`
- 欄位定義：`.claude/rules/health-log-format.md`

## Skill 網絡
- 建立紀錄：`/health-log`（開今天的紀錄）
- 月度報告：`/monthly-health-review`
- 深度分析：health-analyst agent
- 週報整合：`/weekly-review`（健康部分）
