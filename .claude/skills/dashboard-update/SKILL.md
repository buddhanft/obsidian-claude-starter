# /dashboard-update

讀取 Vault 數據與問卷自評，更新 `dashboard-status.json`。

## 觸發條件
- 使用者說「更新 dashboard」「dashboard update」「更新面板」
- 使用者做完 weekly review 後想刷新數據

## 不要觸發
- 使用者只想看健康數據 → `/health-check`
- 使用者想改 dashboard UI → 直接改 `dashboard.html`
- 使用者想看 inbox 數量 → `/inbox-status`

## 執行步驟

### 1. 確認日期
用 `date` 指令取得今天日期，不要從檔案名推測。

### 2. 收集行為數據（參考用，不用於計分）

以下數據用於 alerts、achievements、trends、breakdown 顯示，**不決定象限分數**。

#### 身體數據
讀取 `Health/00_Log/` 最近 7 天的 health logs，解析 YAML frontmatter：
- `sleepAvg`、`energyAvg`、`exerciseDays`、`weightTrend`、`stepsAvg`

#### 心智數據
- `digestVelocity`：`01_Digest/` 最近 30 天新增數量
- `thinkingCount`：`02_Thinking/` 最近 30 天新增數量

#### 志業數據
- `deepWorkAvg`、`goalProgress`、`decisionsThisMonth`、`outputsThisMonth`

### 3. 讀取問卷評估結果（四象限分數來源）

讀取 `h3-assessment.json`（vault 根目錄）。此檔案由問卷分析產出，包含結構化的四象限定位。

若檔案存在，每個象限直接取用：
- `score`（0-100）
- `level`（1.0-3.0）
- `phase`（Dissonance / Uncertainty / Discovery）
- `phaseLabel`（不協調期 / 不確定期 / 發現期）
- `archetype`
- `keyInsight`

若檔案不存在或某象限為 null，該象限 `score` 設為 null。

### 4. 計算 Human Level

直接從 `h3-assessment.json` 的 `overall` 區塊取用：
- `human.level` = `overall.humanLevel`
- `human.phase` = `overall.humanPhase`
- `human.levelLabel` = `overall.humanLevelLabel`

若 `h3-assessment.json` 不存在，全部設為 null。

### 5. 收集任務（Quests）
讀取 `Goals/00_Active/` 所有 status: active 的 goal 檔案：
- `id`：檔名（不含 .md）
- `name`：取 H1 標題
- `description`：取「成功的定義」第一句，或「為什麼這個目標重要」第一句
- `icon`：根據 category 判斷（health=🏋️, personal=🎮, investing=📈, 其他=🎯）
- `progress`：已勾選里程碑 / 總里程碑數量
- `progressLabel`：用人看得懂的描述

### 6. 收集背包（Inventory）
- `inbox`：`00_Inbox/` 檔案數
- `digests`：`01_Digest/` 檔案數
- `thinking`：`02_Thinking/` 檔案數
- `decisions`：`Decisions/` 檔案數
- `positions`：`Investing/00_Positions/` 檔案數
- `reviews`：`Reviews/` 中 `weekly-*.md` 檔案數

### 7. 收集今日狀態（Today）
讀取今天的 health log（`Health/00_Log/YYYY-MM-DD-health-log.md`）：
- 若存在：填入 sleep_duration, morning_energy, focus, mood
- 若不存在：`hasHealthLog: false`，其他欄位 null

### 8. 活動紀錄（Activity）
取最近 3 天的 vault 變動：
- 用 `git log --since="3 days ago" --name-only --pretty=format:"%ai"` 找出最近變動的檔案
- 每個變動轉成一條 activity：
  - 新增 Digest → `📜 完成 digest — {標題}`
  - 新增 Health Log → `💊 Health log 已記錄`
  - 新增 Goal → `🎯 建立目標 — {名稱}`
  - 新增 Decision → `📋 記錄決策 — {名稱}`
  - 新增 Inbox → `📥 {數量} 篇新內容進入 Inbox`
- 最多保留 5 條

### 9. 計算警告（Compute Alerts）

建立 `alerts` 陣列，根據以下規則檢測：

