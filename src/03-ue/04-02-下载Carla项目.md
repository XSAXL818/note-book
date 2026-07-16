# 下载Carla项目

## 下载项目
将ue5-dev分支的Carla项目代码clone：
```bash
git clone -b ue5-dev https://github.com/carla-simulator/carla.git CarlaUE5
```


运行安装脚本：踩坑之处
```bash
cd CarlaUE5
CarlaSetup.bat
```

CarlaSetup.bat脚本安装所有必需的软件包，包括Visual Studio 2022、Cmake、Python 3.8软件包和虚幻引擎5.5。它还下载CARLA内容并构建CARLA。因此，这个批处理文件可能需要很长时间才能完成。

处理的任务太多，且会因为网络原因速度慢甚至无法下载，所以推荐手动执行不同部分。



## CarlaSetup.bat 逐行解析

> 源文件路径：`G:\CarlaUE5\CarlaSetup.bat`  
> 官方文档：https://carla-ue5.readthedocs.io/en/latest/build_windows_ue5/

---

### 一、脚本概述

`CarlaSetup.bat` 是 CARLA UE5 版的 Windows 一键构建脚本。它完成了从环境依赖安装到 CARLA 编译、Python API 安装、编辑器启动的全流程。执行前需要已克隆 CARLA 的 `ue5-dev` 分支。

---

### 二、命令行参数

| 参数                   | 简写           | 作用                                                       |
| ---------------------- | -------------- | ---------------------------------------------------------- |
| `--interactive`        | `-i`           | 交互模式（脚本中声明了变量，但未实际使用该逻辑）           |
| `--skip-prerequisites` | `-p`           | 跳过前提依赖安装步骤（VS / Ninja / Python）                |
| `--launch`             | `-l`           | 构建完成后自动启动 UE5 编辑器                              |
| `--python-root=PATH`   | `-pyroot PATH` | 指定已安装的 Python 根目录，避免脚本自动安装 Python 3.8.10 |

如果不传 `--python-root`，默认使用系统 PATH 中的 `python`。

---

### 三、逐段解析

#### 3.1 头部与变量初始化（第 1-8 行）

```bat
@echo off
setlocal EnableDelayedExpansion
```

- `@echo off` — 关闭命令回显，不在终端逐行显示执行的命令。
- `setlocal EnableDelayedExpansion` — 开启延迟变量扩展。在 `for` 循环或 `if` 块内，用 `!var!` 代替 `%var%` 才能取到实时更新的值。脚本后续在 `if/else` 块中使用了 `!cd!`，所以必须开启此选项。

```bat
set skip_prerequisites=false
set launch=false
set interactive=false
set python_path=python
set python_root=
```

初始化 5 个控制变量：

- `skip_prerequisites` — 是否跳过前提安装
- `launch` — 是否构建后启动编辑器
- `interactive` — 交互模式标志
- `python_path` — 实际调用的 Python 命令，默认 `python`
- `python_root` — `--python-root` 参数指定的路径，默认为空

---

#### 3.2 命令行参数解析循环（第 10-45 行）

```bat
:parse
    if "%1"=="" (
        goto main
    )
```

定义标签 `:parse`。`%1` 是第一个参数，如果为空（没有更多参数了），跳转到 `:main` 开始执行主逻辑。

```bat
    if "%1"=="--interactive" (
        set interactive=true
    ) else if "%1"=="-i" (
        set interactive=true
    ) else if "%1"=="--skip-prerequisites" (
        set skip_prerequisites=true
    ) else if "%1"=="-p" (
        set skip_prerequisites=true
    ) else if "%1"=="--launch" (
        set launch=true
    ) else if "%1"=="-l" (
        set launch=true
    )
```

逐个匹配已知参数，设置对应标志。`--interactive`/`-i`、`--skip-prerequisites`/`-p`、`--launch`/`-l` 各有长写和简写两种形式。

```bat
    else (
        echo %1 | findstr /B /C:"--python-root=" >nul
        if not errorlevel 1 (
            set python_root="%1"
            set python_root="!python_root:--python-root=!"
        ) else if "%1"=="--python-root" (
            set python_root=%2
            shift
        ) else if "%1"=="-pyroot" (
            set python_root=%2
            shift
        ) else (
            echo Unknown argument "%1"
            exit /b
        )
    )
```

