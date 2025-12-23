return {
    "tanvirtin/monokai.nvim",
    lazy = false,    -- 确保在启动时加载
    priority = 1000, -- 确保在其他插件之前加载
    config = function()
        vim.cmd("colorscheme monokai_pro")

        -- 强制将背景设置为 "NONE" (透明)
        -- vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
        -- vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
        -- vim.api.nvim_set_hl(0, "NormalNC", { bg = "none" })      -- 非当前窗口背景
        -- vim.api.nvim_set_hl(0, "NeoTreeNormal", { bg = "none" }) -- Neo-tree 背景
        -- vim.api.nvim_set_hl(0, "NeoTreeNormalNC", { bg = "none" })
        -- vim.api.nvim_set_hl(0, "BufferLineFill", { bg = "none" })
        -- vim.api.nvim_set_hl(0, "BufferLineBackground", { bg = "none" })
        -- vim.api.nvim_set_hl(0, "BufferLineSeparator", { bg = "none" })
        -- vim.api.nvim_set_hl(0, "BufferLineSeparatorSelected", { bg = "none" })
    end,
}
