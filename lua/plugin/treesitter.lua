return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate", -- 安装/更新插件时，自动更新语法解析器
	event = { "BufReadPost", "BufNewFile" }, -- 打开文件时才加载，提升启动速度
	vscode = true,
	config = function()
		require("nvim-treesitter.configs").setup({
			-- 1. 确保安装的语言解析器
			ensure_installed = {
				"bash",
				"c",
				"cpp", -- C++
				"c_sharp", -- C# (Unity/Godot)
				"rust", -- Rust
				"lua", -- Neovim 配置文件本身
				"vim",
				"vimdoc",
				"query",
				"markdown",
				"markdown_inline",
				"dockerfile", -- Docker
				"json",
				"yaml",
				"toml",
				"cmake", -- C++ 项目常用
				"glsl",
				"python",
				-- Web development
				"html",
				"css",
				"javascript",
				"typescript",
				"tsx",
				-- Data formats
				"xml",
				"diff",
				"git_config",
				"git_rebase",
				"gitcommit",
				"gitignore",
			},

			-- 2. 同步安装 (false 表示异步，防止卡顿)
			sync_install = false,

			-- 3. 自动安装缺失的解析器
			-- 当你打开一个没有安装解析器的文件时，自动下载
			auto_install = true,

			-- 4. 启用代码高亮 (核心功能)
			-- 在 VSCode 中禁用高亮，由 VSCode 处理
			highlight = {
				enable = not vim.g.vscode,
				-- 针对某些大文件禁用高亮，防止卡顿
				disable = function(lang, buf)
					local max_filesize = 100 * 1024 -- 100 KB
					local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
					if ok and stats and stats.size > max_filesize then
						return true
					end
				end,
				-- 兼容 Vim 的正则语法高亮 (通常设为 true 效果更好)
				additional_vim_regex_highlighting = false,
			},

			-- 5. 启用基于 Treesitter 的缩进
			-- 这通常比 Vim 默认的缩进更智能
			indent = {
				enable = true,
			},

			-- 6. 增量选择 (非常实用的功能！)
			-- 允许你通过按键逐步扩大选区 (例如：从单词 -> 参数 -> 函数 -> 整个类)
			incremental_selection = {
				enable = true,
				keymaps = {
					init_selection = "<CR>", -- 开始选择：回车键
					node_incremental = "<CR>", -- 扩大选区：回车键
					scope_incremental = "<TAB>", -- 选择当前作用域：Tab 键
					node_decremental = "<BS>", -- 缩小选区：退格键
				},
			},
		})
	end,
}
