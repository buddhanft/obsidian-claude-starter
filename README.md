# Obsidian + Claude Code 個人知識管理系統

一套整合 Obsidian 和 Claude Code 的個人知識管理系統。

**包含：**
- 結構化的知識處理流程（收集 → 消化 → 思考 → 產出）
- 7 個 AI 角色（Agent）——健康分析、知識整合、投資分析、技術教學、創業教練
- 18 個自動化指令（Skill）——健康追蹤、知識摘要、投資決策、目標管理
- 完整的模板系統（18 個模板）
- 預設的關聯設計（Agent ↔ Skill ↔ MOC 網絡）

---

## 快速開始

### 1. 複製到你的 Vault 位置

```bash
cp -r _starter-kit/ ~/my-vault/
cd ~/my-vault/
```

### 2. 建立資料夾結構

```bash
bash setup.sh
```

### 3. 用 Obsidian 開啟

開啟 Obsidian → Open folder as vault → 選擇你的 vault 目錄

### 4. 個人化

編輯 `.claude/me.md`，填入你的個人資訊。這是整個系統的靈魂——填得越完整，AI 越能理解你。

### 5. 開始使用

在 vault 目錄執行 `claude`，試試：
- `/digest` — 為一篇文章做結構化摘要
- `/health-log` — 建立今天的健康紀錄
- `/inbox-status` — 看看你的待處理清單

---

## 系統架構

### 知識處理流程

```
外部來源 → 00_Inbox/（收集）
              ↓ /digest
         01_Digest/（消化）
              ↓ 自己思考
         02_Thinking/（思考）← AI 不代寫
              ↓ 自己寫
         03_Output/（產出）← AI 不代寫
```

### 五大分類

所有內容按五大分類組織，對應命名前綴和 MOC：

| 分類 | 前綴 | MOC | 涵蓋 |
|------|------|-----|------|
| 投資 | 投資- | `moc-investing` | crypto, 經濟, 市場分析 |
| 技術 | 技術- | `moc-技術` | 程式, 工具, AI |
| 思維 | 思維- | `moc-思維` | 哲學, 心理, 決策框架 |
| 效率 | 效率- | `moc-效率` | 工具, 方法, 時間管理 |
| 健康 | 健康- | `moc-健康` | 營養, 運動, biohacking |

---

## 指令一覽

### 核心（知識管理）

| 指令 | 說明 |
|------|------|
| `/digest [filename]` | 為 Inbox 項目做結構化摘要 |
| `/inbox-status` | 檢查 Inbox 狀態與積壓 |
| `/think` | 先釐清真實需求，對齊後再行動 |
| `/handoff` | 建立交接文件，讓下一個 session 接續 |
| `/explain-concept [概念]` | 八維概念解剖 |
| `/decision` | 記錄重要決策 |

### 健康追蹤

| 指令 | 說明 |
|------|------|
| `/health-log` | 建立今天的健康紀錄 |
| `/health-check` | 顯示最近 7 天數據 |
| `/weekly-review` | 週回顧（含健康、知識、目標） |
| `/monthly-health-review` | 月度健康報告 |

### 投資系統

| 指令 | 說明 |
|------|------|
| `/thesis [ticker]` | 建立投資論述 |
| `/whitepaper [ticker]` | 分析白皮書 |
| `/prediction-review` | 預測準確度校準 |

### 其他

| 指令 | 說明 |
|------|------|
| `/goal [topic]` | 建立可追蹤目標 |
| `/dashboard-update` | 更新四象限面板 |

---

## Agent 角色

| Agent | 用途 | 啟動方式 |
|-------|------|---------|
| health-analyst | 健康數據分析、營養/運動建議 | 「用 health-analyst」 |
| knowledge-synthesizer | 跨來源知識整合、找連結 | 「用 knowledge-synthesizer」 |
| narrative-analyst | 歷史模式比對、VC 框架挑戰 | 「用 narrative-analyst」 |
| contrarian-analyst | 挑戰市場共識、找 edge | 「用 contrarian-analyst」 |
| catalyst-mapper | 事件→資產影響地圖 | 「用 catalyst-mapper」 |
| tech-tutor | 技術概念教學 | 「用 tech-tutor」 |
| startup-coach | 想法壓力測試、MVP 定義 | 「用 startup-coach」 |

---

## 關聯設計

系統的元件不是散落的，而是有預設連線的網絡：

```
Agent ←→ Skill ←→ Template ←→ 輸出路徑
  ↕                                ↕
 MOC ←————————————————————————→ 分類前綴
```

### Agent → Skill

| Agent | 關聯的 Skill |
|-------|-------------|
| health-analyst | `/health-log`, `/health-check`, `/monthly-health-review` |
| knowledge-synthesizer | `/digest`, `/inbox-status`, `/explain-concept` |
| narrative-analyst | `/thesis`, `/prediction-review` |
| contrarian-analyst | `/thesis`, `/prediction-review` |
| catalyst-mapper | `/thesis` |
| tech-tutor | `/explain-concept` |
| startup-coach | `/goal`, `/decision` |

### Skill → 輸出路徑

| Skill | 輸出到 |
|-------|-------|
| `/health-log` | `Health/00_Log/` |
| `/digest` | `01_Digest/` |
| `/thesis` | `Investing/00_Positions/` |
| `/decision` | `Decisions/` |
| `/goal` | `Goals/00_Active/` |
| `/weekly-review` | `Reviews/` |

---

## 個人化指南

### 必填：me.md

`.claude/me.md` 決定了 AI 怎麼理解你。建議填寫：
- 核心身份和價值觀
- 思維風格和認知弱點
- 目標和方向
- 知識地圖
- 你希望 AI 怎麼跟你互動

### 可調整

| 檔案 | 調整什麼 |
|------|---------|
| `_Templates/tpl-health-log.md` | 你的標準餐食、追蹤指標 |
| `.claude/rules/health-log-format.md` | 健康追蹤的數據來源 |
| `.claude/rules/naming-conventions.md` | 分類前綴（如果你的領域不同） |
| `.claude/rules/tag-taxonomy.md` | 標籤系統 |
| `.claude/skills/health-log/SKILL.md` | 標準餐定義 |

### 可刪除

不需要投資系統？刪除：
- `.claude/agents/narrative-analyst.md`
- `.claude/agents/contrarian-analyst.md`
- `.claude/agents/catalyst-mapper.md`
- `.claude/skills/thesis/`、`whitepaper/`、`prediction-review/`
- `Investing/` 整個資料夾
- `MOC/moc-investing.md`
- CLAUDE.md 中對應的指令和 agent 條目

---

## 三階段工作流

對系統本身做結構性修改時（新增 Skill、改模板等），使用 Research → Plan → Implement 三階段流程：

1. **Research** — 盤點相關檔案，輸出到 `_workflow/research.md`
2. **Plan** — 設計方案，輸出到 `_workflow/plan.md`，使用者可加批注
3. **Implement** — 使用者說「計畫通過」後才執行

日常使用（`/digest`、`/health-log` 等）不需要走這個流程。

---

## 前置需求

- [Obsidian](https://obsidian.md/)
- [Claude Code](https://docs.anthropic.com/en/docs/claude-code)（需要 Anthropic API key）

---

## 授權

MIT License
