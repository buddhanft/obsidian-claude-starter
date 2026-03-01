# CLAUDE.md

This file provides guidance to Claude Code when working with this Obsidian vault.

## 使用者身份

詳見 `.claude/me.md`——包含使用者的背景、價值觀、思維風格、目標、知識地圖、溝通偏好。
每次對話都應參考，特別是涉及建議、分析、挑戰論點時。

## Overview

Personal knowledge management vault（繁體中文），整合：
- 健康追蹤與認知表現分析
- 多來源資訊處理
- 目標管理
- 週/月回顧自動化
- 投資決策系統

## Vault Structure

```
Vault/
├── _Templates/          # 所有模板
├── 00_Inbox/            # 原始收集
├── 01_Digest/           # 處理過的摘要
├── 02_Thinking/         # 深度思考（使用者自己寫）
├── 03_Output/           # 最終產出
├── Health/
│   └── 00_Log/          # 每日健康紀錄
├── Goals/
│   └── 00_Active/       # 進行中的目標
├── Decisions/           # 決策紀錄（技術/健康/工作流/生活）
├── Reviews/             # 週報/月報
├── MOC/                 # 主題索引
└── Investing/
    ├── 00_Positions/    # 持倉論述
    ├── 01_Watchlist/    # 觀察名單
    ├── 02_Principles/   # 投資原則
    ├── 03_Research/     # 白皮書與項目研究
    └── 04_Retrospectives/ # 交易覆盤（虧損教訓）
```

## Available Commands

| Command | Description |
|---------|-------------|
| `/health-log` | 建立今天的健康紀錄 |
| `/health-check` | 顯示最近 7 天健康數據 |
| `/weekly-review` | 產生週回顧 |
| `/monthly-health-review` | 產生月度健康報告 |
| `/digest [filename]` | 為 Inbox 項目做摘要 |
| `/goal [topic]` | 建立新目標 |
| `/inbox-status` | 檢查 Inbox 狀態 |
| `/thesis [ticker]` | 建立投資論述 |
| `/whitepaper [ticker]` | 分析白皮書（代幣經濟學、機制設計、紅旗掃描） |
| `/prediction-review` | 掃描判斷紀錄，月度標記結果，季度產出校準報告 |
| `/decision` | 記錄重要決策（用 `_Templates/tpl-decision-log.md`，存到 `Decisions/`） |
| `/think` | 先釐清真實需求，對齊後再行動 |
| `/handoff` | 建立結構化交接文件，讓下一個 session 能接續 |
| `/explain-concept [概念]` | 八維概念解剖，壓縮為頓悟 |
| `/dashboard-update` | 讀取 Vault 數據，更新 Human 3.0 四象限 Dashboard |

詳細說明見 `.claude/skills/` 各資料夾。

## Modular Structure

```
.claude/
├── me.md                # 使用者身份檔案（價值觀、思維風格、目標）
├── agents/              # 專門角色
│   ├── health-analyst.md       # 健康分析師
│   ├── knowledge-synthesizer.md # 知識整合者
│   ├── narrative-analyst.md     # 敘事分析師
│   ├── contrarian-analyst.md    # 逆勢分析師
│   ├── catalyst-mapper.md       # 催化劑地圖師
│   ├── tech-tutor.md            # 技術導師
│   └── startup-coach.md         # 創業教練
├── skills/              # 各指令的詳細說明
│   ├── health-log/
│   ├── health-check/
│   ├── weekly-review/
│   ├── monthly-health-review/
│   ├── digest/
│   ├── goal/
│   ├── inbox-status/
│   ├── thesis/
│   ├── whitepaper/
│   └── twitter-capture/
└── rules/               # 規則與格式定義
    ├── naming-conventions.md   # 檔案命名規則
    ├── health-log-format.md    # Health log 欄位格式
    ├── tag-taxonomy.md         # 標籤分類
    └── thinking-policy.md      # Thinking 筆記政策
```

## Agents

使用者說「用 [agent 名稱]」或相關意圖時啟用。

| Agent | 用途 |
|-------|------|
| **health-analyst** | 分析健康數據、回答營養/運動/biohack 問題 |
| **knowledge-synthesizer** | 整合筆記、找出連結、建構知識框架 |
| **narrative-analyst** | 歷史模式比對、VC 框架挑戰、敘事週期分析 |
| **contrarian-analyst** | 挑戰市場共識、找資訊不對稱、逆勢切入角度 |
| **catalyst-mapper** | 事件→資產影響地圖：拆解因果鏈、跨資產掃描看漲/看跌 |
| **tech-tutor** | 教技術概念（區塊鏈、密碼學、AI、vibe coding） |
| **startup-coach** | 想法壓力測試、MVP 定義、執行追蹤、停損決策 |

詳細說明見 `.claude/agents/`。

## 三階段工作流（Research → Plan → Implement）

### 觸發條件
以下情況必須走三階段流程，不要跳步：
- 新建或大幅修改 Skill / Agent
- 修改或新建模板（tpl-*.md）
- Vault 結構性調整（搬資料夾、改命名規則、改 CLAUDE.md）
- 任何使用者明確說「走三階段」的任務

日常指令（/health-log、/digest、/weekly-review 等）不走此流程。

### Phase 1: Research
- 深度閱讀所有相關檔案，輸出 `_workflow/research.md`
- 內容包含：現有結構分析、依賴關係、相關的 skill/agent/模板、潛在風險
- 完成後停下來等使用者確認，不要自動進入下一階段
- 使用者說「research 通過」才能繼續

