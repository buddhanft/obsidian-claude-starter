# Health Log 格式

## YAML Frontmatter 欄位

```yaml
date: YYYY-MM-DD
type: health-log

# === 自動填入（如有健康數據同步管線）===
weight: {number}              # kg
skeletal_muscle: {number}     # kg
body_fat: {number}            # %
bp_systolic: {number}         # mmHg
bp_diastolic: {number}        # mmHg
rhr: {number}                 # bpm
sleep_duration: {number}      # 小時（core + rem + deep）
sleep_core: {number}          # 小時
sleep_rem: {number}           # 小時
sleep_deep: {number}          # 小時
steps: {number}               # 步數
hrv: {number}                 # ms SDNN（日平均）
blood_oxygen: {number}        # %
vo2_max: {number}             # mL/kg/min
respiratory_rate: {number}    # breaths/min
active_calories: {number}     # kcal
exercise_minutes: {number}    # 分鐘
stand_hours: {number}         # 小時 — Apple Watch
distance_km: {number}         # km — iPhone/Watch

# === 手動填入 ===
overall_feeling: {number}     # 1-10（整體感受，取代原本的 focus/mood/energy）
exercise: {text}              # 運動內容描述
deep_work: {number}           # 小時
waist: {number}               # cm（手動量測時填）
standard_breakfast: {boolean}  # true/false — 今天有沒有吃標準早餐（三層腸道堆疊優格碗）
psyllium: {boolean}           # true/false — 今天有沒有喝車前子粉
protein: {number}             # g — 每日蛋白質攝取估算
fat: {number}                 # g — 每日脂肪攝取估算
carbs: {number}               # g — 每日碳水攝取估算
calories: {number}            # kcal — 每日總熱量估算
```

### 已淘汰欄位（向後兼容，舊 log 保留）
- `sleep_quality` → 被 sleep_core/rem/deep 取代
- `morning_energy` → 合併為 overall_feeling
- `afternoon_energy` → 合併為 overall_feeling
- `focus` → 合併為 overall_feeling
- `mood` → 合併為 overall_feeling

## 睡眠時長格式

使用小數點表示：
- 7 小時 = `7`
- 7 小時 30 分 = `7.5`
- 7 小時 27 分 = `7.45`（27÷60 = 0.45）

## Food 區塊格式

按餐記錄實際吃了什麼，分早餐/午餐/晚餐/點心。

```markdown
**早餐**
- 三顆蛋、酪梨吐司、黑咖啡

**午餐**
- 雞腿便當、味噌湯、燙青菜

**晚餐**
- 烤魚、糙米飯、炒菇類、沙拉

**點心/飲料**
- 希臘優格、堅果
```

## 數據來源

| 來源 | 數據 | 同步方式 |
|------|------|----------|
| 體重計/體脂計 | weight, body_fat, skeletal_muscle | 依你的設備設定 |
| 血壓計 | bp_systolic, bp_diastolic | 依你的設備設定 |
| 智慧手錶 | rhr, hrv, blood_oxygen, vo2_max, respiratory_rate, active_calories, exercise_minutes, stand_hours, steps, distance_km | 依你的設備設定 |
| 睡眠追蹤 | sleep_duration, sleep_core, sleep_rem, sleep_deep | 依你的設備設定 |
| 手動 | overall_feeling, exercise, deep_work, waist, Food | 使用者自己填 |

## 健康-表現相關性

追蹤這些關係：
1. **睡眠 → 表現**：sleep_duration + 睡眠階段品質對隔天 overall_feeling 的影響
2. **運動 → 恢復**：exercise_minutes + HRV 變化
3. **飲食 → 整體感受**：飲食品質對 overall_feeling 的影響
4. **整體健康 → 知識產出**：健康狀態 vs Digest/Thinking 產出
