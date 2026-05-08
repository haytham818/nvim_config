-- ============================================================================
-- Neovide 完整配置清单
-- 所有可设置项及其默认值，按类型分组
-- 仅在 Neovide GUI 客户端下加载
-- 参考: https://neovide.dev/configuration.html
-- ============================================================================

if not vim.g.neovide then
	return
end

-- ==========================================================================
-- 字体 & 排版
-- ==========================================================================

-- 字体配置已移至 ~/.config/neovide/config.toml 的 [font] 块
-- config.toml 支持独立指定 normal/bold/italic/bold_italic + features
-- 如果要用 guifont 替代，取消下面注释：
-- vim.o.guifont = "BerkeleyMono Nerd Font Mono,LXGW WenKai Mono Medium:h14:#e-subpixelantialias"

-- 行间距
vim.opt.linespace = 1.2

-- 全局缩放系数（× OS 缩放 × 字体大小）
-- vim.g.neovide_scale_factor = 1.0

-- 文本 Gamma（0.0 = sRGB 2.2）
-- -- vim.g.neovide_text_gamma = 0.0

-- 文本对比度
-- vim.g.neovide_text_contrast = 0.5

-- 子像素几何（配合 guifont #e-subpixelantialias 使用）
-- 可选: "RGBH" | "BGRH" | "RGBV" | "BGRV" | "Unknown"
vim.g.neovide_pixel_geometry = "RGBH"

-- ==========================================================================
-- 内边距 & 布局
-- ==========================================================================

-- 四边内边距（像素），填充背景色
-- vim.g.neovide_padding_top = 0
-- vim.g.neovide_padding_bottom = 0
-- vim.g.neovide_padding_right = 0
-- vim.g.neovide_padding_left = 0

-- ==========================================================================
-- 透明度 & 模糊
-- ==========================================================================

-- 窗口整体透明度 (0.0 ~ 1.0)
-- -- vim.g.neovide_opacity = 1.0

-- buffer 背景透明度
-- vim.g.neovide_normal_opacity = 1.0

-- ==========================================================================
-- 悬浮窗
-- ==========================================================================

-- 悬浮窗水平/垂直模糊半径
-- vim.g.neovide_floating_blur_amount_x = 2.0
-- vim.g.neovide_floating_blur_amount_y = 2.0

-- 悬浮窗阴影总开关
vim.g.neovide_floating_shadow = true

-- 悬浮窗高度
-- vim.g.neovide_floating_z_height = 10

-- 阴影光源角度
-- vim.g.neovide_light_angle_degrees = 45

-- 阴影光源半径
-- vim.g.neovide_light_radius = 5

-- 悬浮窗圆角 (0.0 ~ 1.0)
-- vim.g.neovide_floating_corner_radius = 0.0

-- ==========================================================================
-- 窗口 & 标题栏
-- ==========================================================================

-- 主题模式: "auto" | "light" | "dark" | "bg_color"
vim.g.neovide_theme = "auto"

-- 全屏模式
-- vim.g.neovide_fullscreen = false

-- 退出前确认（有未保存更改时）
vim.g.neovide_confirm_quit = true

-- 远程连接退出行为: "always_quit" | "always_detach" | "prompt"
vim.g.neovide_detach_on_quit = "prompt"

-- 记住上次窗口大小（--size 优先级更高）
vim.g.neovide_remember_window_size = true

-- 下划线/波浪线粗细缩放（太大会被下一行裁剪）
-- vim.g.neovide_underline_stroke_scale = 1.0

-- 鼠标拖选消息区域文本（如 :messages）
vim.g.neovide_message_area_drag_selection = true

-- 实验性：连续非空图层合并渲染（修复阴影/模糊伪影，但可能引入其他问题）
-- vim.g.experimental_layer_grouping = false

-- ==========================================================================
-- 进度条
-- ==========================================================================

vim.g.neovide_progress_bar_enabled = true
-- vim.g.neovide_progress_bar_height = 5.0           -- 像素
-- vim.g.neovide_progress_bar_animation_speed = 200.0 -- 动画速度
-- vim.g.neovide_progress_bar_hide_delay = 0.2        -- 完成后隐藏延迟（秒）

-- ==========================================================================
-- 位移动画 & 滚动动画
-- ==========================================================================

-- 窗口位移动画时长（如 :split 时的过渡），秒，0 禁用
-- vim.g.neovide_position_animation_length = 0.15

-- 滚动动画时长（秒），0 禁用
-- vim.g.neovide_scroll_animation_length = 0.3

-- 远距离滚动（超过一屏）时动画收尾行数: 0=瞬移 9999=全动画
-- vim.g.neovide_scroll_animation_far_lines = 1

-- ==========================================================================
-- 光标动画
-- ==========================================================================

-- 光标动画时长（秒），0 禁用
-- vim.g.neovide_cursor_animation_length = 0.15

-- 短距离（1~2 字符）光标动画时长（如打字时）
-- vim.g.neovide_cursor_short_animation_length = 0.04

-- 光标拖尾大小 (0.0 ~ 1.0)
-- vim.g.neovide_cursor_trail_size = 1.0

-- 光标抗锯齿（关闭可能修复某些光标显示问题）
vim.g.neovide_cursor_antialiasing = true