处理 `--python-root` 参数的三种写法：

- `--python-root=PATH`（等号形式）— 用 `findstr` 检测前缀 `/B /C:"--python-root="`，匹配后用字符串替换 `!python_root:--python-root=!` 去掉前缀，提取出路径
- `--python-root PATH`（空格分隔形式）— 取 `%2`（下一个参数）作为路径值
- `-pyroot PATH`（简写形式）— 同上

遇到未知参数时打印错误并退出（`exit /b`）。

```bat
    shift
    goto parse
```

`shift` 移除已处理的参数，`goto parse` 循环回去处理下一个。这是一个典型的 bat 参数解析循环。

---

#### 3.3 设置 Python 路径（第 51-53 行）

```bat
if not "%python_root%"=="" (
    set python_path=%python_root%\python
)
```

如果用户通过 `--python-root` 指定了 Python 根目录，则把 `python_path` 设为 `<根目录>\python`。后续所有 Python 调用都用这个路径。否则保持默认值 `python`（使用系统 PATH 中的 Python）。

---

#### 3.4 安装前提依赖（第 57-62 行）

```bat
if %skip_prerequisites%==false (
    echo Installing prerequisites...
    call Util/SetupUtils/InstallPrerequisites.bat --python-path=%python_path% || exit /b
) else (
    echo Skipping prerequisites install step.
)
```

- 如果未传 `--skip-prerequisites`，调用子脚本 `InstallPrerequisites.bat`。
- `|| exit /b` — 如果子脚本返回非零退出码（失败），整个脚本终止。
- 传入 `--python-path` 参数告诉子脚本用哪个 Python。

##### InstallPrerequisites.bat 子脚本做了什么

