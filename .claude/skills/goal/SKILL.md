# /goal

建立新的目標，含成功定義、里程碑、衡量指標。

## 觸發條件
- 使用者說「goal [主題]」「建立目標」
- 使用者明確要建立一個可追蹤的目標

## 不要觸發
- 使用者只是在聊想做什麼 → 直接對話，或用 startup-coach 做壓力測試
- 使用者想檢查現有目標進度 → `/weekly-review` 或直接讀目標檔案
- 目標已存在 → 提醒使用者已有，問要更新還是建新的

## 執行步驟

### 1. 確認目標主題
如果使用者沒有指定，詢問目標主題。

### 2. 檢查是否已存在
檢查 `Goals/00_Active/` 是否已有類似目標。

### 3. 建立目標檔案
使用下方模板，儲存到 `Goals/00_Active/goal-YYYY-{topic}.md`

## 模板

````markdown
---
type: goal
category: learning / health / career / personal
date-created: {{date}}
target-date:
status: active
priority: high / medium / low
---

# Goal: {{title}}

## 為什麼這個目標重要？


## 成功的定義


## 可衡量指標
- Metric 1:
- Metric 2:

## 里程碑
- [ ] Milestone 1 - Due:
- [ ] Milestone 2 - Due:
- [ ] Milestone 3 - Due:

## 相關資源
- [[]]

## Progress Log
### {{date}}
- Progress:
- Blockers:
- Next Steps:

## 與健康的關聯
- Required energy level:
- Best time to work on this:
- Health habits that support this:

#goal #{{category}} #active
````

## 檔案位置
- 輸出：`Goals/00_Active/`

## 目標進度追蹤
- `[ ]` = 未完成、`[x]` = 已完成
- 進度計算：已完成 / 總里程碑數

## Skill 網絡
- 進度追蹤：`/weekly-review`（目標進度部分）
- 壓力測試：startup-coach agent（想法驗證）
- 健康目標：`/health-log`（同步數據）、health-analyst agent（分析建議）
- 相關 MOC：[[moc-learning]]
