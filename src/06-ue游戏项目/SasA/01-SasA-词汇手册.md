# UE 词汇手册

> 记录在 UE 开发过程中遇到的英文术语。按模块分类，持续更新。
> 格式：`英文术语` — 中文释义 + 简短说明

---

## 角色蓝图 (Character Blueprint)

### 组件 (Components)

| 英文 | 中文 | 说明 |
|------|------|------|
| `Capsule Component` | 胶囊体组件 | 角色的碰撞形状，用于检测碰撞，默认为椭圆胶囊 |
| `Skeletal Mesh Component` | 骨骼网格体组件 | 负责显示角色模型（带骨骼动画的模型） |
| `Arrow Component` | 箭头组件 | 编辑器里的方向指示箭头，只在编辑器中可见，不影响运行 |
| `Character Movement Component` | 角色移动组件 | 控制角色的移动逻辑（行走、跳跃、飞行等），是 UE 内置的强大组件 |
| `Camera Component` | 摄像机组件 | 玩家视角摄像机 |
| `Spring Arm Component` | 弹簧臂组件 | 摄像机的"自拍杆"，让摄像机跟随角色并自动避免穿入墙壁，也叫 Camera Boom |

---

### 事件 (Events)

| 英文 | 中文 | 说明 |
|------|------|------|
| `Event BeginPlay` | 开始播放事件 | 游戏开始或该 Actor 生成时触发，只执行**一次** |
| `Event Tick` | 帧更新事件 | 每帧都执行一次，每秒触发次数 = FPS，适合持续更新的逻辑 |
| `Event EndPlay` | 结束播放事件 | Actor 被销毁或游戏结束时触发 |
| `Event OnComponentHit` | 碰撞事件 | 组件发生物理碰撞时触发 |
| `Event OnComponentBeginOverlap` | 重叠开始事件 | 组件进入某个碰撞区域时触发 |
| `Event OnComponentEndOverlap` | 重叠结束事件 | 组件离开某个碰撞区域时触发 |

---

### 角色移动相关

| 英文 | 中文 | 说明 |
|------|------|------|
| `Max Walk Speed` | 最大行走速度 | 角色行走的最快速度，单位为厘米/秒（默认 600） |
| `Jump Z Velocity` | 跳跃Z轴速度 | 跳跃时向上的初速度，值越大跳越高 |
| `Gravity Scale` | 重力缩放 | 影响角色受重力的强度，默认 1.0，设为 0 则悬浮 |
| `Air Control` | 空中控制 | 角色在空中时的移动控制比例（0=完全无法控制，1=和地面一样） |
| `Ground Friction` | 地面摩擦力 | 角色在地面滑行时的摩擦力，影响刹车距离 |
| `Crouched Half Height` | 蹲下时胶囊体半高 | 角色蹲下时胶囊体的高度 |
| `Can Crouch` | 能否蹲下 | 是否允许角色执行蹲下操作 |
| `Is Moving On Ground` | 是否在地面上 | 判断角色当前是否站在地面上 |
| `Is Falling` | 是否在下落 | 判断角色是否处于空中（含跳起后下落阶段） |

---

### 输入 (Input)

| 英文 | 中文 | 说明 |
|------|------|------|
| `Enhanced Input` | 增强输入系统 | UE5 推荐的新输入系统，替代旧版 Input Action |
| `Input Action` | 输入动作 | 定义一个输入事件（如"跳跃"、"攻击"） |
| `Input Mapping Context` | 输入映射上下文 | 将按键绑定到 Input Action 的配置表 |
| `Axis Value` | 轴值 | 输入的连续值，如摇杆偏移量，范围通常 -1 到 1 |
| `Triggered` | 触发中 | 按键正在被按住时持续触发 |
| `Started` | 开始 | 按键刚按下的瞬间触发 |
| `Completed` | 完成 | 按键松开时触发 |

---

## 动画蓝图 (Animation Blueprint)

| 英文 | 中文 | 说明 |
|------|------|------|
| `Anim Blueprint` | 动画蓝图 | 控制角色动画逻辑的蓝图，分 EventGraph 和 AnimGraph 两部分 |
| `State Machine` | 状态机 | 管理动画状态切换的逻辑，如"待机→行走→跑步" |
| `Blend Space` | 混合空间 | 根据参数（如速度）在多个动画之间平滑过渡 |
| `Anim Notify` | 动画通知 | 在动画播放到特定帧时触发事件，如脚步声 |
| `Anim Notify State` | 动画通知状态 | 持续一段帧数的动画通知，有开始/持续/结束三个阶段 |
| `Slot` | 插槽 | 允许在状态机上叠加播放额外动画（如上半身攻击） |
| `Root Motion` | 根运动 | 让角色实际移动距离由动画本身驱动，而非代码驱动 |
| `Layered Blend per Bone` | 按骨骼分层混合 | 让上半身和下半身播放不同动画 |
| `Speed` | 速度 | 动画蓝图里常用的变量，驱动 Blend Space 的行走/跑步过渡 |
| `IsInAir` | 是否在空中 | 动画蓝图里常用的布尔变量，控制跳跃动画切换 |