| 步骤               | 内容                                                         |
| ------------------ | ------------------------------------------------------------ |
| **检查 VS 2022**   | 依次检查 Community / Professional / Enterprise 版的 `vcvars64.bat` 是否存在。找到就跳过；找不到就下载 `vs_community.exe` 并安装一组指定组件（C++ 桌面开发、游戏开发、.NET 桌面开发、Windows 10 SDK 22621、CMake、Clang、MSVC v14.36 等） |
| **检查 Ninja**     | 运行 `ninja --version`。找不到就从 GitHub 下载 `ninja-win.zip`（v1.12.1），解压到 `%USERPROFILE%\AppData\Local\Microsoft\WindowsApps\` |
| **检查 Python**    | 运行 `python -V`。找不到就下载安装 Python 3.8.10（被动模式，加入 PATH） |
| **安装 Python 包** | `pip install --upgrade pip` + `pip install -r requirements.txt`。requirements.txt 内容：`psutil`、`requests`、`scikit-build-core`、`wheel`、`numpy<2.0,>=1.24.4`、`setuptools>=47.3.1`、`build`、`pygame` |

---

#### 3.5 下载 CARLA 内容资源（第 64-77 行）

```bat
if exist "%cd%\Unreal\CarlaUnreal\Content" (
    echo Found CARLA content.
) else (
    echo Could not find CARLA content. Downloading...
    mkdir %cd%\Unreal\CarlaUnreal\Content
    git ^
        -C %cd%\Unreal\CarlaUnreal\Content ^
        clone ^
        -b ue5-dev ^
        https://bitbucket.org/carla-simulator/carla-content.git ^
        Carla ^
    || exit /b
)
```

- 检查 `Unreal\CarlaUnreal\Content` 目录是否存在。
- 已存在 → 跳过。
- 不存在 → 创建目录，然后从 Bitbucket 克隆 `carla-content` 仓库的 `ue5-dev` 分支。
- `^` 是 bat 的续行符，相当于把多行命令连成一行。
- `-C <path>` — 在指定路径下执行 git 命令（该路径同时作为克隆目标目录）。
- `Carla` — 克隆到名为 `Carla` 的子目录。
- 这部分是 CARLA 的地图、模型、材质等美术资产，体积较大。

> **注意：** 此处未配置代理。如果网络需要代理访问 Bitbucket，可能需要手动设置 `git config --global http.proxy`。

---

#### 3.6 激活 VS 开发环境（第 79-97 行）

```bat
set "vs_env_bat="
if exist "%PROGRAMFILES%\Microsoft Visual Studio\2022\Community\VC\Auxiliary\Build\vcvars64.bat" (
    set "vs_env_bat=%PROGRAMFILES%\Microsoft Visual Studio\2022\Community\VC\Auxiliary\Build\vcvars64.bat"
)
if exist "%PROGRAMFILES%\Microsoft Visual Studio\2022\Professional\VC\Auxiliary\Build\vcvars64.bat" (
    set "vs_env_bat=%PROGRAMFILES%\Microsoft Visual Studio\2022\Professional\VC\Auxiliary\Build\vcvars64.bat"
)
if exist "%PROGRAMFILES%\Microsoft Visual Studio\2022\Enterprise\VC\Auxiliary\Build\vcvars64.bat" (
    set "vs_env_bat=%PROGRAMFILES%\Microsoft Visual Studio\2022\Enterprise\VC\Auxiliary\Build\vcvars64.bat"
)
```

依次检查 VS 2022 的三个版本（Community → Professional → Enterprise），找到哪个就用哪个的 `vcvars64.bat` 路径。后面的版本会覆盖前面的（即如果 Community 和 Professional 都存在，用 Professional）。

```bat
if not "%vs_env_bat%"=="" (
    echo Activating "x64 Native Tools Command Prompt" terminal environment.
    call "%vs_env_bat%" || exit /b
) else (
    echo Could not find vcvars64.bat for VS 2022, aborting setup...
    exit 1
)
```

- 找到 `vcvars64.bat` → `call` 执行它。这会设置 MSVC 编译器（`cl.exe`）、Windows SDK、链接器等环境变量到当前 shell。
- 这等同于手动打开 "x64 Native Tools Command Prompt for VS 2022"。
- 找不到 → 报错退出，`exit 1` 返回退出码 1。

> **这就是为什么官方文档说后续手动构建时要用 x64 Native Tools Command Prompt** — 脚本在这里自动完成了这个环境的激活。

---

#### 3.7 检查/下载/编译 UE5 引擎（第 99-124 行）

```bat
if exist "%CARLA_UNREAL_ENGINE_PATH%" (
    echo Found Unreal Engine 5 at "%CARLA_UNREAL_ENGINE_PATH%".
)
```

**第一优先级：** 检查环境变量 `CARLA_UNREAL_ENGINE_PATH` 指向的路径是否存在。如果存在，直接跳过整个 UE5 下载编译流程。

```bat
else if exist ..\UnrealEngine5_carla (
    echo Found CARLA Unreal Engine at %cd%/UnrealEngine5_carla. Assuming already built...
)
```

**第二优先级：** 检查上级目录（`..`）下有没有 `UnrealEngine5_carla` 文件夹。如果有，假设已编译完成，跳过。

```bat
else (
    echo Could not find CARLA Unreal Engine, downloading...
    pushd ..
    git clone ^
        -b ue5-dev-carla ^
        https://github.com/CarlaUnreal/UnrealEngine.git ^
        UnrealEngine5_carla || exit /b
```

**第三优先级（都没有时）：** 

- `pushd ..` — 切换到上级目录（CARLA 源码的父目录，即 `G:\`）。
- 从 GitHub 克隆 CARLA fork 的 UE5 仓库（`ue5-dev-carla` 分支）到 `UnrealEngine5_carla` 目录。

```bat
    pushd UnrealEngine5_carla
    set CARLA_UNREAL_ENGINE_PATH=!cd!
    setx CARLA_UNREAL_ENGINE_PATH !cd!
```

- `pushd UnrealEngine5_carla` — 进入刚克隆的引擎目录。
- `set CARLA_UNREAL_ENGINE_PATH=!cd!` — 设置当前 shell 的环境变量（用 `!cd!` 而非 `%cd%` 因为需要延迟扩展取到实时值）。
- `setx CARLA_UNREAL_ENGINE_PATH !cd!` — 持久化设置环境变量到注册表，下次开机仍然有效。

```bat
    echo Running Unreal Engine pre-build steps...
    call Setup.bat || exit /b
    call GenerateProjectFiles.bat || exit /b
```

- `Setup.bat` — UE5 的前置准备脚本，下载依赖文件（如第三方库、Android NDK 等）。
- `GenerateProjectFiles.bat` — 生成 VS 解决方案文件（`.sln`）。

```bat
    echo Building Unreal Engine 5...
    msbuild ^
        Engine\Intermediate\ProjectFiles\UE5.vcxproj ^
        /property:Configuration="Development_Editor" ^
        /property:Platform="x64" || exit /b
    popd
    popd
)
```

- 用 MSBuild 编译 UE5 引擎本身，配置为 `Development_Editor`，平台 `x64`。
- **这一步极其耗时**（官方文档说 1 小时+，需要 225GB 磁盘空间）。
- 两个 `popd` — 分别从 `UnrealEngine5_carla` 目录和上级目录退回，恢复到原始工作目录（`G:\CarlaUE5`）。

---

#### 3.8 CMake 配置 + 构建 + Python API 安装（第 126-141 行）

```bat
echo Configuring the CARLA CMake project...
cmake ^
    -G Ninja ^
    -S . ^
    -B Build ^
    --toolchain=CMake/Toolchain.cmake ^
    -DPython_ROOT_DIR=%python_root% ^
    -DPython3_ROOT_DIR=%python_root% ^
    -DCMAKE_BUILD_TYPE=Release ^
    -DCARLA_UNREAL_ENGINE_PATH=%CARLA_UNREAL_ENGINE_PATH% || exit /b
