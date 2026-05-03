# conda

## 创建命令
```bash
conda create -n 环境名称 python=版本号
```

### 常用参数说明

| 参数 | 说明 | 示例 | 
| :-----: | --------- | --------- |
| -n | 指定环境名称 | conda create -n my_env                                         |
| -p | 指定环境安装的具体路径 | conda create -p D:\envs\my_env                       |
| python=x.x | 指定 Python 版本 | conda create -n my_env python=3.10                 |
| 包名=版本 | 创建时直接安装指定库 | conda create -n my_env python=3.12 numpy pandas |
| --clone | 复制一个现有的环境 | conda create -n new_env --clone old_env             |
| --file | 从配置文件创建环境 | conda create -n my_env --file requirements.txt       |
