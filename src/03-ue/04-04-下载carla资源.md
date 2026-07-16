# 下载carla资源

- 检查 `Unreal\CarlaUnreal\Content` 目录是否存在。
- 已存在 → 跳过。
- 不存在 → 创建目录，然后从 Bitbucket 克隆 `carla-content` 仓库的 `ue5-dev` 分支。

```bash
git -C %cd%\Unreal\CarlaUnreal\Content clone -b ue5-dev https://bitbucket.org/carla-simulator/carla-content.git Carla 
```