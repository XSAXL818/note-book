# set和list命令

## set
set是 CMake 中用于创建、修改、删除变量的核心命令。它可以设置普通变量、缓存变量、环境变量，并控制变量的作用域。

```bash
# 1. 基本赋值
set(VAR_NAME "value")  # 创建字符串变量
set(NUMBER 100)        # 数字会被当作字符串处理
set(LIST_VAR a b c)   # 创建列表变量

# 2. 修改变量
set(VAR "first")
set(VAR "second")     # 重新赋值
unset(VAR)            # 删除变量

# 3. 作用域控制
function(inner_function)
    set(LOCAL_VAR "inner")      # 仅在函数内可见
    set(PARENT_VAR "outer" PARENT_SCOPE)  # 设置父作用域的变量
endfunction()

# 4. 缓存变量（GUI中可配置）
set(CMAKE_BUILD_TYPE "Release" CACHE STRING "构建类型")
set(ENABLE_FEATURE_X ON CACHE BOOL "启用X功能")

# 5. 列表操作
set(FILE_LIST "main.cpp")      # 初始化为单个元素
set(FILE_LIST ${FILE_LIST} "util.cpp")  # 追加元素
set(FILE_LIST "${FILE_LIST};config.cpp")  # 另一种追加方式

# 6. 环境变量操作
set(ENV{PATH} "/custom/bin:$ENV{PATH}")  # 修改环境变量
set(ENV{HOME} "/home/user")               # 设置环境变量
```

## list 
list是 CMake 中专门处理列表（数组）的命令集合。CMake 中的列表是用分号分隔的字符串，list命令提供了丰富的列表操作功能。
```bash
# 1. 创建和初始化列表
set(MY_LIST a b c d e)  # 创建包含5个元素的列表
list(LENGTH MY_LIST LEN)  # 获取列表长度
message("列表长度: ${LEN}")  # 输出: 5

# 2. 遍历列表
foreach(ITEM ${MY_LIST})
    message("处理元素: ${ITEM}")
endforeach()

# 3. 元素操作
list(APPEND MY_LIST f g)     # 追加元素 [a,b,c,d,e,f,g]
list(PREPEND MY_LIST 1 2)    # 前插元素 [1,2,a,b,c,d,e,f,g]
list(INSERT MY_LIST 3 "new") # 在位置3插入 ["new",a,b,c...]

# 4. 元素删除
list(REMOVE_ITEM MY_LIST "c")  # 删除元素"c"
list(REMOVE_AT MY_LIST 0)     # 删除第一个元素
list(REMOVE_DUPLICATES MY_LIST)  # 删除重复元素

# 5. 查找和排序
list(FIND MY_LIST "d" INDEX)  # 查找"d"的位置
if(NOT INDEX EQUAL -1)
    message("找到'd'在位置: ${INDEX}")
endif()

list(SORT MY_LIST)       # 排序
list(REVERSE MY_LIST)    # 反转列表

# 6. 列表片段
list(SUBLIST MY_LIST 2 3 SUB_LIST)  # 获取从索引2开始的3个元素
list(JOIN MY_LIST ", " JOINED_STR)  # 列表转字符串: "a, b, c, d, e"

# 7. 文件列表处理
file(GLOB SOURCE_FILES "src/*.cpp")  # 获取文件列表
list(SORT SOURCE_FILES)              # 排序文件列表
```