| ID | 條件 | 嚴重度 | 標題 | icon | source |
|----|------|--------|------|------|--------|
| `sleep-low` | 最近一筆 sleep_duration < 6h | red | Recovery Risk | 😴 | body |
| `muscle-loss` | skeletal_muscle < 37 kg | red | Muscle Loss Alert | 💪 | body |
| `bp-high` | bp_systolic > 130 | red | High BP Warning | 🫀 | body |
| `weight-spike` | 最近 3 筆體重增加 > 1kg | yellow | Check Intake | ⚖️ | body |
| `bodyfat-plateau` | 體脂 2 週內變化 < 0.3% | yellow | Plateau Detected | 📊 | body |
| `inbox-backlog` | inbox > 80 | yellow | Backlog Growing | 📥 | mind |
| `missing-data` | 3+ 天沒有 health log | yellow | Missing Data | 📝 | system |
| `goal-stall` | goal 進度 2 週無變化 | yellow | No Progress | 🎯 | vocation |

每條 alert 結構：
```json
{
  "id": "sleep-low",
  "severity": "red",
  "icon": "😴",
  "title": "Recovery Risk",
  "message": "昨日睡眠僅 5.7 小時",
  "action": "今晚目標 7.5+ 小時",
  "source": "body"
}
```

- `message`：描述觸發原因（含具體數值）
- `action`：建議的改善行動
- 零警告時輸出單條：`{ "id": "all-clear", "severity": "green", "icon": "✅", "title": "All Clear", "message": "所有指標正常", "action": null, "source": "system" }`

### 10. 檢查成就（Check Achievements）

> 持久化策略：先讀取既有 `dashboard-status.json` 的 `achievements` 陣列，保留已解鎖的，只新增新解鎖的，最後整份覆寫。

遍歷以下成就清單，檢測是否符合解鎖條件：

#### 健康里程碑

| ID | 名稱 | 條件 | 稀有度 |
|----|------|------|--------|
| `bodyfat-sub30` | 破三 | 任一筆 body_fat < 30% | uncommon |
| `bodyfat-sub27` | 精實之路 | 任一筆 body_fat < 27% | rare |
| `bodyfat-sub24` | 鍛鍊體態 | 任一筆 body_fat < 24% | rare |
| `bodyfat-sub21` | 戰士之軀 | 任一筆 body_fat < 21% | legendary |
| `bodyfat-18` | 極致雕塑 | 任一筆 body_fat ≤ 18% | legendary |
<!-- 體重成就：根據使用者的目標體重自訂門檻 -->
<!-- 範例：
| `weight-milestone-1` | 初步減重 | 任一筆 weight < X kg | common |
| `weight-milestone-2` | 中期達標 | 任一筆 weight < Y kg | uncommon |
| `weight-target` | 目標達成 | 任一筆 weight ≤ Z kg | legendary |
-->
| `bp-normalized` | 血壓正常 | 任一筆 bp_systolic < 120 且 bp_diastolic < 80 | uncommon |
| `steps-15k` | 暴走達人 | 任一筆 steps > 15000 | uncommon |

#### 連續打卡

| ID | 名稱 | 條件 | 稀有度 |
|----|------|------|--------|
| `healthlog-streak-7` | 堅持一週 | 連續 7 天有 health log | common |
| `healthlog-streak-30` | 月度紀律 | 連續 30 天有 health log | rare |
| `sleep-streak-7` | 好眠七日 | 連續 7 天 sleep_duration ≥ 7h | uncommon |
| `steps-streak-7` | 行者七日 | 連續 7 天 steps ≥ 10000 | uncommon |

#### 知識產出

| ID | 名稱 | 條件 | 稀有度 |
|----|------|------|--------|
| `digest-10` | 知識拾荒者 | `01_Digest/` 有 10+ 篇 | common |
| `digest-25` | 知識獵人 | `01_Digest/` 有 25+ 篇 | uncommon |
| `digest-50` | 知識大師 | `01_Digest/` 有 50+ 篇 | rare |
| `thinking-5` | 深度思考者 | `02_Thinking/` 有 5+ 篇 | common |
| `decision-first` | 首次抉擇 | `Decisions/` 有 1+ 篇 | common |
| `output-10` | 產出者 | `03_Output/` 有 10+ 篇 | uncommon |

#### 系統成就

| ID | 名稱 | 條件 | 稀有度 |
|----|------|------|--------|
| `dashboard-m1m4` | 框架建立 | Dashboard M1-M4 完成（`dashboard.html` 存在且 JSON version ≥ 0.2） | common |
| `dashboard-complete` | 系統完成 | Dashboard 全里程碑完成（JSON version ≥ 1.0） | rare |

