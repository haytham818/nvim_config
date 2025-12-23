# Neovim 配置

## 和Neovim战斗数天，最终在G大人的帮助下勉强战胜

### ✨ 最新改进 (Recent Improvements)

- ✅ **跨平台兼容性**: 自动检测并配置 PowerShell (Windows) 或默认 shell
- ✅ **完善的 LSP 集成**: Mason + Mason-LSPConfig 自动安装和配置 LSP 服务器
- ✅ **增强的键位映射**: 添加了缓冲区导航、分屏管理、诊断导航等实用快捷键
- ✅ **性能优化**: Telescope 集成 fzf-native 扩展，提升搜索性能
- ✅ **更好的编辑体验**: 持久化撤销、智能缩进、滚动偏移等配置优化
- ✅ **自动格式化控制**: 添加 `:FormatToggle` 命令快速开关自动格式化

### 📦 插件列表 (Plugin List)

#### 🎨 UI 与外观 (UI & Aesthetics)

| 插件名称             | 配置文件                            | 仓库链接                                                         | 简介                                     |
| -------------------- | ----------------------------------- | ---------------------------------------------------------------- | ---------------------------------------- |
| **Gruvbox Material** | [Config](lua/plugin/gruvboxmat.lua) | [Github](https://github.com/sainnhe/gruvbox-material)            | 配色方案，暖色调复古风格                 |
| **Noice.nvim**       | [Config](lua/plugin/noice.lua)      | [Github](https://github.com/folke/noice.nvim)                    | UI 改造，接管命令行、通知弹窗和 LSP 消息 |
| **Lualine.nvim**     | [Config](lua/plugin/lualine.lua)    | [Github](https://github.com/nvim-lualine/lualine.nvim)           | 底部状态栏，集成 Git、LSP 和 Arrow 状态  |
| **Bufferline.nvim**  | [Config](lua/plugin/bufferline.lua) | [Github](https://github.com/akinsho/bufferline.nvim)             | 顶部标签页/Buffer 栏                     |
| **Indent Blankline** | [Config](lua/plugin/blankline.lua)  | [Github](https://github.com/lukas-reineke/indent-blankline.nvim) | 显示代码缩进参考线                       |
| **Focus.nvim**       | [Config](lua/plugin/focus.lua)      | [Github](https://github.com/nvim-focus/focus.nvim)               | 自动调整窗口大小，放大当前聚焦的窗口     |
| **Markview.nvim**    | [Config](lua/plugin/markview.lua)   | [Github](https://github.com/OXY2DEV/markview.nvim)               | 实时渲染 Markdown 标题、表格和复选框     |
| **Which-Key.nvim**   | [Config](lua/plugin/whichkey.lua)   | [Github](https://github.com/folke/which-key.nvim)                | 按键映射提示弹窗，助记快捷键             |

#### 🧠 代码智能与 LSP (LSP & Completion)

| 插件名称         | 配置文件                           | 仓库链接                                             | 简介                                      |
| ---------------- | ---------------------------------- | ---------------------------------------------------- | ----------------------------------------- |
| **Blink.cmp**    | [Config](lua/plugin/blinkcmp.lua)  | [Github](https://github.com/saghen/blink.cmp)        | 基于 Rust 的高性能自动补全引擎            |
| **Mason.nvim**   | [Config](lua/plugin/mason.lua)     | [Github](https://github.com/williamboman/mason.nvim) | LSP、DAP、Linter 和 Formatter 的包管理器  |
| **Conform.nvim** | [Config](lua/plugin/conform.lua)   | [Github](https://github.com/stevearc/conform.nvim)   | 轻量级代码格式化工具 (支持多种语言)       |
| **LuaSnip**      | [Config](lua/plugin/luasnip.lua)   | [Github](https://github.com/L3MON4D3/LuaSnip)        | 代码片段引擎，配合 Friendly Snippets 使用 |
| **Corn.nvim**    | [Config](lua/plugin/corn.lua)      | [Github](https://github.com/RaafatTurki/corn.nvim)   | 优化 LSP 诊断信息的显示，保持界面整洁     |
| **Inc-Rename**   | [Config](lua/plugin/increname.lua) | [Github](https://github.com/smjonas/inc-rename.nvim) | 重命名时提供实时预览                      |

#### 🔭 导航与文件管理 (Navigation)

| 插件名称           | 配置文件                           | 仓库链接                                                   | 简介                            |
| ------------------ | ---------------------------------- | ---------------------------------------------------------- | ------------------------------- |
| **Telescope.nvim** | [Config](lua/plugin/telescope.lua) | [Github](https://github.com/nvim-telescope/telescope.nvim) | 模糊查找器 (文件、文本、Git 等) |
| **Neo-tree.nvim**  | [Config](lua/plugin/neotree.lua)   | [Github](https://github.com/nvim-neo-tree/neo-tree.nvim)   | 侧边栏文件资源管理器            |
| **Flash.nvim**     | [Config](lua/plugin/flash.lua)     | [Github](https://github.com/folke/flash.nvim)              | 跳转插件                        |
| **Arrow.nvim**     | [Config](lua/plugin/arrow.lua)     | [Github](https://github.com/otavioschwanck/arrow.nvim)     | 书签式文件跳转，支持状态栏显示  |
| **Grapple.nvim**   | [Config](lua/plugin/grapple.lua)   | [Github](https://github.com/cbochs/grapple.nvim)           | 文件标记与切换工具              |
| **Quicker.nvim**   | [Config](lua/plugin/quicker.lua)   | [Github](https://github.com/stevearc/quicker.nvim)         | 增强版 Quickfix 窗口，支持编辑  |

#### 📝 编辑体验增强 (Editing Tools)

| 插件名称             | 配置文件                              | 仓库链接                                                        | 简介                                              |
| -------------------- | ------------------------------------- | --------------------------------------------------------------- | ------------------------------------------------- |
| **Nvim-Treesitter**  | [Config](lua/plugin/treesitter.lua)   | [Github](https://github.com/nvim-treesitter/nvim-treesitter)    | 语法高亮、缩进和增量选择的核心库                  |
| **Nvim-Autopairs**   | [Config](lua/plugin/autopairs.lua)    | [Github](https://github.com/windwp/nvim-autopairs)              | 自动补全括号和引号                                |
| **Nvim-TS-Autotag**  | [Config](lua/plugin/autotag.lua)      | [Github](https://github.com/windwp/nvim-ts-autotag)             | 自动闭合和重命名 HTML/XML 标签                    |
| **Nvim-Surround**    | [Config](lua/plugin/surround.lua)     | [Github](https://github.com/kylechui/nvim-surround)             | 快速修改、添加或删除周围的成对符号                |
| **Comment.nvim**     | [Config](lua/plugin/comment.lua)      | [Github](https://github.com/numToStr/Comment.nvim)              | 快速注释/反注释代码                               |
| **Todo-Comments**    | [Config](lua/plugin/todo.lua)         | [Github](https://github.com/folke/todo-comments.nvim)           | 高亮并查找 TODO、FIXME 等注释标签                 |
| **Yanky.nvim**       | [Config](lua/plugin/yanky.lua)        | [Github](https://github.com/gbprod/yanky.nvim)                  | 剪贴板历史管理与循环粘贴                          |
| **Dial.nvim**        | [Config](lua/plugin/dial.lua)         | [Github](https://github.com/monaqa/dial.nvim)                   | 增强的数字/日期/布尔值增减功能 (`<C-a>/<C-x>`)    |
| **Various Textobjs** | [Config](lua/plugin/textobjs.lua)     | [Github](https://github.com/chrisgrieser/nvim-various-textobjs) | 增加数十种自定义文本对象 (如缩进、URL、Key-Value) |
| **Precognition**     | [Config](lua/plugin/precognition.lua) | [Github](https://github.com/tris203/precognition.nvim)          | Vim 动作提示动                                    |

#### 🛠️ 工具与集成 (Utils & Integration)

| 插件名称             | 配置文件                             | 仓库链接                                             | 简介                     |
| -------------------- | ------------------------------------ | ---------------------------------------------------- | ------------------------ |
| **Lazy.nvim**        | [Config](lua/plugin/plugins.lua)     | [Github](https://github.com/folke/lazy.nvim)         | 插件管理器               |
| **Lazygit.nvim**     | [Config](lua/plugin/lazygit.lua)     | [Github](https://github.com/kdheepak/lazygit.nvim)   | 在 Neovim 中集成 LazyGit |
| **Toggleterm.nvim**  | [Config](lua/plugin/terminal.lua)    | [Github](https://github.com/akinsho/toggleterm.nvim) | 快速打开/隐藏浮动终端    |
| **Persistence.nvim** | [Config](lua/plugin/persistence.lua) | [Github](https://github.com/folke/persistence.nvim)  | 自动保存和恢复编辑会话   |

---

### ⚙️ 核心功能特性 (Key Features)

#### LSP 配置
- 自动安装常用 LSP 服务器（lua_ls, clangd, rust_analyzer, pyright, taplo）
- 为每个语言服务器提供优化配置
- Inlay Hints 支持（可通过 `<leader>th` 切换）
- 智能诊断信息显示（300ms 延迟）
- 完整的 LSP 快捷键：
  - `gd`: 跳转到定义
  - `gD`: 跳转到声明
  - `gi`: 跳转到实现
  - `gr`: 查看引用
  - `K`: 显示悬停文档
  - `<leader>ca`: 代码操作
  - `<space>rn`: 重命名符号

#### 代码补全
- 基于 Rust 的高性能补全引擎 (blink.cmp)
- 集成 LSP、snippets、buffer 和 path 补全源
- 智能括号自动补全
- 实时函数签名提示
- Super-tab 模式（Tab 接受补全）

#### 代码格式化
- 支持多种语言格式化器
- 保存时自动格式化
- 使用 `:FormatToggle` 快速开关自动格式化
- 手动格式化快捷键：`<leader>cf`

#### 编辑增强
- 自动保存（失去焦点时）
- 持久化撤销历史
- 智能相对行号（插入模式切换为绝对行号）
- Treesitter 语法高亮和智能缩进
- 增量选择（`<CR>` 扩大选区，`<BS>` 缩小选区）

#### 导航和搜索
- Telescope 模糊查找（集成 fzf-native 优化性能）
  - `<leader>ff`: 查找文件
  - `<leader>fg`: 全局搜索
  - `<leader>fb`: 查找缓冲区
  - `<leader>fh`: 搜索帮助文档
- Neo-tree 文件浏览器（`<leader>e` 切换）
- Flash 快速跳转
- Grapple 文件标记系统

#### 实用快捷键
- 窗口导航：`Ctrl+h/j/k/l`
- 缓冲区切换：`Shift+h/l`
- 分屏管理：`<leader>sv/sh/se/sx`
- 诊断导航：`[d/]d`
- 保存文件：`Ctrl+s`（Normal/Insert/Visual 模式）
- 移动文本：`Alt+j/k`（Normal/Visual 模式）

---

**其他可选主题 (Installed Themes):**

- [Monokai Pro](lua/plugin/monokai.lua)
- [OneDarkPro](lua/plugin/onedarkpro.lua)
- [Gruvbox (Original)](lua/plugin/gruvbox.lua)
