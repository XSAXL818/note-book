# windows下构建项目

## 一、下载
- 推荐下载二进制发行版(Binary distributions)  
![](assets/2.png)
- 验证  
![](assets/3.png)

## 二、build system generator
![](assets/4.png)

## 三、文件目录如下
![](assets/5.png)

## 四、运行命令 cmake -B build 构建项目
```bash
cmake -B build
```  
1. 使用默认的MSVC构建
![](assets/6.png)  

    - 生成的build目录内容  
    ![](assets/7.png)  

    - 可以使用VS打开或者点击.sln文件打开项目  
    ![](assets/9.png)  
    注意配置启动项需选择项目名称

1. 使用MinGW构建 cmake -B build -G "MinGW Makefiles"  
![](assets/11.png)

## 五、运行命令 cmake --build build 生成可执行文件
```bash
cmake --build build
```
MSVC构建项目  
![](assets/8.png)

MinGW构建项目  
![](assets/12.png)