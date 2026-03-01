# /thesis

建立投資標的的 Position Thesis，結構化記錄看漲論點、疑慮、決策。

## 觸發條件
- 使用者說「thesis [TICKER]」「建立 XX 的投資論述」
- 使用者明確要為某個標的建檔

## 不要觸發
- 使用者只是在**聊**某個幣或資產 → 直接對話，或用 narrative-analyst / contrarian-analyst
- 使用者想分析市場事件的影響 → catalyst-mapper agent
- 使用者想找歷史類比 → narrative-analyst agent
- 該 ticker 已有 thesis → 提醒使用者已存在，問要更新還是重寫
- 使用者還在研究階段，沒有要建倉 → 先用 agent 分析，等決定建倉再建 thesis

## 執行步驟

### 1. 確認標的
如果使用者沒有指定 ticker，詢問要分析哪個標的。

### 2. 檢查是否已存在
檢查 `Investing/00_Positions/thesis-{TICKER}.md` 是否存在。

### 3. 建立 Thesis 檔案
使用下方模板，填入 ticker 和初始狀態。

### 4. 儲存
儲存到 `Investing/00_Positions/thesis-{TICKER}.md`

## 模板

````markdown
---
ticker: "{{ticker}}"
type: position-thesis
position_type: core / watchlist / exited
current_allocation:
last_updated: "{{date}}"
conviction: /10
---

# {{ticker}} 投資論點

## 基本資訊

| 項目 | 內容 |
|------|------|
| 類型 | 主力持倉 / 觀察中 |
| 目前倉位 | % |
| 信心程度 | /10 |

---

## 看漲論點

### 核心邏輯
> 用一句話說明為什麼看好

### 詳細論點
1.
2.
3.

### 關鍵假設
- [ ] 假設 1（若失效則需重新評估）
- [ ] 假設 2

---

## 我的疑慮

| 疑慮 | 狀態 | 備註 |
|------|------|------|
| | 未解決 / 已釐清 / 接受風險 | |

---

## FUD 與應對紀錄

| 日期 | FUD 內容 | 來源 | 我的判斷 | 後續驗證 |
|------|----------|------|----------|----------|
| | | | | |

---

## 決策紀錄

| 日期 | 行動 | 原因 | 當時價格 |
|------|------|------|----------|
| | | | |

---

## 相關連結
-
````

## 檔案位置
- 輸出：`Investing/00_Positions/`
- 相關：`Investing/02_Principles/`、`Investing/04_Retrospectives/`

## Skill 網絡
- 上游：`/whitepaper`（白皮書研究 → 升級為投資論述）
- 分析支援：narrative-analyst agent（歷史模式比對）、contrarian-analyst agent（逆勢角度）、catalyst-mapper agent（事件影響地圖）
- 知識來源：`/digest`（相關摘要）、`/whitepaper`（項目研究）、knowledge-synthesizer agent（跨來源整合）
- 進度追蹤：`/weekly-review`（投資部分）
- 相關 MOC：[[moc-investing]]

## 累積規則（自我改善迴路）

### Don'ts（失敗教訓）
<!-- 格式：- [日期] 問題描述 → 應該怎麼做 -->

### Do's（成功公式）
<!-- 格式：- [日期] 什麼做對了 → 為什麼有效 -->
