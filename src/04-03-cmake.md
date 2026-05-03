# CMake

## 学习资料
- [CMake 官方文档](https://cmake.org/cmake/help/latest/)
- [菜鸟教程](https://www.runoob.com/cmake/cmake-tutorial.html)
- [原子之音【现代C++: CMake简明教程】](https://www.bilibili.com/video/BV1xa4y1R7vT?vd_source=5d0525b6127592d0599bf5f5308fa0e6)
## 一、CMake 到底是什么？
>
CMake 不是直接编译代码的工具，而是一个跨平台的构建系统生成器。简单说：
- 你写一份统一的 CMakeLists.txt 配置文件
- CMake 会根据你的操作系统(Windows/Linux/macOS)和编译器(GCC/Clang/MSVC)，自动生成对应的 Makefile、Visual Studio 工程文件或 Ninja 构建文件
- 最终通过这些生成的文件来编译、链接你的项目，不用为不同平台写不同的构建脚本

## 二、核心差距对比

| 对比维度 | 不用 CMake(手动构建)| 用 CMake(自动化构建)|
| --- | --- | --- |
| 跨平台开发 | 每换一个平台(Windows/Linux/macOS)，要重新写一套构建脚本(比如Windows写VS工程,Linux写Makefile)，且脚本不通用，维护成本翻倍。| 只写一份CMakeLists.txt，CMake 自动适配不同平台 / 编译器，生成对应构建文件(Makefile/VS工程/Ninja)，一次编写，全平台可用。
| 项目复杂度适配 | 项目小(1-2 个文件)还能应付；一旦有多个源文件、自定义库、第三方库(比如 OpenCV/Boost)，手动写 Makefile 会极其繁琐，容易出错(比如漏加源文件、库路径写错)。| 无论项目大小，都能用标准化指令(add_library/target_link_libraries)管理源文件、库依赖，逻辑清晰，即使项目扩展也容易维护。|
| 团队协作 | 每个人的开发环境(编译器版本、路径)不同，手动写的构建脚本大概率在别人电脑上跑不通(比如你写的 Makefile 里的库路径是自己电脑的绝对路径)。| CMake 支持 “相对路径”、“查找第三方库(find_package)”，能统一构建规则，团队成员拉取代码后，只需执行```cmake .. && make```就能编译，几乎无环境适配成本。|
|编译配置灵活性| 要改编译选项(比如开启调试模式、指定 C++ 版本)，需手动修改 Makefile/VS 工程的多个地方，容易遗漏。| 用```set(CMAKE_BUILD_TYPE Debug)/set(CMAKE_CXX_STANDARD 17)```等指令，一行代码统一修改编译配置，还能通过-D参数动态调整(比如```cmake -DCMAKE_BUILD_TYPE=Release ..```)。|
| 学习与维护成本 | 短期：入门快(比如简单Makefile几行代码)；<br> 长期：不同平台 / 项目的构建脚本不通用，每次新项目都要重新学，维护成本高。|	短期：需要学 CMake 的核心指令(10 个左右核心指令就能应付 80% 场景)；<br> 长期：学会后，所有 C/C++ 项目都能复用这套逻辑，维护成本极低。|