每條成就結構：
```json
{
  "id": "bodyfat-sub30",
  "name": "破三",
  "description": "體脂率首次降到 30% 以下",
  "icon": "🔥",
  "category": "health",
  "unlockedAt": "2026-01-15",
  "rarity": "uncommon"
}
```

- `unlockedAt`：首次達成的日期（從 health log 日期判斷，或 `today` 日期）
- 已在既有 JSON 中解鎖的成就保留不變（不更新 `unlockedAt`）
- 未解鎖的不輸出到 `achievements` 陣列

### 11. 收集趨勢數據（Collect Trend Data）

讀取 `Health/00_Log/` 所有 health log，提取以下欄位：
- `date`、`weight`、`bodyFat`（body_fat）、`skeletalMuscle`（skeletal_muscle）
- `sleepDuration`（sleep_duration）、`steps`
- `bpSystolic`（bp_systolic）、`bpDiastolic`（bp_diastolic）
- `hrv`、`bloodOxygen`（blood_oxygen）、`vo2Max`（vo2_max）
- `sleepCore`（sleep_core）、`sleepDeep`（sleep_deep）、`sleepRem`（sleep_rem）

按日期排序，保留最近 **90 天**的資料點。

輸出 `trends` 物件：
```json
{
  "trends": {
    "dataPoints": [
      { "date": "2026-01-09", "weight": 99, "bodyFat": null, "skeletalMuscle": null, "sleepDuration": 7, "steps": 10721, "bpSystolic": 106, "bpDiastolic": 72, "hrv": 45, "sleepCore": 4.2, "sleepDeep": 1.1, "sleepRem": 1.5, "bloodOxygen": 97, "vo2Max": 35.2 }
    ],
    "period": "90d",
    "summary": {
      "weightMin": 96.8,
      "weightMax": 99.3,
      "weightDelta": -2.2,
      "sleepAvg": 7.1,
      "stepsAvg": 10500
    }
  }
}
```

- `summary.weightDelta`：最新 weight - 最早 weight（負=減重）
- 缺少某欄位的日期，該欄位填 `null`

### 12. 產生行動建議（Generate Recommendations）

從 `h3-assessment.json` 推導 3-4 條具體行動建議。

**來源對應：**

| 來源欄位 | 建議類型 | 優先級 |
|----------|---------|--------|
| `overall.keyConstraint` | 核心瓶頸突破 | high |
| 最低分象限的 `keyInsight` | 弱項提升 | high |
| `overall.negativeChain` | 負面迴圈警覺 | medium |
| `overall.positiveChain` | 正向槓桿加速 | medium |

**產出規則：**
- 每條建議必須是**具體可執行的行動**，不是抽象描述
- `action` 欄位用「本週做 X」或「每天做 Y」的格式
- `quadrant` 對應建議關聯的象限（用於顯示顏色）
- 若 `h3-assessment.json` 不存在，`recommendations` 設為空陣列

每條建議結構：
```json
{
  "quadrant": "mind",
  "priority": "high",
  "title": "突破知行分裂",
  "action": "本週寫一篇 thinking 筆記，把最近一篇 digest 的概念用自己的話重述",
  "source": "keyConstraint"
}
```

最多 4 條，按 priority 排序（high 在前）。

### 13. 寫入 JSON
將所有數據寫入 `dashboard-status.json`（覆寫），包含：
- 問卷自評的四象限分數與 level
- 行為數據（breakdown，參考用）
- `alerts`、`achievements`、`trends`、`recommendations`
- quests、inventory、today、activity

### 14. 回報結果
在對話中顯示摘要：
```
Dashboard 已更新 ✓
Human 2.2（個體者・不確定期）← 來自問卷自評

  心智 60 ████████░░ 2.2
  身體 50 ███████░░░ 2.1
  靈性 --（待自評）
  志業 70 █████████░ 3.2

⚠️ 警告 2 條（1 red, 1 yellow）
🏆 新解鎖成就：破三、知識拾荒者
```

若問卷尚未建立，四象限分數顯示「待自評」，其餘區塊（alerts、achievements、trends、quests、inventory）正常更新。

## 輸出檔案
- `dashboard-status.json`（vault 根目錄）

## Skill 網絡
- 數據來源：`/health-log`（身體數據）、`/health-check`（快速健康檢視）
- 數據來源：`/digest`（心智產出）、`/inbox-status`（背包數量）
- 數據來源：`/goal`（任務進度）、`/weekly-review`（自評分數）
- 消費端：`dashboard.html`（讀取 JSON 渲染）
- 相關 MOC：各象限對應 MOC