```

**CMake 配置阶段：**

| 参数                                | 作用                                                |
| ----------------------------------- | --------------------------------------------------- |
| `-G Ninja`                          | 使用 Ninja 构建系统（比 MSBuild 更快的并行构建）    |
| `-S .`                              | 源码目录为当前目录（`G:\CarlaUE5`）                 |
| `-B Build`                          | 构建输出目录为 `Build`                              |
| `--toolchain=CMake/Toolchain.cmake` | 使用 CARLA 自定义的工具链文件（指定编译器、SDK 等） |
| `-DPython_ROOT_DIR`                 | Python 根目录（用于构建 Python API）                |
| `-DPython3_ROOT_DIR`                | 同上（兼容 CMake 不同版本的变量名）                 |
| `-DCMAKE_BUILD_TYPE=Release`        | Release 模式，启用优化                              |
| `-DCARLA_UNREAL_ENGINE_PATH`        | UE5 引擎路径，让 CMake 找到引擎                     |

> **注意：** 官方文档中手动构建的命令没有 `--toolchain` 和 `-DPython_ROOT_DIR` 等参数。脚本版本更完整，指定了工具链和 Python 路径。
>
> **关键：** 脚本没有加 `-DBUILD_LIBCARLA_TESTS=OFF`，如果 googletest 在新版 MSVC 下编译失败，需要手动添加此参数。

```bat
echo Building CARLA...
cmake --build Build || exit /b
```

**构建阶段：** 执行 `cmake --build Build`，用 Ninja 并行编译 CARLA 的 C++ 库（LibCarla）、UE5 插件等。这是编译过程中耗时最长的部分。

```bat
echo Installing Python API...
cmake --build Build --target carla-python-api-install || exit /b
echo CARLA Python API build+install succeeded.
```

**Python API 阶段：** 执行 `--target carla-python-api-install`，构建 `carla` Python 包并安装到当前 Python 环境中。完成后可以 `import carla` 使用 Python API。

---

#### 3.9 可选：启动编辑器（第 143-148 行）

```bat
if %launch%==true (
    echo Launching Carla Unreal Editor...
    cmake --build Build --target launch || exit /b
)
```

仅当传了 `--launch` / `-l` 参数时执行。调用 `cmake --build Build --target launch` 启动 UE5 编辑器并加载 CARLA 项目。

如果不传该参数，脚本到此结束，用户需自行运行上述命令启动编辑器。

---

### 四、脚本完整执行流程图

```
CarlaSetup.bat
│
├─ 解析命令行参数
│
├─ [可跳过] 安装前提依赖 (InstallPrerequisites.bat)
│   ├─ 检查/安装 VS 2022
│   ├─ 检查/安装 Ninja
│   ├─ 检查/安装 Python 3.8.10
│   └─ pip install requirements.txt
│
├─ 下载 CARLA 内容资源 (carla-content, Bitbucket)
│
├─ 激活 VS 开发环境 (vcvars64.bat)
│
├─ [可跳过] 检查/下载/编译 UE5 引擎
│   ├─ 检查 CARLA_UNREAL_ENGINE_PATH 环境变量
│   ├─ 检查上级目录 UnrealEngine5_carla
│   └─ 都没有 → 克隆 + Setup + GenerateProjectFiles + MSBuild
│
├─ CMake 配置 (cmake -G Ninja ...)
│
├─ 构建 CARLA (cmake --build Build)
│
├─ 安装 Python API (cmake --build --target carla-python-api-install)
│
└─ [可选] 启动编辑器 (cmake --build --target launch)
```

---

### 五、与手动构建的差异

| 方面          | CarlaSetup.bat                           | 手动构建（官方文档）                       |
| ------------- | ---------------------------------------- | ------------------------------------------ |
| VS 环境       | 脚本内自动 `call vcvars64.bat`           | 需手动打开 x64 Native Tools Command Prompt |
| CMake 工具链  | 指定 `--toolchain=CMake/Toolchain.cmake` | 文档未提及                                 |
| Python 路径   | 显式传 `-DPython_ROOT_DIR`               | 文档未提及                                 |
| LibCarla 测试 | **不跳过**（可能编译失败）               | 可手动加 `-DBUILD_LIBCARLA_TESTS=OFF`      |
| CARLA 内容    | 自动从 Bitbucket 下载                    | 需手动克隆                                 |
| 前提依赖      | 自动安装 VS/Ninja/Python                 | 需预先安装                                 |

---

### 六、使用建议

#### 直接使用脚本

```cmd
cd /d G:\CarlaUE5
CarlaSetup.bat --skip-prerequisites --python-root=C:\Users\75271\.conda\envs\carla10
```

- `--skip-prerequisites` — 跳过 VS/Ninja/Python 安装（已全部具备）
- `--python-root` — 指定 conda 环境的 Python（3.10）

#### 手动分步构建（推荐，可控性更强）

```cmd
:: 1. 在 x64 Native Tools Command Prompt for VS 2022 中
cd /d G:\CarlaUE5

