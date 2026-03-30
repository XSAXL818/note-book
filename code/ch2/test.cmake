# 不同级别的消息
message("普通消息")                # STATUS（默认，绿色）
message(STATUS "状态消息")         # 绿色
message(WARNING "警告消息")        # 黄色
message(AUTHOR_WARNING "作者警告") # 黄色
message(SEND_ERROR "发送错误")     # 红色，继续运行
message(FATAL_ERROR "致命错误")    # 红色，停止运行
message(DEBUG "调试信息")          # 仅调试模式显示
message(VERBOSE "详细信息")        # 详细模式显示
