# /whitepaper

分析加密貨幣白皮書，提取核心邏輯、第一性原理檢驗、代幣經濟學、機制設計，產出結構化研究筆記。

## 觸發條件
- 使用者說「whitepaper [TICKER]」「分析這份白皮書」
- 使用者丟白皮書 PDF 過來並要求分析

## 不要觸發
- 使用者只是想**聊**某個項目 → 直接對話，或用 narrative-analyst / contrarian-analyst
- 使用者想建立投資論述（含倉位、進出場）→ `/thesis`
- 使用者想摘要一般文章 → `/digest`
- 使用者想了解某個技術概念 → `/explain-concept`
- 來源不是白皮書/技術文件（例如是 blog post）→ `/digest`

## 與其他 Skill 的邊界

| | `/whitepaper` | `/digest` | `/thesis` |
|--|--|--|--|
| 輸入 | 白皮書/技術文件 | 任何外部文章 | 使用者的投資判斷 |
| 產出 | 結構化分析 | 摘要+論證拆解 | 投資論述+倉位管理 |
| 包含投資判斷 | 不做 | 不做 | 做 |
| 代幣經濟學分析 | 深度 | 不做 | 簡要 |
| Watchlist 整合 | 自動 | 不做 | 不做（已在 Positions） |

## 執行步驟

### 1. 取得白皮書

- PDF 檔案：用 `/opt/homebrew/bin/pdftotext {path} -` 轉文字，直接在主線程處理（不開 sub-agent）
- 如果使用者只給 ticker 沒給 PDF → 請使用者提供檔案

### 2. 檢查是否已存在

檢查 `Investing/03_Research/wp-{TICKER}.md` 是否已存在。
- 已存在 → 提醒使用者，問要更新還是重寫
- 不存在 → 繼續

### 3. 通讀全文，提取基本資訊

- 項目名稱、Ticker
- 所在鏈（Ethereum / Solana / Cosmos / 獨立鏈 / 多鏈）
- 類別（AI-agent / DeFi / Infra / Compute / Privacy / Stablecoin / Data / 其他）
- 白皮書版本（如果有標註）

### 4. 核心分析

#### 一句話
> {項目} 透過 {方法} 解決 {痛點}

#### 第一性原理檢驗
- **痛點真實嗎？** — 這個問題在沒有區塊鏈的世界裡有多大？有多少人/機構真的在痛？
- **解法最直接嗎？** — 有沒有更簡單的方式（不用代幣、不用鏈上）就能解決？
- **引入了什麼新問題？** — 去中心化帶來的代價（速度、UX、合規、協調成本）

#### 代幣經濟學
- **基本資訊**：總供給、流通量、通脹/通縮機制
- **代幣用途**：Gas / 治理 / 質押 / 支付 / 其他
- **價值捕獲**：協議收入怎麼流向代幣持有者？（回購銷毀 / 質押分潤 / 沒有）
- **必要性測試**：拿掉代幣，這個協議還能運作嗎？代幣是必要的還是強加的？
- **分配與解鎖**：團隊 / 投資人 / 社群 / 國庫的比例，解鎖時程
- **賣壓時間線**：接下來 6/12/24 個月的大額解鎖事件

#### 機制設計
- **激勵對齊**：各參與者（使用者、節點、開發者、代幣持有者）的激勵是否一致？
- **反身性風險**：代幣上漲→使用增加→代幣再漲的正循環，反過來崩潰的風險
- **護城河**：網絡效應 / 轉換成本 / 技術壁壘 / 有還是沒有

#### 紅旗掃描
逐項檢查：
- [ ] 代幣分配嚴重傾斜（團隊+投資人 > 50%）
- [ ] 無明確價值捕獲機制（代幣只有治理功能）
- [ ] 技術方案過度複雜或含糊（白皮書沒有具體技術細節）
- [ ] 解鎖時程過於集中（某個月大量釋放）
- [ ] 核心假設依賴外部不可控因素（法規、其他協議配合）

