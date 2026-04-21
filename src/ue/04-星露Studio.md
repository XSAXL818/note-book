# 星露Studio学习

## 实现玩家移动功能
### 创建游戏模式和游戏角色
UE官方推荐使用增强输入操作（Enhanced Input Actions）和输入映射上下文（Input Mapping Context）来实现玩家移动功能。
![alt text](assets/image-60.png)
实现前需要先将创建一个自己的游戏模式和游戏角色（蓝图类），使用默认配置即可。
![alt text](assets/image-61.png)
将游戏模式中的默认pawn类设置为游戏角色  
![alt text](assets/image-67.png)

### 创建输入操作和输入映射情景
通过右键在输入处创建输入操作IA和输入映射情景IMC  
![alt text](assets/image-62.png)  
### 配置输入操作
IA中将值类型修改为Vecotr2D，二维向量(x,y)，其中x可以用来前后移动，y可以用来左右移动。
![ ](assets/image-64.png)
IMC中在Mappings处新增一个元素，选中创建的IA  
![alt text](assets/image-65.png)  
### 配置输入映射情景
然后新增W\S\A\D，其中S和A需要在修改器中添加一个否定修改器。
![alt text](assets/image-63.png)  
S/A之所以使用否定修改器，原因是我们可以获取角色的向前、向右、向上的空间方向向量，所以W\A的单位向量的对应X/Y为正，与空间方向向量的X/Y相乘也是正。  
![alt text](assets/image-66.png)   

### 最后：在角色蓝图中实现移动逻辑
![alt text](assets/image-70.png)  

最终效果：  
<video controls src="assets/video_2026-04-20_22-48-05.webm" title="Title"></video>

### 进阶：增加飞行和下降
IA中设置3维向量Axis3D  
![alt text](assets/image-68.png)
角色蓝图中在右上角的组件中选择角色移动，然后在右侧细节面板找到默认陆地运动模式，设置为正在飞行  
![alt text](assets/image-69.png)
在角色蓝图中实现移动，在原有基础上添加向上向量的移动
![alt text](assets/image-71.png)

## 实现玩家视角旋转功能
### 理解Yaw和Pitch和Roll
进入角色蓝图，在视口可以看到角色的朝向是对应坐标轴的x的。
- Yaw偏航角：即绕Z轴旋转，改变方向如左右摇头。    
- Pitch俯仰角：即绕Y轴旋转，改变方向为上下点头。  
- Roll翻滚叫：  即绕X轴旋转，改变方向为做翻跟头。

![alt text](assets/image-72.png)  
如果想实现视角的左右上下旋转视角，则需要使用yaw和pitch两个角度。

### 虚幻引擎中Yaw和Pitch输入值的效果：
- Yaw输入为正向右，Pitch输入为正向下。  
- 对于鼠标，向右滑动为正，向上滑动为正。  
因此，使用默认值会导致鼠标上移而视角低头。

### 创建输入操作IA_MyLook
设置为2D向量，X用来yaw，Y用来Pitch。
### 在IMC中的Mappings添加IA_MyLook 
选择 旋转鼠标XY 2D轴  
![alt text](assets/image-73.png)  
修正鼠标上下滑动和视角pitch为相反的情况：
- 在角色蓝图中获得Y后取反
- 在IMC中设置否定修改器，取反Y

推荐第二中：  
![alt text](assets/image-74.png)  
实现效果：
<video controls src="assets/video_2026-04-20_23-36-56.webm" title="Title"></video>  

## 添加注释功能
框选节点，然后按C即可。  
![alt text](assets/image-75.png)  

## 门的正反开门实现
### 获取门的资产
在fab中获取wooden door资产  
![alt text](assets/image-76.png)  
因为获取的都是静态网格体，而我们需要的是一个动态的，因此创建蓝图将门和门框加入。
### 创建门的蓝图
左上角的添加按钮处可以添加静态网格体和碰撞。  
此时可以注意到当前的actor的向右向量和门向右开是一个方向。
![alt text](assets/image-77.png)

### 门旋转的逻辑
通过一同Z轴可以发现，z从0到90度即可实现向右开门，同理从0到-90度即可实现向左开门。  
![alt text](assets/image-78.png)

### 通过时间轴实现丝滑开门
实践轴的update和新建轨道1链接到Door的设置相对旋转函数，即可实现控制门的z轴数值持续变化。  
![alt text](assets/image-81.png)  
双击进入时间轴，可以右键设置两个关键帧，每个帧可以设置时间和值，此时设置(0.0s,1.0)和(1.0s,1.0)来表示0秒到1秒实现值从0到1的变化。左上角的长度设置为1。  
![alt text](assets/image-80.png)  

### 向左开还是向右开门？
二维向量(x,y)，两个向量的点积：
- 为0，说明垂直。
- 为正，说明同向。
- 为负，说明反向。
通过玩家与门的世界位置相减，得到门指向玩家的向量，再与门的向右向量进行点积，如果结果为正，说明玩家在门的右侧，开左门。
![alt text](assets/image-79.png)

### 实现效果
<video controls src="assets/video_2026-04-21_23-57-38.webm" title="Title"></video>

## 常用流程控制
- 分支：根据condition，为正执行一个分支，为负执行另一个分支。
- Flip Flop：轮流切换器，轮流执行两个分支。
- 序列：顺序执行多个分支。
- for loop：根据索引范围，执行多次。
- Do Once：只能执行一次，通过执行reset可以开启执行。
- 延迟：延迟一定时间后执行。
- Gate：门控，只有当门打开时才能执行。其中Toggle执行时，如果是open则切换为close，如果为close则切换为open。
![alt text](assets/image-82.png)