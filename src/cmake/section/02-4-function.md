# 函数

函数是 CMake 中封装可重用代码块的机制，有独立的作用域，参数通过传值方式传递，支持返回值。

``` bash
# 1. 基本函数定义和使用
function(print_info)
    message("CMake 版本: ${CMAKE_VERSION}")
    message("项目名称: ${PROJECT_NAME}")
    message("构建类型: ${CMAKE_BUILD_TYPE}")
endfunction()

# 调用函数
print_info()

# 2. 带参数的函数
function(compile_file file_name)
    message("正在编译文件: ${file_name}")
    
    # 参数是必需的
    if(NOT file_name)
        message(FATAL_ERROR "必须提供文件名参数")
    endif()
    
    # 处理文件
    set(OUTPUT_FILE "${file_name}.o")
    message("输出文件: ${OUTPUT_FILE}")
endfunction()

# 调用带参函数
compile_file("main.cpp")
compile_file("utils.cpp")

# 3. 带返回值的函数
function(get_compiler_flags result_var is_debug)
    if(is_debug)
        set(flags "-O0 -g -DDEBUG")  # 调试标志
    else()
        set(flags "-O3 -DNDEBUG")    # 发布标志
    endif()
    
    # 通过PARENT_SCOPE返回结果
    set(${result_var} "${flags}" PARENT_SCOPE)
endfunction()

# 使用返回值
get_compiler_flags(MY_FLAGS TRUE)  # 获取调试标志
message("编译器标志: ${MY_FLAGS}")

# 4. 处理多个参数
function(create_target target_name)
    # ${ARGN} 包含除target_name外的所有参数
    message("创建目标: ${target_name}")
    message("附加参数: ${ARGN}")
    
    # 统计参数个数
    list(LENGTH ARGN arg_count)
    message("附加参数数量: ${arg_count}")
    
    # 处理文件参数
    foreach(src_file ${ARGN})
        if(EXISTS "${src_file}")
            message("添加源文件: ${src_file}")
        else()
            message(WARNING "文件不存在: ${src_file}")
        endif()
    endforeach()
endfunction()

# 调用多参数函数
create_target(myapp main.cpp utils.cpp config.cpp)

```