-- 插入模式下播放光标动画
vim.g.neovide_cursor_animate_in_insert_mode = true

-- 切换到命令行时播放光标动画
vim.g.neovide_cursor_animate_command_line = true

-- 失焦时光标轮廓宽度（em），<=0 失焦时光标不可见
-- vim.g.neovide_cursor_unfocused_outline_width = 0.125

-- 光标平滑闪烁（需 guicursor 同时配置 blinkon/blinkoff/blinkwait）
-- vim.g.neovide_cursor_smooth_blink = false

-- 光标使用被覆盖单元格的颜色（当 guicursor 未显式指定光标色时）
-- vim.g.neovide_cursor_cell_color_fallback = false

-- 防止光标异常闪烁到命令行（有 bug 时尝试关闭）
-- vim.g.neovide_cursor_hack = true

-- ==========================================================================
-- 光标粒子效果
-- ==========================================================================

-- 粒子模式: "" | "railgun" | "torpedo" | "pixiedust" | "sonicboom" | "ripple" | "wireframe"
-- 也可用数组组合多种: {"railgun", "sonicboom"}
vim.g.neovide_cursor_vfx_mode = { "railgun" }

-- 粒子透明度
-- vim.g.neovide_cursor_vfx_opacity = 200.0

-- 粒子生命周期（秒）
-- vim.g.neovide_cursor_vfx_particle_lifetime = 0.5

-- 高亮粒子生命周期（sonicboom/ripple/wireframe），设 0 复用 particle_lifetime
-- vim.g.neovide_cursor_vfx_particle_highlight_lifetime = 0.2

-- 粒子密度（每行移动产生的粒子数）
-- vim.g.neovide_cursor_vfx_particle_density = 0.7

-- 粒子速度（像素/秒）
-- vim.g.neovide_cursor_vfx_particle_speed = 10.0

-- 粒子相位（railgun only）
-- vim.g.neovide_cursor_vfx_particle_phase = 1.5

-- 粒子旋度（railgun only）
-- vim.g.neovide_cursor_vfx_particle_curl = 1.0

-- ==========================================================================
-- 刷新率 & 性能
-- ==========================================================================

-- 渲染刷新率, 仅在 未开启垂直同步 时生效
-- vim.g.neovide_refresh_rate = 60

-- 失焦时刷新率
vim.g.neovide_refresh_rate_idle = 5

-- 强制持续重绘
-- vim.g.neovide_no_idle = false

-- 性能分析器
-- vim.g.neovide_profiler = false

-- ==========================================================================
-- 输入 & 触摸
-- ==========================================================================

-- 打字时隐藏鼠标指针
vim.g.neovide_hide_mouse_when_typing = true

-- 启用输入法 IME
vim.g.neovide_input_ime = true

-- 触摸死区
-- vim.g.neovide_touch_deadzone = 6.0

-- 触摸拖动超时
-- vim.g.neovide_touch_drag_timeout = 0.17

-- ==========================================================================
-- 关闭所有动画
-- ==========================================================================

-- vim.g.neovide_position_animation_length = 0
-- vim.g.neovide_cursor_animation_length = 0
-- vim.g.neovide_cursor_trail_size = 0
-- vim.g.neovide_cursor_animate_in_insert_mode = false
-- vim.g.neovide_cursor_animate_command_line = false
-- vim.g.neovide_scroll_animation_far_lines = 0
-- vim.g.neovide_scroll_animation_length = 0

-- ==========================================================================
-- 快捷键
-- ==========================================================================
vim.g.neovide_scale_factor = 1.0

local function change_scale(delta)
	vim.g.neovide_scale_factor = vim.g.neovide_scale_factor * delta
	-- 限制缩放范围 0.3 ~ 5.0
	vim.g.neovide_scale_factor = math.max(0.3, math.min(5.0, vim.g.neovide_scale_factor))
end

local function reset_scale()
	vim.g.neovide_scale_factor = 1.0
end

-- (Ctrl + =) -> 放大
vim.keymap.set({ "n", "i", "v" }, "<C-=>", function()
	change_scale(1.25)
end, { desc = "Neovide: 放大" })
-- (Ctrl + -) ->  缩小
vim.keymap.set({ "n", "i", "v" }, "<C-->", function()
	change_scale(0.8)
end, { desc = "Neovide: 缩小" })
-- Ctrl + 0 -> 重置
vim.keymap.set({ "n", "i", "v" }, "<C-0>", reset_scale, { desc = "Neovide: 重置缩放" })

-- F11 切换全屏
vim.keymap.set({ "n", "i", "v" }, "<F11>", function()
	vim.g.neovide_fullscreen = not vim.g.neovide_fullscreen
end, { desc = "Neovide: 切换全屏" })

-- Ctrl + 鼠标滚轮缩放, 仅在 Neovide 生效
vim.keymap.set({ "n", "i", "v" }, "<C-ScrollWheelUp>", function()
	change_scale(1.1)
end, { desc = "Neovide: 滚轮放大" })
vim.keymap.set({ "n", "i", "v" }, "<C-ScrollWheelDown>", function()
	change_scale(0.9)
end, { desc = "Neovide: 滚轮缩小" })