:: 2. 下载内容资源
cd Unreal\CarlaUnreal\Content
git clone -b ue5-dev https://bitbucket.org/carla-simulator/carla-content.git Carla
cd /d G:\CarlaUE5

:: 3. CMake 配置
cmake -G Ninja -S . -B Build -DCMAKE_BUILD_TYPE=Release -DBUILD_LIBCARLA_TESTS=OFF

:: 4. 构建
cmake --build Build

:: 5. 安装 Python API
cmake --build Build --target carla-python-api-install

:: 6. 启动编辑器
cmake --build Build --target launch
```


## 完整代码
```bash
@echo off
setlocal EnableDelayedExpansion

set skip_prerequisites=false
set launch=false
set interactive=false
set python_path=python
set python_root=

rem -- PARSE COMMAND LINE ARGUMENTS --

:parse
    if "%1"=="" (
        goto main
    )
    if "%1"=="--interactive" (
        set interactive=true
    ) else if "%1"=="-i" (
        set interactive=true
    ) else if "%1"=="--skip-prerequisites" (
        set skip_prerequisites=true
    ) else if "%1"=="-p" (
        set skip_prerequisites=true
    ) else if "%1"=="--launch" (
        set launch=true
    ) else if "%1"=="-l" (
        set launch=true
    ) else (
        echo %1 | findstr /B /C:"--python-root=" >nul
        if not errorlevel 1 (
            set python_root="%1"
            set python_root="!python_root:--python-root=!"
        ) else if "%1"=="--python-root" (
            set python_root=%2
            shift
        ) else if "%1"=="-pyroot" (
            set python_root=%2
            shift
        ) else (
            echo Unknown argument "%1"
            exit /b
        )
    )
    shift
    goto parse

rem -- MAIN --

:main

if not "%python_root%"=="" (
    set python_path=%python_root%\python
)

