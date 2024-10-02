-- welcome to nvim

local set = vim.opt
set.number = true
set.relativenumber = true
set.clipboard = "unnamedplus"

-- 复制高亮
vim.api.nvim_create_autocmd("TextYankPost", {
	pattern = { "*" },
	callback = function()
		vim.highlight.on_yank({
			timeout = 100,
		})
	end,
})

local opts = { noremap = true, silent = true }
vim.keymap.set("n", "<C-Left>", ":vertical resize +5<CR>", opts)
vim.keymap.set("n", "<C-Right>", ":vertical resize -5<CR>", opts)
vim.keymap.set("n", "<C-Up>", ":resize +5<CR>", opts)
vim.keymap.set("n", "<C-Down>", ":resize -5<CR>", opts)

vim.keymap.set('n', '<C-h>', '<C-w>h', opts)
vim.keymap.set('n', '<C-j>', '<C-w>j', opts)
vim.keymap.set('n', '<C-k>', '<C-w>k', opts)
vim.keymap.set('n', '<C-l>', '<C-w>l', opts)
vim.keymap.set('n', 'a', '$', { noremap = true, silent = true })


-- 加载 lazy.nvim 插件管理器
local lazypath = vim.fn.stdpath("config") .. "/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- 最新稳定版本
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

-- 配置 lazy.nvim
-- 配置 lazy.nvim
require("lazy").setup({
  -- 在此处添加你想安装的插件列表
  
  {
      'morhetz/gruvbox',
      config = function()
          -- 设置颜色主题
          vim.cmd([[colorscheme gruvbox]])
      end
    },	

})

vim.cmd.colorscheme('gruvbox')  -- 设置 gruvbox 颜色主题
