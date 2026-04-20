# 使用小技巧
















<script>
    // 1. 获取画布元素
    const canvas = document.getElementById('myCanvas');
    // 2. 获取2D绘图上下文（核心对象，所有绘制操作都通过它完成）
    const ctx = canvas.getContext('2d');
    // ========== 绘制矩形 ==========
    // 填充矩形（实心）：fillRect(x, y, 宽度, 高度)
    ctx.fillStyle = '#42b983'; // 设置填充颜色
    ctx.fillRect(20, 20, 100, 80); // 坐标(20,20)，宽100，高80
    // 描边矩形（空心）：strokeRect(x, y, 宽度, 高度)
    ctx.strokeStyle = '#e74c3c'; // 设置描边颜色
    ctx.lineWidth = 3; // 设置线条宽度
    ctx.strokeRect(150, 20, 100, 80);
    // ========== 绘制圆形 ==========
    ctx.beginPath(); // 开始新路径（避免和其他图形关联）
    // arc(x, y, 半径, 起始角度, 结束角度, 是否逆时针)
    // 角度以弧度为单位，Math.PI = 180°，Math.PI*2 = 360°
    ctx.arc(350, 60, 40, 0, Math.PI * 2);
    ctx.fillStyle = '#3498db';
    ctx.fill(); // 填充圆形
    ctx.strokeStyle = '#000';
    ctx.stroke(); // 给圆形加边框
    // ========== 绘制线条 ==========
    ctx.beginPath();
    ctx.moveTo(20, 150); // 起点
    ctx.lineTo(200, 250); // 终点
    ctx.lineWidth = 5;
    ctx.strokeStyle = '#9b59b6';
    ctx.stroke(); // 绘制线条
    // ========== 绘制多边形（三角形） ==========
    ctx.beginPath();
    ctx.moveTo(250, 150); // 第一个顶点
    ctx.lineTo(350, 150); // 第二个顶点
    ctx.lineTo(300, 250); // 第三个顶点
    ctx.closePath(); // 闭合路径（回到第一个顶点）
    ctx.fillStyle = '#f39c12';
    ctx.fill();
    ctx.stroke();
</script>

