# /health-log

建立今天的健康紀錄。

## 觸發條件
- 使用者說「開今天的 health log」「/health-log」
- 使用者明確要建立健康紀錄

## 不要觸發
- 使用者問健康/營養/運動問題 → 用 health-analyst agent
- 使用者想看最近數據 → `/health-check`
- 使用者想看月報 → `/monthly-health-review`
- 今天的 log 已存在 → 直接開啟編輯，不要重建

## 執行步驟

### 1. 確認日期
用 `date` 指令確認今天日期，不要從檔案推測。

### 2. 檢查是否已存在
檢查 `Health/00_Log/YYYY-MM-DD-health-log.md` 是否存在。
- 已存在 → 告知使用者，問要不要編輯
- 不存在 → 繼續建立

### 3. 建立檔案
用下方模板，將 `{{date}}` 替換為今天日期。
儲存到 `Health/00_Log/YYYY-MM-DD-health-log.md`

建立時自動填入 `goals` 欄位：掃描 `Goals/00_Active/` 中 frontmatter 含 `category: health` 且 `status: active` 的目標，以 wikilink 格式填入。

### 4. 使用者填完數據後同步目標
當使用者更新了 health log 的數據：
1. 搜尋 `Goals/00_Active/` 中 frontmatter 含 `category: health` 的目標檔案
2. 從 health log 的 frontmatter 取得相關數據（weight、body_fat 等）
3. 更新目標檔案中對應的 current 欄位
4. 檢查是否有里程碑應該標記完成

## 自動 vs 手動欄位

Health log 的欄位分兩類：

### 自動填入（如有健康數據同步管線）
以下欄位可由自動化腳本填入，也可手動輸入：
- `weight`、`skeletal_muscle`、`body_fat` — 體重計/體脂計
- `bp_systolic`、`bp_diastolic` — 血壓計
- `rhr`、`hrv`、`blood_oxygen`、`vo2_max`、`respiratory_rate` — 智慧手錶
- `active_calories`、`exercise_minutes`、`stand_hours`、`distance_km`、`steps` — 智慧手錶/手機
- `sleep_duration`、`sleep_core`、`sleep_rem`、`sleep_deep` — 睡眠追蹤 App

### 手動填入
使用者自己填的欄位：
- `overall_feeling`（1-10，整體感受）
- `exercise`（運動內容描述）
- `deep_work`（小時）
- `waist`（cm，有量測時才填）
- Food 區塊（早餐/午餐/晚餐/點心）

### 已淘汰欄位
以下欄位已不使用，舊 log 保留但新 log 不再建立：
- `sleep_quality` → 被 sleep_core/rem/deep 取代
- `morning_energy`、`afternoon_energy`、`focus`、`mood` → 合併為 `overall_feeling`

## 行為規則：log 已存在時

如果今天的 health log 已經存在：
1. **不要重建檔案**
2. 告知使用者「今天的 log 已存在」
3. 問使用者要不要填手動欄位（overall_feeling、exercise、deep_work、Food）
4. 只更新手動欄位，不動自動欄位

## 模板

````markdown
---
date: "{{date}}"
type: health-log
# --- 自動填入（如有自動同步管線） ---
weight:
skeletal_muscle:
body_fat:
bp_systolic:
bp_diastolic:
rhr:
sleep_duration:
sleep_core:
sleep_rem:
sleep_deep:
steps:
hrv:
blood_oxygen:
vo2_max:
respiratory_rate:
active_calories:
exercise_minutes:
stand_hours:
distance_km:
# --- 手動填入 ---
overall_feeling:
exercise:
deep_work:
waist:
goals:
  # - "[[your-active-health-goal]]"
---

# Health Log {{date}}

## Food

**早餐**
-

**午餐**
-

**晚餐**
-

**點心/飲料**
-

## Notes


#health
````

## 標準餐

使用者說「早餐照舊」「標準早餐」或確認是標準餐時，直接填入預設內容，不需要使用者重打。

<!-- 在這裡定義你的標準餐內容。範例：
### 標準早餐（~XXX kcal｜P:Xg F:Xg C:Xg）
```
- 項目 1
- 項目 2
- ...
```
-->

> 如果使用者說有調整，以使用者說的為準，標準餐只是預設值。

## 檔案位置
- 輸出：`Health/00_Log/YYYY-MM-DD-health-log.md`

## Skill 網絡
- 查看趨勢：`/health-check`（近 7 天摘要）
- 月度報告：`/monthly-health-review`
- 深度分析：health-analyst agent
- 進度追蹤：`/weekly-review`（健康部分）、`/goal`（健康目標同步）
