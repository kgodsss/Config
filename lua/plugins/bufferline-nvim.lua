return {
  'akinsho/bufferline.nvim',
  version = '*', -- 使用最新版本
  dependencies = 'nvim-tree/nvim-web-devicons', -- 图标支持
  config = function()
    require('bufferline').setup {
      options = {
        numbers = 'none', -- 可以选择 "buffer_id", "ordinal", "both", 或 "none"
        close_command = 'bdelete! %d', -- 关闭缓冲区的命令
        right_mouse_command = 'bdelete! %d', -- 右键关闭缓冲区
        left_mouse_command = 'buffer %d', -- 左键点击切换缓冲区
        middle_mouse_command = nil, -- 中键关闭缓冲区
        indicator = {
          style = 'icon', -- 设置缓冲区指示器，使用 "underline" 或 "icon"
        },
        buffer_close_icon = '',
        modified_icon = '●',
        close_icon = '',
        left_trunc_marker = '',
        right_trunc_marker = '',
        max_name_length = 18,
        max_prefix_length = 15, -- prefix used when a buffer is deduplicated
        tab_size = 18,
        diagnostics = 'nvim_lsp', -- 启用 LSP 诊断显示
        diagnostics_update_in_insert = false,
        diagnostics_indicator = function(count, level, diagnostics_dict, context)
          return '(' .. count .. ')'
        end,
        offsets = { { filetype = 'NvimTree', text = 'File Explorer', text_align = 'center' } },
        show_buffer_icons = true, -- 显示缓冲区图标
        show_buffer_close_icons = true,
        show_close_icon = true,
        show_tab_indicators = true,
        separator_style = 'slant', -- 可以设置 "slant", "thick", "thin" 等
        enforce_regular_tabs = false,
        always_show_bufferline = true,
      },
    }
  end,
}
