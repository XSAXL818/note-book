# 流程控制

流程控制是 CMake 中控制脚本执行流程的语句，包括条件判断（if/else）和循环（foreach/while），类似于其他编程语言中的控制结构。

```bash
# 1. 条件判断 - 平台检测
if(WIN32)
    message("Windows 平台")
    set(LIBRARY_EXTENSION ".dll")
elseif(APPLE)
    message("macOS 平台")
    set(LIBRARY_EXTENSION ".dylib")
elseif(UNIX)
    message("Linux/Unix 平台")
    set(LIBRARY_EXTENSION ".so")
else()
    message(FATAL_ERROR "未知平台")
endif()

# 2. 条件判断 - 变量检查
if(DEFINED MY_VARIABLE)  # 检查变量是否定义
    message("变量已定义: ${MY_VARIABLE}")
endif()

if(NOT EXISTS "${FILE_PATH}")  # 检查文件是否存在
    message(WARNING "文件不存在: ${FILE_PATH}")
endif()

# 3. 条件判断 - 字符串比较
if(CMAKE_CXX_COMPILER_ID STREQUAL "GNU")
    set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -std=c++11")
elseif(CMAKE_CXX_COMPILER_ID MATCHES "Clang")
    set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -std=c++11")
endif()

# 4. foreach循环 - 遍历列表
set(FILES main.cpp util.cpp config.cpp)
foreach(FILE ${FILES})
    # 为每个文件生成依赖信息
    message("处理文件: ${FILE}")
endforeach()

# 5. foreach循环 - 范围遍历
foreach(NUM RANGE 1 5)      # 1,2,3,4,5
    message("数字: ${NUM}")
endforeach()

foreach(NUM RANGE 0 10 2)   # 0,2,4,6,8,10
    message("偶数: ${NUM}")
endforeach()

# 6. while循环
set(COUNTER 0)
while(COUNTER LESS 5)
    message("计数: ${COUNTER}")
    math(EXPR COUNTER "${COUNTER} + 1")
endwhile()

# 7. 循环控制
foreach(FILE ${SOURCE_FILES})
    if(FILE MATCHES "test_")  # 跳过测试文件
        continue()
    endif()
    
    if(FILE STREQUAL "stop.cpp")  # 遇到特定文件停止
        break()
    endif()
    
    message("编译: ${FILE}")
endforeach()
```
