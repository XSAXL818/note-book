# Markdown使用


## 基础语法

### 标题


源码：
```bash
# 1级标题
## 2级标题
### 3级标题
#### 4级标题
##### 5级标题
###### 6级标题
```

预览效果：
<div class="" style="background:#ffffff; border-radius:8px;">

<h1>1级标题</h1>
<br> 
<h2>2级标题</h2>
<br>
<h3>3级标题</h3>
<br>
<h4>4级标题</h4>
<br>
<h5>5级标题</h5>
<br>
<h6>6级标题</h6>
<br>
</div>


### 段落

```text
段落之间没有空行隔开
算是一个段落

与上面的文字之间空行

```

预览效果：

<div class="white-block" style="background:#ffffff;border-radius:8px; ">

段落之间没有空行隔开
算是一个段落

与上面的文字之间空行

</div>


### 换行


源码：
```text
文本内换行书写不会导致
换行

当前文本后加两个空格  
换行
```

预览效果：
<div class="" style="background:#f5f5f5; border-radius:8px;">
文本内换行书写不会导致
换行

当前文本后加两个空格  
换行
</div>

### 强调

源码：
```text
**加粗**
*斜体*
***加粗斜体***
~~删除线~~
__加粗__
_斜体_

```

预览效果：

<div class="white-block" style="background:#f5f5f5; padding:16px; border-radius:8px; margin:16px 0;">

**加粗**  
*斜体*  
***加粗斜体***  
~~删除线~~  
__加粗__  
_斜体_  
 
</div>


### 引用

源码：
```text
> 创建块引用，在段落前加 > 符号

> 多个段落的引用
>
> 段落之间空行使用>

> 嵌套引用
>> 双层嵌套引用

> - 带有其他元素
> 1. 的引用
>
>
```

预览效果：

<div class="white-block" style="background:#f5f5f5; padding:16px; border-radius:8px; margin:16px 0;">

> 创建块引用，在段落前加>符号

> 多个段落
>
> 的引用

> 创建块引用，在段落前加 > 符号

> 多个段落的引用
>
> 段落之间空行使用>

> 嵌套引用
>> 双层嵌套引用

> - 带有其他元素
> 1. 的引用
>
>
</div>


### 列表
源码：
```text
1. 有
2. 序
3. 列
4. 表

----

1. 数字不代表循序
1. 任意数字
9. 都可
1. 以

- 无
- 序
- 列
- 表

* 也 
* 可以
* 使用
* \*


```

预览效果：

<div class="white-block" style="background:#f5f5f5; padding:16px; border-radius:8px; margin:16px 0;">

1. 有
2. 序
3. 列
4. 表  

----
       
1. 数字不代表循序
1. 任意数字
9. 都可
1. 以

- 无
- 序
- 列
- 表

* 也 
* 可以
* 使用
* \*

</div>


### 代码
源码：
```text

    `单词或短语包裹在反引号内`  
    ``双反引号中使用`单引号``

    代码块
    每行
    缩进
    至少4个空格


    ```bash
    使用```bash包裹代码块，
    可以高亮显示代码。

    ```

    ~~~text
    或者使用~~~包裹代码块，
    也可以高亮显示代码。

    ~~~

```

预览效果：

<div class="white-block" style="background:#f5f5f5; padding:16px; border-radius:8px; margin:16px 0;">

`单词或短语包裹在反引号内`  
``双反引号中使用`单引号``

    代码块
    每行
    缩进
    至少4个空格

```bash
使用```bash包裹代码块，
可以高亮显示代码。

```

~~~text
或者使用~~~包裹代码块，
也可以高亮显示代码。

~~~

</div>



### 分割线
源码：
```text
星号
***

mdbook破折号前必须是空行？

---

下划线
_________________
```

预览效果：

<div class="white-block" style="background:#f5f5f5; padding:16px; border-radius:8px; margin:16px 0;">

星号
***

mdbook破折号前必须是空行？

---

下划线
_________________

</div>



### 链接

源码：
```text
[mark语法学习链接](https://markdown.com.cn/ "鼠标悬停显示标题")  
<https://markdown.com.cn/>  
<75719591@qq.com>

[跳转到本地md文件](../ch1-mdbook使用技巧.md)

使用加粗[**mark语法学习链接**](https://markdown.com.cn/)  
使用斜体[*mark语法学习链接*](https://markdown.com.cn/)  
使用代码块[`mark语法学习链接`](https://markdown.com.cn/)  


[中间可以有空格] [1]  
[第二个方括号的值如下] [1]  
[第二个方括号的值如下] [2]  
[第二个方括号的值如下] [3]

[1]: https://markdown.com.cn/ 
[2]: <https://markdown.com.cn/>
[3]: https://markdown.com.cn/ "悬停标题"
```

预览效果：

<div class="white-block" style="background:#f5f5f5; padding:16px; border-radius:8px; margin:16px 0;">