rem -- PREREQUISITES INSTALL STEP --

if %skip_prerequisites%==false (
    echo Installing prerequisites...
    call Util/SetupUtils/InstallPrerequisites.bat --python-path=%python_path% || exit /b
) else (
    echo Skipping prerequisites install step.
)

rem -- CLONE CONTENT --
if exist "%cd%\Unreal\CarlaUnreal\Content" (
    echo Found CARLA content.
) else (
    echo Could not find CARLA content. Downloading...
    mkdir %cd%\Unreal\CarlaUnreal\Content
    git ^
        -C %cd%\Unreal\CarlaUnreal\Content ^
        clone ^
        -b ue5-dev ^
        https://bitbucket.org/carla-simulator/carla-content.git ^
        Carla ^
    || exit /b
)

rem Activate VS terminal development environment:
set "vs_env_bat="
if exist "%PROGRAMFILES%\Microsoft Visual Studio\2022\Community\VC\Auxiliary\Build\vcvars64.bat" (
    set "vs_env_bat=%PROGRAMFILES%\Microsoft Visual Studio\2022\Community\VC\Auxiliary\Build\vcvars64.bat"
)
if exist "%PROGRAMFILES%\Microsoft Visual Studio\2022\Professional\VC\Auxiliary\Build\vcvars64.bat" (
    set "vs_env_bat=%PROGRAMFILES%\Microsoft Visual Studio\2022\Professional\VC\Auxiliary\Build\vcvars64.bat"
)
if exist "%PROGRAMFILES%\Microsoft Visual Studio\2022\Enterprise\VC\Auxiliary\Build\vcvars64.bat" (
    set "vs_env_bat=%PROGRAMFILES%\Microsoft Visual Studio\2022\Enterprise\VC\Auxiliary\Build\vcvars64.bat"
)

if not "%vs_env_bat%"=="" (
    echo Activating "x64 Native Tools Command Prompt" terminal environment.
    call "%vs_env_bat%" || exit /b
) else (
    echo Could not find vcvars64.bat for VS 2022, aborting setup...
    exit 1
)

rem -- DOWNLOAD + BUILD UNREAL ENGINE --
if exist "%CARLA_UNREAL_ENGINE_PATH%" (
    echo Found Unreal Engine 5 at "%CARLA_UNREAL_ENGINE_PATH%".
) else if exist ..\UnrealEngine5_carla (
    echo Found CARLA Unreal Engine at %cd%/UnrealEngine5_carla. Assuming already built...
) else (
    echo Could not find CARLA Unreal Engine, downloading...
    pushd ..
    git clone ^
        -b ue5-dev-carla ^
        https://github.com/CarlaUnreal/UnrealEngine.git ^
        UnrealEngine5_carla || exit /b
    pushd UnrealEngine5_carla
    set CARLA_UNREAL_ENGINE_PATH=!cd!
    setx CARLA_UNREAL_ENGINE_PATH !cd!
    echo Running Unreal Engine pre-build steps...
    call Setup.bat || exit /b
    call GenerateProjectFiles.bat || exit /b
    echo Building Unreal Engine 5...
    msbuild ^
        Engine\Intermediate\ProjectFiles\UE5.vcxproj ^
        /property:Configuration="Development_Editor" ^
        /property:Platform="x64" || exit /b
    popd
    popd
)

rem -- BUILD CARLA --
echo Configuring the CARLA CMake project...
cmake ^
    -G Ninja ^
    -S . ^
    -B Build ^
    --toolchain=CMake/Toolchain.cmake ^
    -DPython_ROOT_DIR=%python_root% ^
    -DPython3_ROOT_DIR=%python_root% ^
    -DCMAKE_BUILD_TYPE=Release ^
    -DCARLA_UNREAL_ENGINE_PATH=%CARLA_UNREAL_ENGINE_PATH% || exit /b
echo Building CARLA...
cmake --build Build || exit /b
echo Installing Python API...
cmake --build Build --target carla-python-api-install || exit /b
echo CARLA Python API build+install succeeded.

rem -- POST-BUILD STEPS --

if %launch%==true (
    echo Launching Carla Unreal Editor...
    cmake --build Build --target launch || exit /b
)

```