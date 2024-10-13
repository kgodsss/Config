-- File Explorer / Tree
return {
  -- https://github.com/nvim-tree/nvim-tree.lua
  'nvim-tree/nvim-tree.lua',
  dependencies = {
    -- https://github.com/nvim-tree/nvim-web-devicons
    'nvim-tree/nvim-web-devicons', -- Fancy icon support
  },
  update_cwd = true, -- 自动更新当前工作目录
  opts = {
    actions = {
      open_file = {
        window_picker = {
          enable = false,
        },
      },
    },
    update_focused_file = {
      enable = true, -- 启用自动聚焦功能
      update_cwd = true, -- 是否更新当前工作目录
      ignore_list = {}, -- 忽略列表，不更新这些文件的聚焦
    },
  },
  config = function(_, opts)
    -- Recommended settings to disable default netrw file explorer
    vim.g.loaded_netrw = 1
    vim.g.loaded_netrwPlugin = 1
    require('nvim-tree').setup(opts)
  end,
}
