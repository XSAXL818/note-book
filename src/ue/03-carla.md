# Carla
## 安装
因为carla是在ue某个特定版本上构建的，如果想要将carla集成到自己的ue项目，需要当前项目的ue版本和carla的对齐。
如果不是将老项目的基础上carla，而是在carla的基础上开发，直接从源码构建更方便。
安装方式：
- 1、 从源码构建


### 从源码构建
- 下载carla源码
    ```cmd
    git clone -b ue5-dev https://github.com/carla-simulator/carla.git CarlaUE5
    ```

- 构建命令：
    ```cmd
    .\CarlaSetup.bat --python-root=C:\Users\75271\.conda\envs\carla10
    ```