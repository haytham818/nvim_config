return {
  "lukas-reineke/indent-blankline.nvim",
  main = "ibl", -- 指定加载的主模块 (v3 重要改动)
  event = { "BufReadPost", "BufNewFile" },
  opts = {
    -- 1. 缩进线的基本配置
    indent = {
      char = "│", -- 使用细竖线 (也可以用 "▏" 或 "┆")
      tab_char = "│",
    },

    -- 2. 当前作用域高亮 (Scope)
    -- 就是你光标在一个大函数里时，左侧会有一条亮线指示这个函数的范围
    scope = {
      enabled = true,
      show_start = false, -- 是否显示作用域顶部的横线 (个人建议关掉，太花哨)
      show_end = false,   -- 是否显示作用域底部的横线
    },

    -- 3. 排除配置 (非常重要！)
    -- 在这些窗口/文件类型中不要显示缩进线，否则会很丑
    exclude = {
      filetypes = {
        "help",
        "alpha",
        "dashboard",
        "neo-tree",
        "Trouble",
        "trouble",
        "lazy",
        "mason",
        "notify",
        "toggleterm",
        "lazyterm",
      },
    },
  },
}