### 5. 跨主題連結

搜尋 Vault 中相關筆記：
- 同類別/同賽道的其他項目分析
- 相關的 Thinking/Digest 筆記
- 該項目在 AI 產業鏈中的位置（如適用）
- 以 wikilink 連結，並標明關聯性

### 6. Watchlist 整合

- 檢查 `Investing/01_Watchlist/` 是否已有該 ticker 的檔案
- **已有** → 在白皮書分析中加 wikilink 連結
- **沒有** → 自動建立 `Investing/01_Watchlist/watch-{TICKER}.md`，填入基本資訊

Watchlist 檔案最小模板：
```markdown
---
ticker: "{TICKER}"
type: watchlist
added: YYYY-MM-DD
status: watching
---

# {TICKER} Watchlist

## 基本資訊
- 類別：
- 所在鏈：

## 研究
- [[wp-{TICKER}]]

## 備註
-
```

### 7. 存檔

儲存到 `Investing/03_Research/wp-{TICKER}.md`
- TICKER 大寫
- 同一項目出新版白皮書時用 `wp-{TICKER}-v2.md` 區分
- 分析日期記在 frontmatter `date-analyzed`，不放檔名

## 模板

````markdown
---
ticker: "{TICKER}"
type: whitepaper-analysis
project: "{project_name}"
chain: ""
category: ""
date-analyzed: YYYY-MM-DD
whitepaper-version: ""
---

# {Project} 白皮書分析

## 一句話
> {項目} 透過 {方法} 解決 {痛點}

---

## 第一性原理檢驗

### 痛點真實嗎？
-

### 解法最直接嗎？
-

### 引入了什麼新問題？
-

---

## 代幣經濟學

### 基本資訊

| 項目 | 內容 |
|------|------|
| 總供給 | |
| 流通量 | |
| 通脹/通縮 | |

### 代幣用途
-

### 價值捕獲
-

### 必要性測試
> 拿掉代幣，這個協議還能運作嗎？

### 分配與解鎖

| 類別 | 比例 | 解鎖時程 |
|------|------|----------|
| 團隊 | | |
| 投資人 | | |
| 社群 | | |
| 國庫 | | |

### 賣壓時間線
-

---

## 機制設計

### 激勵對齊
-

### 反身性風險
-

### 護城河
-

---

## 紅旗掃描

- [ ] 代幣分配嚴重傾斜（團隊+投資人 > 50%）
- [ ] 無明確價值捕獲機制
- [ ] 技術方案過度複雜或含糊
- [ ] 解鎖時程過於集中
- [ ] 核心假設依賴外部不可控因素

---

## 跨主題連結
-

## Watchlist
- [[watch-{TICKER}]]

---

#whitepaper-analysis #investing
````

## 檔案位置
- 輸出：`Investing/03_Research/`
- Watchlist：`Investing/01_Watchlist/`
- 相關：`Investing/00_Positions/`（如果後續建 thesis）

## Skill 網絡
- 上游：使用者手動提供 PDF 或白皮書連結
- 下游：`/thesis`（從研究升級為投資論述）
- 並行：Watchlist 自動整合
- 分析支援：narrative-analyst agent（敘事週期）、contrarian-analyst agent（逆勢角度）、catalyst-mapper agent（事件影響）
- 知識連結：`/digest`（相關摘要）、knowledge-synthesizer agent（跨來源整合）
- 相關 MOC：[[moc-investing]]、[[moc-AI產業鏈]]、[[moc-技術]]

## 累積規則（自我改善迴路）

每次白皮書分析被使用者糾正或稱讚時，更新這個區塊。
執行 `/whitepaper` 時**必須**先讀這些規則。

### Don'ts（失敗教訓）
<!-- 格式：- [日期] 問題描述 → 應該怎麼做 -->

### Do's（成功公式）
<!-- 格式：- [日期] 什麼做對了 → 為什麼有效 -->