[mark语法学习链接](https://markdown.com.cn/ "鼠标悬停显示标题")  
<https://markdown.com.cn/>  
<75719591@qq.com>

[跳转到本地md文件](../ch1-mdbook使用技巧.md)

使用加粗[**mark语法学习链接**](https://markdown.com.cn/)  
使用斜体[*mark语法学习链接*](https://markdown.com.cn/)  
使用代码块[`mark语法学习链接`](https://markdown.com.cn/)  


[中间可以有空格] [1]  
[第二个方括号的值如下] [1]  
[第二个方括号的值如下] [2]  
[第二个方括号的值如下] [3]

[1]: https://markdown.com.cn/ 
[2]: <https://markdown.com.cn/>
[3]: https://markdown.com.cn/ "悬停标题"

</div>

### 图片


源码：
```text

```

预览效果：

<div class="white-block" style="background:#f5f5f5; padding:16px; border-radius:8px; margin:16px 0;">

![alt text](assets/image.png "鼠标悬停标题")
![文件不存在时显示的文字]()  
可点击图片  
[![alt text](assets/image.png "可点击的图片")](https://markdown.com.cn/)
</div>

### 转移字符


源码：
```text

```

预览效果：

<div class="white-block" style="background:#f5f5f5; padding:16px; border-radius:8px; margin:16px 0;">

\`	  
\*	  
\_	  
\{ \}	    
\[ \]	     
\( \)	       
\#	    
\+	    
\-	    
\.	    
\!	   
\|

&copy;  


</div>

### 内嵌HTML标签

源码：
```text
This is a regular paragraph.

<table>
    <tr>
        <td>Foo</td>
        <td>Foo</td>
        <td>Foo</td>
    </tr>
    <tr>
        <td>Foo</td>
        <td>Foo</td>
        <td>Foo</td>
    </tr>
</table>

This is another regular paragraph.
```

预览效果：

<div class="white-block" style="background:#f5f5f5; padding:16px; border-radius:8px; margin:16px 0;">

This is a regular paragraph.

<table>
    <tr>
        <td>Foo</td>
        <td>Foo</td>
        <td>Foo</td>
    </tr>
    <tr>
        <td>Foo</td>
        <td>Foo</td>
        <td>Foo</td>
    </tr>
</table>

This is another regular paragraph.

</div>


## 扩展语法

### 表格
使用麻烦，可以使用[网站辅助生成表格](https://www.tablesgenerator.com/markdown_tables)

源码：
```text
| 左对齐 | 中间对齐 | 右对齐 |
| :--- | :---: | -----------: |
| [链接](https://markdown.com.cn/) | `代码块` | **加粗** |
| ![alt text](assets/image-1.png) | < 块引用不可用 | 换<br>行 |
```

预览效果：

<div class="white-block" style="background:#f5f5f5; padding:16px; border-radius:8px; margin:16px 0;">

| 左对齐 | 中间对齐 | 右对齐 |
| :--- | :---: | -----------: |
| [链接](https://markdown.com.cn/) | `代码块` | **加粗** |
| ![alt text](assets/image-1.png) | < 块引用 | 换<br>行 |



</div>


### 脚注
脚注会在页面最下方
源码：
```text
Here's a simple footnote,[^1] and here's a longer one.[^bignote]

[^1]: This is the first footnote.

[^bignote]: Here's one with multiple paragraphs and code.

    Indent paragraphs to include them in the footnote.

    `{ my code }`

    Add as many paragraphs as you like.
```

预览效果：

<div class="white-block" style="background:#f5f5f5; padding:16px; border-radius:8px; margin:16px 0;">

Here's a simple footnote,[^1] and here's a longer one.[^bignote]

[^1]: This is the first footnote.

[^bignote]: Here's one with multiple paragraphs and code.

    Indent paragraphs to include them in the footnote.

    `{ my code }`

    Add as many paragraphs as you like.

</div>

### 标题编号

源码：
```text

```

预览效果：

<div class="white-block" style="background:#f5f5f5; padding:16px; border-radius:8px; margin:16px 0;">

# 改标题的id为id1 {#id1}

[跳转到id为id1](#id1)      

[跳转网页的具体id处](../ch1-mdbook使用技巧.md#1)  



</div>

### 任务列表



源码：
```text
- [x] 已完成
- [ ] 未完成
```

预览效果：

<div class="white-block" style="background:#f5f5f5; padding:16px; border-radius:8px; margin:16px 0;">

- [x] 已完成
- [ ] 未完成


</div>

### 使用emoji表情


源码：
```text
😅🎊😎😑😒☺️☺️
:tent:
```

预览效果：

<div class="white-block" style="background:#f5f5f5; padding:16px; border-radius:8px; margin:16px 0;">

😅🎊😎😑😒☺️☺️   


</div>