### Phase 2: Plan + 標註循環
- 根據 research 輸出 `_workflow/plan.md`
- 內容包含：具體實現方案、要修改的檔案路徑、代碼片段（如適用）、權衡取舍
- 明確標出「不能動的部分」（既有函數簽名、API 接口、模板欄位等硬約束）
- 使用者會直接在 plan.md 裡加批注（用 `<!-- ANNOTATION: ... -->` 格式）
- 當使用者說「請根據批注更新計畫」時，讀取 plan.md 裡所有 ANNOTATION 並修改計畫
- 標注循環可能重複多輪，直到使用者說「計畫通過」
- 計畫通過後，將實施步驟拆成細粒度 checklist 附在 plan.md 末尾

### Phase 3: Implement
- 只有使用者說「計畫通過，開始執行」後才能動手改檔案
- 按 checklist 逐項執行，每完成一項在 plan.md 裡勾選 `- [x]`
- 每完成一項簡短告訴使用者進度
- 如果執行中發現計畫有問題，立刻停下來告訴使用者，不要自作主張改方向
- 方向錯了使用者會說「revert」，此時立即撤銷所有變更回到執行前狀態

### 工作流檔案管理
- 所有工作流文件存放在 `_workflow/` 資料夾
- 每次新任務覆寫 research.md 和 plan.md
- `_workflow/` 不算 vault 正式內容，不需要遵守命名規則

## Key Rules

### 1. Thinking 筆記限制
`02_Thinking/` 是使用者自己思考的空間。Claude **不要代寫**思考內容。
詳見 `.claude/rules/thinking-policy.md`

### 2. 檔案命名
使用中文分類前綴（投資/效率/思維/技術/健康）。
詳見 `.claude/rules/naming-conventions.md`

### 3. Health Log 格式
睡眠用小數表示（7.5 = 7小時30分）。
詳見 `.claude/rules/health-log-format.md`

### 4. 技術決策一段話講完
涉及技術方案選擇時，用這個結構一次講完，不要讓使用者追問才補資訊：
- **你會得到什麼**：用結果描述，不用技術詞
- **差別在哪**：多個選項時，講體驗上的不同
- **花費差異**：有成本差就講，沒差就說沒差
- **我的建議**：選一個，講為什麼

### 5. 不確定時不要裝確定
有資料但不足以下結論時，用「看起來」或直接問，不要用肯定句。寧可多問一句，不要過度推論。

### 6. 被糾正 → 提議固化
被使用者糾正時，主動問「要不要把這條加到 skill file / CLAUDE.md？」讓修正變成永久規則，不只是當次對話的調整。

### 7. 連續修改不滿意 → 砍掉重來
同一個產出被要求修改超過 2 次且方向不收斂時，主動提議砍掉重寫而非繼續迭代。Context 污染後迭代只會越來越差。

### 8. 對話跨太多主題 → 建議 handoff
單次對話跨超過 3 個不相關主題時，主動建議做 `/handoff` 開新 session。校準價值被 context 衰退吃掉時就該切。

### 9. 重要決策 → 主動提議記錄
使用者提到做了或正在做重要決策（技術選型、工作流變更、健康策略調整等）時，主動問「要不要記錄到 Decisions/？」用 `_Templates/tpl-decision-log.md` 模板。投資決策仍用既有的 emotion-log → retrospective 流程。

### 10. 新增 Skill/Agent → 必須加網絡連結
建立新的 Skill 或 Agent 時，必須加 `## Skill 網絡` 或 `## Agent 網絡` section，標明上下游 skill、相關 agent、和 MOC wikilinks。同時更新被連結的既有 skill/agent 的網絡 section。

## Templates

所有模板在 `_Templates/`：
- `tpl-health-log.md` - 健康紀錄
- `tpl-digest.md` - 摘要
- `tpl-goal.md` - 目標
- `tpl-weekly-review.md` - 週報
- `tpl-decision-log.md` - 決策紀錄
- `tpl-position-thesis.md` - 投資論述

## Session 狀態

每次新對話開始時，自動讀取 `_workflow/now.md` 了解當前狀態。
此檔案由 `/handoff` 全量更新，也可手動編輯。
不需要翻閱歷史 handoff 檔案——NOW.md 永遠是最新狀態。

### NOW.md 即時同步規則

執行以下 skill 完成後，檢查 `_workflow/now.md` 是否需要更新對應 section：

| Skill 完成後 | 更新 NOW.md 的哪個 section |
|-------------|--------------------------|
| `/decision` | 「最近決策」加一條 |
| `/digest` | 「提醒」更新待處理數量（如果變化大） |
| `/goal`（完成里程碑） | 「進行中」更新對應項目進度 |
| `/thesis` | 「最近決策」或「進行中」加一條 |
| 完成任何多步驟任務 | 「進行中」更新狀態 |

更新時只改對應 section，不要重寫整份。更新 frontmatter `last_updated` 和 `updated_by: {skill名稱}`。
如果 `_workflow/now.md` 不存在，不要建立——等使用者做第一次 `/handoff` 時再建。

## Date Awareness
建立或編輯每日紀錄前，務必先用 `date` 指令確認今天的日期。絕不從最近的檔案推測當前日期。

## Health & Nutrition
- 營養建議依照使用者 `me.md` 中的健康框架
- 補充品劑量務必澄清單位（mg vs mcg）和具體形式

## Content Preferences
- Digest/摘要預設為實用指南，不是技術摘要
- Agent/Skill 不限制知識只用 Vault 內容，充分運用模型知識
