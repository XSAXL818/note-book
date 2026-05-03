# VMware

VMware Workstation 25H2/25H2u1（最新版）官方不再内置中文，需要手动安装中文语言包并配置，下面是最稳妥的完整步骤：  
### 一、准备工作（必做）
1. 完全关闭 VMware Workstation（包括后台服务）
2. 下载 zh_CN 中文语言包（从 VMware 17.x 提取，或从可信来源下载）
3. 确保你知道 VMware 的安装路径（默认：C:\Program Files\VMware\VMware Workstation）
### 二、安装中文语言包
1. 打开 VMware 安装目录下的 messages 文件夹
2. 将下载 / 解压好的 zh_CN 文件夹 完整复制到 messages 里
3. 正确结构：messages\zh_CN\*.vmsg（不要嵌套成 zh_CN\zh_CN）
4. 以管理员身份操作，避免权限不足
### 三、配置中文（二选一即可）
1. 方法 1：修改配置文件（推荐，永久生效）
1. 按 Win+R，输入 %APPDATA%\VMware 并回车
1. 找到 preferences.ini，用记事本打开
1. 在文件最后一行添加：
    ```
    pref.locale = "zh_CN"
    ```
1. 保存并关闭，重启 VMware