---

## 蓝图通用节点

| 英文 | 中文 | 说明 |
|------|------|------|
| `Cast To` | 强制转换 | 将一个对象转换为特定类型，转换失败会走 `Failed` 引脚 |
| `Get Player Character` | 获取玩家角色 | 获取当前玩家控制的角色对象 |
| `Get Player Controller` | 获取玩家控制器 | 获取玩家的控制器对象（处理输入的对象） |
| `Spawn Actor from Class` | 从类生成 Actor | 在游戏世界中动态创建一个对象 |
| `Destroy Actor` | 销毁 Actor | 将一个 Actor 从游戏世界中移除 |
| `Set Timer by Function Name` | 按函数名设置计时器 | 延迟一段时间后调用某个函数 |
| `Print String` | 打印字符串 | 调试用，在屏幕上显示文字，**只在调试时用** |
| `Branch` | 分支 | 相当于 if/else，根据布尔值走不同引脚 |
| `Sequence` | 序列 | 依次触发多个输出引脚，用于组织多步逻辑 |
| `Do Once` | 只执行一次 | 只允许逻辑通过一次，可手动 Reset |
| `Flip Flop` | 翻转 | 第一次触发走 A，第二次走 B，交替切换 |
| `For Loop` | 循环 | 从起始值到结束值依次执行，相当于 for 循环 |
| `While Loop` | 当循环 | 条件为真时持续执行，相当于 while 循环 |
| `Delay` | 延迟 | 等待指定秒数后继续执行，**不能在 Tick 中滥用** |

---

## 变量类型

| 英文 | 中文 | 说明 |
|------|------|------|
| `Boolean` | 布尔 | 只有 true / false 两个值 |
| `Integer` | 整数 | 没有小数点的数，如 -1, 0, 42 |
| `Float` | 浮点数 | 有小数点的数，如 3.14 |
| `String` | 字符串 | 文本内容，如 "Hello" |
| `Vector` | 向量 | 三维坐标或方向，包含 X、Y、Z |
| `Rotator` | 旋转体 | 描述旋转角度，包含 Pitch（俯仰）、Yaw（偏航）、Roll（翻滚） |
| `Transform` | 变换 | 包含位置 (Location)、旋转 (Rotation)、缩放 (Scale) |
| `Object Reference` | 对象引用 | 指向某个 UE 对象的"指针" |
| `Class Reference` | 类引用 | 指向某个类本身（不是实例） |
| `Array` | 数组 | 同类型元素的有序集合 |
| `Map` | 映射 | 键值对集合，类似字典 |

---

## 碰撞与物理

| 英文 | 中文 | 说明 |
|------|------|------|
| `Collision Preset` | 碰撞预设 | 预定义的碰撞响应配置，如 BlockAll、OverlapAll、NoCollision |
| `BlockAll` | 阻挡所有 | 与所有对象发生实体碰撞 |
| `OverlapAll` | 与所有重叠 | 与所有对象发生重叠事件，但不产生物理阻挡 |
| `NoCollision` | 无碰撞 | 完全忽略碰撞 |
| `Line Trace` | 射线检测 | 从一点向另一方向发射一条看不见的射线，检测第一个命中的对象 |
| `Sphere Trace` | 球形检测 | 用球体进行扫描检测，比射线检测范围更广 |
| `Hit Result` | 命中结果 | 射线/扫描检测命中时返回的数据（命中位置、法线、被击物体等） |

---

## 常用缩写速查

| 缩写 | 全称 | 中文 |
|------|------|------|
| `BP_` | Blueprint | 蓝图类前缀 |
| `PC_` | Player Controller | 玩家控制器 |
| `GM_` | Game Mode | 游戏模式 |
| `AI_` | Artificial Intelligence | AI 控制器 |
| `WBP_` | Widget Blueprint | UI 控件蓝图 |
| `ABP_` | Animation Blueprint | 动画蓝图 |
| `GI_` | Game Instance | 游戏实例（全局单例） |
| `DT_` | Data Table | 数据表 |
| `DA_` | Data Asset | 数据资产 |

---

## 新词记录区

> 遇到不懂的词就加在这里，不用分类，直接写，之后再整理。

| 遇到的英文 | 我的理解 / 问题 | 弄懂后的解释 |
|-----------|--------------|-------------|
| | | |

---

*最后更新：2026-05-27*
