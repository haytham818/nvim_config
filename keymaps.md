## 目录

- [基本导航 (Basic Navigation)](#基本导航-basic-navigation)
- [窗口管理 (Window Management)](#窗口管理-window-management)
- [缓冲区管理 (Buffer Management)](#缓冲区管理-buffer-management)
- [编辑操作 (Editing Operations)](#编辑操作-editing-operations)
- [文件保存 (File Saving)](#文件保存-file-saving)
- [LSP 功能 (LSP Features)](#lsp-功能-lsp-features)
- [插件键位 (Plugin Keymaps)](#插件键位-plugin-keymaps)
  - [文件浏览器 (Neo-tree)](#文件浏览器-neo-tree)
  - [模糊查找 (Telescope)](#模糊查找-telescope)
  - [Git 集成 (LazyGit)](#git-集成-lazygit)
  - [终端 (ToggleTerm)](#终端-toggleterm)
  - [代码格式化 (Conform)](#代码格式化-conform)
  - [注释 (Comment)](#注释-comment)
  - [环绕操作 (Surround)](#环绕操作-surround)
  - [快速跳转 (Flash)](#快速跳转-flash)
  - [会话管理 (Persistence)](#会话管理-persistence)
  - [书签管理 (Arrow)](#书签管理-arrow)
  - [数字递增 (Dial)](#数字递增-dial)
  - [文本对象 (Text Objects)](#文本对象-text-objects)
  - [剪贴板历史 (Yanky)](#剪贴板历史-yanky)
  - [Quickfix 增强 (Quicker)](#quickfix-增强-quicker)
  - [窗口聚焦 (Focus)](#窗口聚焦-focus)
  - [Markdown 预览 (Markview)](#markdown-预览-markview)
  - [动作提示 (Precognition)](#动作提示-precognition)
  - [诊断显示 (Corn)](#诊断显示-corn)
  - [按键提示 (Which-Key)](#按键提示-which-key)
- [Neovim 默认键位参考](#neovim-默认键位参考)

---

## Leader 键

- **Leader 键**: `Space` (空格键)
- **Local Leader 键**: `Space` (空格键)

---

## 基本导航 (Basic Navigation)

### Neovim 默认导航键位

| 键位     | 模式   | 功能                     |
| -------- | ------ | ------------------------ |
| `h`      | Normal | 向左移动                 |
| `j`      | Normal | 向下移动                 |
| `k`      | Normal | 向上移动                 |
| `l`      | Normal | 向右移动                 |
| `w`      | Normal | 移动到下一个单词开头     |
| `b`      | Normal | 移动到上一个单词开头     |
| `e`      | Normal | 移动到单词结尾           |
| `0`      | Normal | 移动到行首               |
| `^`      | Normal | 移动到行首第一个非空字符 |
| `$`      | Normal | 移动到行尾               |
| `gg`     | Normal | 移动到文件开头           |
| `G`      | Normal | 移动到文件结尾           |
| `{`      | Normal | 移动到上一段落           |
| `}`      | Normal | 移动到下一段落           |
| `%`      | Normal | 在匹配的括号间跳转       |
| `Ctrl-d` | Normal | 向下滚动半页             |
| `Ctrl-u` | Normal | 向上滚动半页             |
| `Ctrl-f` | Normal | 向下滚动一整页           |
| `Ctrl-b` | Normal | 向上滚动一整页           |

---

## 窗口管理 (Window Management)

### 自定义窗口导航

| 键位     | 模式   | 功能           |
| -------- | ------ | -------------- |
| `Ctrl-h` | Normal | 切换到左侧窗口 |
| `Ctrl-j` | Normal | 切换到下方窗口 |
| `Ctrl-k` | Normal | 切换到上方窗口 |
| `Ctrl-l` | Normal | 切换到右侧窗口 |

### 窗口大小调整

| 键位         | 模式   | 功能                |
| ------------ | ------ | ------------------- |
| `Ctrl-Up`    | Normal | 减小窗口高度 (2 行) |
| `Ctrl-Down`  | Normal | 增加窗口高度 (2 行) |
| `Ctrl-Left`  | Normal | 减小窗口宽度 (2 列) |
| `Ctrl-Right` | Normal | 增加窗口宽度 (2 列) |

### 窗口分割

| 键位         | 模式   | 功能                 |
| ------------ | ------ | -------------------- |
| `<leader>sv` | Normal | 垂直分割窗口         |
| `<leader>sh` | Normal | 水平分割窗口         |
| `<leader>se` | Normal | 使所有分割窗口等大小 |
| `<leader>sx` | Normal | 关闭当前分割窗口     |

### Neovim 默认窗口操作

| 键位       | 模式   | 功能             |
| ---------- | ------ | ---------------- |
| `Ctrl-w s` | Normal | 水平分割窗口     |
| `Ctrl-w v` | Normal | 垂直分割窗口     |
| `Ctrl-w q` | Normal | 关闭当前窗口     |
| `Ctrl-w o` | Normal | 只保留当前窗口   |
| `Ctrl-w =` | Normal | 均分所有窗口大小 |

---

## 缓冲区管理 (Buffer Management)

| 键位         | 模式   | 功能                            |
| ------------ | ------ | ------------------------------- |
| `Shift-l`    | Normal | 切换到下一个缓冲区              |
| `Shift-h`    | Normal | 切换到上一个缓冲区              |
| `[b`         | Normal | 切换到上一个缓冲区 (BufferLine) |
| `]b`         | Normal | 切换到下一个缓冲区 (BufferLine) |
| `<leader>bd` | Normal | 删除当前缓冲区                  |
| `<leader>bp` | Normal | 固定/取消固定当前标签           |
| `<leader>bP` | Normal | 关闭所有非固定标签              |
| `<leader>bo` | Normal | 关闭其他标签                    |
| `<leader>br` | Normal | 关闭右侧所有标签                |
| `<leader>bl` | Normal | 关闭左侧所有标签                |

---

## 编辑操作 (Editing Operations)

### Neovim 默认编辑键位

| 键位     | 模式   | 功能                 |
| -------- | ------ | -------------------- |
| `i`      | Normal | 在光标前插入         |
| `a`      | Normal | 在光标后插入         |
| `I`      | Normal | 在行首插入           |
| `A`      | Normal | 在行尾插入           |
| `o`      | Normal | 在下方新建一行并插入 |
| `O`      | Normal | 在上方新建一行并插入 |
| `x`      | Normal | 删除光标下的字符     |
| `dd`     | Normal | 删除整行             |
| `D`      | Normal | 删除到行尾           |
| `cc`     | Normal | 修改整行             |
| `C`      | Normal | 修改到行尾           |
| `yy`     | Normal | 复制整行             |
| `p`      | Normal | 在光标后粘贴         |
| `P`      | Normal | 在光标前粘贴         |
| `u`      | Normal | 撤销                 |
| `Ctrl-r` | Normal | 重做                 |
| `.`      | Normal | 重复上一次操作       |

### 自定义编辑操作

| 键位    | 模式   | 功能                     |
| ------- | ------ | ------------------------ |
| `Alt-j` | Normal | 向下移动当前行           |
| `Alt-k` | Normal | 向上移动当前行           |
| `Alt-j` | Visual | 向下移动选中的行         |
| `Alt-k` | Visual | 向上移动选中的行         |
| `<`     | Visual | 向左缩进并保持选择       |
| `>`     | Visual | 向右缩进并保持选择       |
| `p`     | Visual | 粘贴但不复制被替换的文本 |
| `Esc`   | Normal | 清除搜索高亮             |

---

## 文件保存 (File Saving)

| 键位     | 模式   | 功能                      |
| -------- | ------ | ------------------------- |
| `Ctrl-s` | Normal | 保存文件                  |
| `Ctrl-s` | Insert | 保存文件 (保持在插入模式) |
| `Ctrl-s` | Visual | 保存文件                  |

---

## LSP 功能 (LSP Features)

当 LSP 附加到缓冲区时，以下键位可用：

| 键位         | 模式   | 功能                       |
| ------------ | ------ | -------------------------- |
| `gd`         | Normal | 跳转到定义                 |
| `gD`         | Normal | 跳转到声明                 |
| `gr`         | Normal | 查找引用                   |
| `gi`         | Normal | 跳转到实现                 |
| `K`          | Normal | 显示悬停文档               |
| `<leader>rn` | Normal | 重命名符号                 |
| `<leader>ca` | Normal | 代码操作                   |
| `<leader>th` | Normal | 切换内联提示 (Inlay Hints) |

### 诊断 (Diagnostics)

| 键位        | 模式   | 功能                         |
| ----------- | ------ | ---------------------------- |
| `[d`        | Normal | 跳转到上一个诊断             |
| `]d`        | Normal | 跳转到下一个诊断             |
| `<leader>d` | Normal | 打开诊断浮窗                 |
| `<leader>q` | Normal | 打开诊断列表 (location list) |

---

## 插件键位 (Plugin Keymaps)

### 文件浏览器 (Neo-tree)

| 键位        | 模式   | 功能           |
| ----------- | ------ | -------------- |
| `<leader>e` | Normal | 切换文件浏览器 |

**Neo-tree 内部键位**:

- `l` - 打开文件/文件夹
- `h` - 收起文件夹
- `Space` - 无操作 (已解除绑定)

---

### 模糊查找 (Telescope)

| 键位         | 模式   | 功能                    |
| ------------ | ------ | ----------------------- |
| `<leader>ff` | Normal | 查找文件                |
| `<leader>fg` | Normal | 全局搜索 (需要 ripgrep) |
| `<leader>fb` | Normal | 查找缓冲区              |
| `<leader>fh` | Normal | 查找帮助文档            |
| `<leader>y`  | Normal | 打开剪贴板历史 (Yanky)  |

**Telescope 窗口内键位**:

- `Ctrl-n` / `Down` - 选择下一项
- `Ctrl-p` / `Up` - 选择上一项
- `Ctrl-c` / `Esc` - 关闭 Telescope
- `Enter` - 确认选择

---

### Git 集成 (LazyGit)

| 键位         | 模式   | 功能         |
| ------------ | ------ | ------------ |
| `<leader>lg` | Normal | 打开 LazyGit |

---

### 终端 (ToggleTerm)

| 键位     | 模式     | 功能                   |
| -------- | -------- | ---------------------- |
| `Ctrl-\` | Normal   | 切换终端               |
| `Esc`    | Terminal | 退出终端模式到普通模式 |
| `Ctrl-h` | Terminal | 切换到左侧窗口         |
| `Ctrl-j` | Terminal | 切换到下方窗口         |
| `Ctrl-k` | Terminal | 切换到上方窗口         |
| `Ctrl-l` | Terminal | 切换到右侧窗口         |

---

### 代码格式化 (Conform)

| 键位         | 模式           | 功能                  |
| ------------ | -------------- | --------------------- |
| `<leader>cf` | Normal, Visual | 格式化当前缓冲区/选择 |

**命令**:

- `:FormatToggle` - 切换保存时自动格式化

---

### 注释 (Comment)

| 键位         | 模式   | 功能                                |
| ------------ | ------ | ----------------------------------- |
| `gcc`        | Normal | 切换当前行注释                      |
| `gbc`        | Normal | 切换当前行块注释                    |
| `gc{motion}` | Normal | 注释指定范围 (如 `gc2j` 注释下两行) |
| `gb{motion}` | Normal | 块注释指定范围                      |
| `gc`         | Visual | 切换选中行的注释                    |
| `gb`         | Visual | 切换选中行的块注释                  |

---

### 环绕操作 (Surround)

nvim-surround 提供了强大的环绕操作功能：

| 键位               | 模式   | 功能                   | 示例                        |
| ------------------ | ------ | ---------------------- | --------------------------- |
| `ys{motion}{char}` | Normal | 添加环绕               | `ysiw"` - 给单词加双引号    |
| `yss{char}`        | Normal | 给整行添加环绕         | `yss)` - 给整行加括号       |
| `ds{char}`         | Normal | 删除环绕               | `ds"` - 删除双引号          |
| `cs{old}{new}`     | Normal | 修改环绕               | `cs"'` - 把双引号改成单引号 |
| `S{char}`          | Visual | 在选中文本周围添加环绕 | 选中后按 `S"` 加双引号      |

**常用环绕字符**:

- `"` - 双引号
- `'` - 单引号
- `` ` `` - 反引号
- `(` 或 `)` - 括号 (有无空格)
- `[` 或 `]` - 方括号
- `{` 或 `}` - 花括号
- `<` 或 `>` - 尖括号
- `t` - HTML/XML 标签

---

### 快速跳转 (Flash)

| 键位 | 模式                     | 功能         |
| ---- | ------------------------ | ------------ |
| `s`  | Normal, Visual, Operator | 触发快速跳转 |

使用方法: 按 `s` 后输入目标字符，屏幕上会显示标签，输入标签即可跳转。

---

### 会话管理 (Persistence)

| 键位         | 模式   | 功能     |
| ------------ | ------ | -------- |
| `<leader>rs` | Normal | 恢复会话 |

---

### 书签管理 (Arrow)

| 键位        | 模式   | 功能                  |
| ----------- | ------ | --------------------- |
| `;`         | Normal | 打开 Arrow 菜单       |
| `m`         | Normal | 标记/取消标记当前文件 |
| `;1` - `;9` | Normal | 跳转到对应编号的书签  |

---

### 数字递增 (Dial)

增强版的 Ctrl-a 和 Ctrl-x，支持更多类型：

| 键位       | 模式   | 功能                   |
| ---------- | ------ | ---------------------- |
| `Ctrl-a`   | Normal | 递增数字/日期/布尔值等 |
| `Ctrl-x`   | Normal | 递减数字/日期/布尔值等 |
| `g Ctrl-a` | Normal | 递增 (扩展模式)        |
| `g Ctrl-x` | Normal | 递减 (扩展模式)        |
| `Ctrl-a`   | Visual | 递增选中内容           |
| `Ctrl-x`   | Visual | 递减选中内容           |

**支持的类型**:

- 十进制数字 (0, 1, 2...)
- 十六进制 (0x1f, 0xA...)
- 日期 (2023/12/23, 2023-12-23)
- 时间 (14:30)
- 布尔值 (true ↔ false)
- 逻辑运算符 (&& ↔ ||)
- 变量声明 (let ↔ const)
- CSS 颜色 (#ffffff)
- 大小写转换 (camelCase ↔ snake_case ↔ PascalCase)

---

### 文本对象 (Text Objects)

扩展的文本对象，用于更精确的编辑：

| 键位 | 模式             | 功能                    | 示例               |
| ---- | ---------------- | ----------------------- | ------------------ |
| `ii` | Operator, Visual | 选中当前缩进级别 (内部) | `dii` 删除缩进块   |
| `ai` | Operator, Visual | 选中当前缩进级别 (外部) | `vai` 选择缩进块   |
| `gG` | Operator, Visual | 选中整个缓冲区          | `ygG` 复制全文件   |
| `S`  | Operator, Visual | 选中子单词 (驼峰命名)   | `ciS` 修改驼峰单词 |
| `L`  | Operator, Visual | 选中 URL 链接           | `dL` 删除链接      |
| `!`  | Operator, Visual | 选中诊断区域            | `c!` 修改报错区域  |
| `V`  | Operator, Visual | 选中屏幕可见内容        | `yV` 复制可见内容  |
| `ik` | Operator, Visual | 选中键 (key)            | `cik` 修改键名     |
| `iv` | Operator, Visual | 选中值 (value)          | `civ` 修改值       |
| `n`  | Operator, Visual | 选中数字                | `cn` 修改数字      |
| `ax` | Operator, Visual | 选中 HTML 属性 (外部)   | `dax` 删除属性     |
| `ix` | Operator, Visual | 选中 HTML 属性 (内部)   | `cix` 修改属性值   |
| `iq` | Operator, Visual | 选中任意引号内容 (内部) | `ciq` 修改引号内容 |
| `aq` | Operator, Visual | 选中任意引号内容 (外部) | `daq` 删除包括引号 |

---

### 剪贴板历史 (Yanky)

增强的复制粘贴功能，带历史记录：

| 键位        | 模式           | 功能                              |
| ----------- | -------------- | --------------------------------- |
| `p`         | Normal, Visual | 在光标后粘贴                      |
| `P`         | Normal, Visual | 在光标前粘贴                      |
| `gp`        | Normal, Visual | 粘贴后光标移到文本后              |
| `gP`        | Normal, Visual | 粘贴前光标移到文本后              |
| `Ctrl-n`    | Normal         | 循环到下一个历史记录 (粘贴后使用) |
| `Ctrl-p`    | Normal         | 循环到上一个历史记录 (粘贴后使用) |
| `<leader>y` | Normal         | 打开剪贴板历史 (Telescope)        |

**使用方法**:

1. 正常复制 (`yy`, `yiw` 等)
2. 粘贴 (`p`)
3. 如果不是想要的内容，按 `Ctrl-n` 或 `Ctrl-p` 切换历史记录

---

### Quickfix 增强 (Quicker)

| 键位        | 模式   | 功能                    |
| ----------- | ------ | ----------------------- |
| `<leader>q` | Normal | 切换 Quickfix 窗口      |
| `<leader>l` | Normal | 切换 Location List 窗口 |

**Quickfix 窗口内键位**:

- `>` - 展开上下文
- `<` - 折叠上下文

---

### 窗口聚焦 (Focus)

自动调整窗口大小，突出当前窗口：

| 键位         | 模式   | 功能                          |
| ------------ | ------ | ----------------------------- |
| `<leader>wf` | Normal | 切换自动聚焦                  |
| `<leader>w=` | Normal | 均分所有窗口                  |
| `<leader>wm` | Normal | 最大化当前窗口                |
| `Ctrl-h`     | Normal | 分割并跳转到左侧 (Focus 版本) |
| `Ctrl-l`     | Normal | 分割并跳转到右侧 (Focus 版本) |
| `Ctrl-j`     | Normal | 分割并跳转到下方 (Focus 版本) |
| `Ctrl-k`     | Normal | 分割并跳转到上方 (Focus 版本) |

**注意**: Focus 的 Ctrl 键与窗口导航键冲突，建议根据需要选择其一。

---

### Markdown 预览 (Markview)

| 键位         | 模式   | 功能               |
| ------------ | ------ | ------------------ |
| `<leader>mp` | Normal | 切换 Markdown 预览 |

---

### 动作提示 (Precognition)

显示可用的 Vim 动作提示：

| 键位         | 模式   | 功能         |
| ------------ | ------ | ------------ |
| `<leader>cp` | Normal | 切换动作提示 |

---

### 诊断显示 (Corn)

在角落显示诊断信息：

| 键位         | 模式   | 功能                     |
| ------------ | ------ | ------------------------ |
| `<leader>cd` | Normal | 切换 Corn 诊断显示       |
| `<leader>cs` | Normal | 循环切换作用域 (行/文件) |
| `<leader>cr` | Normal | 刷新 Corn                |

---

### 按键提示 (Which-Key)

| 键位        | 模式   | 功能                   |
| ----------- | ------ | ---------------------- |
| `<leader>?` | Normal | 显示缓冲区本地键位映射 |

**自动触发**:

- 按下前缀键 (如 `<leader>`, `g`, `z` 等) 后等待 200ms 会自动显示可用的键位

---

## Neovim 默认键位参考

### 文本对象 (默认)

文本对象用于更精确的选择和操作：

| 键位         | 功能                     | 示例                     |
| ------------ | ------------------------ | ------------------------ |
| `iw`         | 选中单词 (内部)          | `ciw` 修改单词           |
| `aw`         | 选中单词 (包括空格)      | `daw` 删除单词           |
| `iW`         | 选中大单词 (内部)        | `ciW` 修改大单词         |
| `aW`         | 选中大单词 (包括空格)    | `daW` 删除大单词         |
| `is`         | 选中句子 (内部)          | `cis` 修改句子           |
| `as`         | 选中句子 (包括空格)      | `das` 删除句子           |
| `ip`         | 选中段落 (内部)          | `cip` 修改段落           |
| `ap`         | 选中段落 (包括空行)      | `dap` 删除段落           |
| `i"`         | 选中双引号内容           | `ci"` 修改引号内容       |
| `a"`         | 选中双引号及内容         | `da"` 删除引号及内容     |
| `i'`         | 选中单引号内容           | `ci'` 修改引号内容       |
| `a'`         | 选中单引号及内容         | `da'` 删除引号及内容     |
| `` i` ``     | 选中反引号内容           | `` ci` `` 修改引号内容   |
| `` a` ``     | 选中反引号及内容         | `` da` `` 删除引号及内容 |
| `i(` 或 `ib` | 选中括号内容             | `ci(` 修改括号内容       |
| `a(` 或 `ab` | 选中括号及内容           | `da(` 删除括号及内容     |
| `i{` 或 `iB` | 选中花括号内容           | `ci{` 修改花括号内容     |
| `a{` 或 `aB` | 选中花括号及内容         | `da{` 删除花括号及内容   |
| `i[`         | 选中方括号内容           | `ci[` 修改方括号内容     |
| `a[`         | 选中方括号及内容         | `da[` 删除方括号及内容   |
| `i<`         | 选中尖括号内容           | `ci<` 修改尖括号内容     |
| `a<`         | 选中尖括号及内容         | `da<` 删除尖括号及内容   |
| `it`         | 选中 HTML/XML 标签内容   | `cit` 修改标签内容       |
| `at`         | 选中 HTML/XML 标签及内容 | `dat` 删除标签及内容     |

### 搜索和替换

| 键位             | 模式   | 功能                      |
| ---------------- | ------ | ------------------------- |
| `/pattern`       | Normal | 向前搜索                  |
| `?pattern`       | Normal | 向后搜索                  |
| `n`              | Normal | 跳转到下一个匹配          |
| `N`              | Normal | 跳转到上一个匹配          |
| `*`              | Normal | 向前搜索光标下的单词      |
| `#`              | Normal | 向后搜索光标下的单词      |
| `:s/old/new/`    | Normal | 替换当前行第一个匹配      |
| `:s/old/new/g`   | Normal | 替换当前行所有匹配        |
| `:%s/old/new/g`  | Normal | 替换全文件所有匹配        |
| `:%s/old/new/gc` | Normal | 替换全文件所有匹配 (确认) |

### 标记 (Marks)

| 键位          | 模式   | 功能                   |
| ------------- | ------ | ---------------------- |
| `m{a-z}`      | Normal | 设置标记 (局部)        |
| `m{A-Z}`      | Normal | 设置标记 (全局)        |
| `` `{mark} `` | Normal | 跳转到标记位置         |
| `'{mark}`     | Normal | 跳转到标记所在行的行首 |
| `` `. ``      | Normal | 跳转到最后修改位置     |
| `'.`          | Normal | 跳转到最后修改行       |
| `:marks`      | Normal | 显示所有标记           |

### 寄存器 (Registers)

| 键位          | 功能               |
| ------------- | ------------------ |
| `"{register}` | 使用指定寄存器     |
| `""`          | 默认寄存器         |
| `"0`          | 最近一次复制的内容 |
| `"1-"9`       | 最近删除的内容历史 |
| `"+`          | 系统剪贴板         |
| `"*`          | 系统选择           |
| `"/`          | 最后搜索的模式     |
| `":`          | 最后执行的命令     |
| `".`          | 最后插入的文本     |
| `"%`          | 当前文件名         |
| `"_`          | 黑洞寄存器 (丢弃)  |
| `:reg`        | 显示所有寄存器内容 |

### 宏 (Macros)

| 键位            | 模式   | 功能               |
| --------------- | ------ | ------------------ |
| `q{a-z}`        | Normal | 开始录制宏到寄存器 |
| `q`             | Normal | 停止录制宏         |
| `@{a-z}`        | Normal | 执行宏             |
| `@@`            | Normal | 重复执行上一个宏   |
| `{count}@{a-z}` | Normal | 执行宏 N 次        |

### 折叠 (Folding)

| 键位         | 模式   | 功能         |
| ------------ | ------ | ------------ |
| `zf{motion}` | Normal | 创建折叠     |
| `zo`         | Normal | 打开折叠     |
| `zc`         | Normal | 关闭折叠     |
| `za`         | Normal | 切换折叠     |
| `zR`         | Normal | 打开所有折叠 |
| `zM`         | Normal | 关闭所有折叠 |
| `zd`         | Normal | 删除折叠     |
| `zE`         | Normal | 删除所有折叠 |

### 可视模式

| 键位     | 模式   | 功能                            |
| -------- | ------ | ------------------------------- |
| `v`      | Normal | 字符可视模式                    |
| `V`      | Normal | 行可视模式                      |
| `Ctrl-v` | Normal | 块可视模式                      |
| `gv`     | Normal | 重新选择上次的可视选择          |
| `o`      | Visual | 切换光标到选择的另一端          |
| `O`      | Visual | 切换光标到选择的另一角 (块模式) |

### 其他有用的键位

| 键位                | 模式   | 功能                             |
| ------------------- | ------ | -------------------------------- |
| `Ctrl-o`            | Normal | 跳转到上一个位置                 |
| `Ctrl-i`            | Normal | 跳转到下一个位置                 |
| `gi`                | Normal | 跳转到最后插入位置并进入插入模式 |
| `gf`                | Normal | 打开光标下的文件                 |
| `gx`                | Normal | 用系统程序打开光标下的 URL       |
| `J`                 | Normal | 合并下一行                       |
| `~`                 | Normal | 切换大小写                       |
| `gu{motion}`        | Normal | 转换为小写                       |
| `gU{motion}`        | Normal | 转换为大写                       |
| `>>`                | Normal | 向右缩进                         |
| `<<`                | Normal | 向左缩进                         |
| `==`                | Normal | 自动缩进当前行                   |
| `Ctrl-a`            | Insert | 插入上次插入的文本               |
| `Ctrl-r {register}` | Insert | 插入寄存器内容                   |

---

## 自动补全 (Blink.cmp)

补全菜单激活时的键位：

| 键位              | 功能                        |
| ----------------- | --------------------------- |
| `Tab`             | 选择下一项 (super-tab 模式) |
| `Shift-Tab`       | 选择上一项 (super-tab 模式) |
| `Ctrl-n` / `Down` | 选择下一项                  |
| `Ctrl-p` / `Up`   | 选择上一项                  |
| `Ctrl-Space`      | 打开菜单或打开文档          |
| `Ctrl-e`          | 隐藏菜单                    |
| `Ctrl-b`          | 向上滚动文档                |
| `Ctrl-f`          | 向下滚动文档                |
| `Ctrl-k`          | 切换签名帮助                |
| `Enter`           | 确认选择                    |

---

## 快捷命令参考

### 文件操作

- `:w` - 保存文件
- `:q` - 退出
- `:wq` 或 `:x` - 保存并退出
- `:q!` - 强制退出不保存
- `:e {file}` - 打开文件
- `:saveas {file}` - 另存为

### 缓冲区操作

- `:ls` 或 `:buffers` - 列出所有缓冲区
- `:b {number}` - 切换到指定缓冲区
- `:bd` - 删除当前缓冲区
- `:bn` - 下一个缓冲区
- `:bp` - 上一个缓冲区

### 窗口操作

- `:split` 或 `:sp` - 水平分割
- `:vsplit` 或 `:vsp` - 垂直分割
- `:only` - 只保留当前窗口
- `:close` - 关闭当前窗口

### LSP 命令

- `:LspInfo` - 显示 LSP 信息
- `:LspStart` - 启动 LSP
- `:LspStop` - 停止 LSP
- `:LspRestart` - 重启 LSP

### 插件管理 (Lazy.nvim)

- `:Lazy` - 打开 Lazy 面板
- `:Lazy sync` - 同步插件 (安装/更新/清理)
- `:Lazy update` - 更新插件
- `:Lazy clean` - 清理未使用的插件

### Mason (LSP/工具管理)

- `:Mason` - 打开 Mason 面板
- `:MasonUpdate` - 更新 Mason
- `:MasonInstall {package}` - 安装包
- `:MasonUninstall {package}` - 卸载包

### Telescope 命令

- `:Telescope find_files` - 查找文件
- `:Telescope live_grep` - 全局搜索
- `:Telescope buffers` - 查找缓冲区
- `:Telescope help_tags` - 查找帮助
- `:TodoTelescope` - 搜索所有 TODO 注释

### 其他有用命令

- `:FormatToggle` - 切换保存时自动格式化
- `:ConformInfo` - 显示格式化工具信息
- `:Neotree` - 打开文件树
- `:LazyGit` - 打开 LazyGit

---

_最后更新: 2025-12-23_
_Neovim 版本: 0.10+_
