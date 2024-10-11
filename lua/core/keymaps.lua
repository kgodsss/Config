local M = {}
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })

vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })

vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })

vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

--telescope

local builtin = require 'telescope.builtin'
vim.keymap.set('n', '<leader>sh', builtin.help_tags, { desc = '[S]earch [H]elp' })

vim.keymap.set('n', '<leader>sk', builtin.keymaps, { desc = '[S]earch [K]eymaps' })

vim.keymap.set('n', '<leader>sf', builtin.find_files, { desc = '[S]earch [F]iles' })

vim.keymap.set('n', '<leader>ss', builtin.builtin, { desc = '[S]earch [S]elect Telescope' })

vim.keymap.set('n', '<leader>sw', builtin.grep_string, { desc = '[S]earch current [W]ord' })

vim.keymap.set('n', '<leader>sg', builtin.live_grep, { desc = '[S]earch by [G]rep' })

vim.keymap.set('n', '<leader>sd', builtin.diagnostics, { desc = '[S]earch [D]iagnostics' })

vim.keymap.set('n', '<leader>sr', builtin.resume, { desc = '[S]earch [R]esume' })

vim.keymap.set('n', '<leader>s.', builtin.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })

vim.keymap.set('n', '<leader><leader>', builtin.buffers, { desc = '[ ] Find existing buffers' })

vim.keymap.set('n', '<leader>/', function()
  -- You can pass additional configuration to Telescope to change the theme, layout, etc.
  builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
    winblend = 10,
    previewer = false,
  })
end, { desc = '[/] Fuzzily search in current buffer' })

vim.keymap.set('n', '<leader>s/', function()
  builtin.live_grep {
    grep_open_files = true,
    prompt_title = 'Live Grep in Open Files',
  }
end, { desc = '[S]earch [/] in Open Files' })

vim.keymap.set('n', '<leader>sn', function()
  builtin.find_files { cwd = vim.fn.stdpath 'config' }
end, { desc = '[S]earch [N]eovim files' })

--  nvim-lspconfig
M.lsp_keymaps = function(event)
  local client = vim.lsp.get_client_by_id(event.data.client_id)
  local map = function(keys, func, desc, mode)
    mode = mode or 'n'
    vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
  end

  map('gd', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition')

  map('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')

  map('gI', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')

  map('<leader>D', require('telescope.builtin').lsp_type_definitions, 'Type [D]efinition')

  map('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')

  map('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')

  map('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')

  map('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction', { 'n', 'x' })

  map('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
  if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint) then
    map('<leader>th', function()
      vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = event.buf })
    end, '[T]oggle Inlay [H]ints')
  end
end

M.cmp_keymaps = function(cmp, luasnip)
  local mapping = cmp.mapping.preset.insert {
    -- Select the [n]ext item
    ['<Tab>'] = cmp.mapping.select_next_item(),
    -- Select the [p]revious item
    ['<S-Tab>'] = cmp.mapping.select_prev_item(),

    -- Scroll the documentation window [b]ack / [f]orward
    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),

    -- Accept ([y]es) the completion.
    --  This will auto-import if your LSP supports it.
    --  This will expand snippets if the LSP sent a snippet.
    ['<C-y>'] = cmp.mapping.confirm { select = true },

    -- If you prefer more traditional completion keymaps,
    -- you can uncomment the following lines
    --['<CR>'] = cmp.mapping.confirm { select = true },
    --['<Tab>'] = cmp.mapping.select_next_item(),
    --['<S-Tab>'] = cmp.mapping.select_prev_item(),

    -- Manually trigger a completion from nvim-cmp.
    --  Generally you don't need this, because nvim-cmp will display
    --  completions whenever it has completion options available.
    ['<C-Space>'] = cmp.mapping.complete {},

    -- Think of <c-l> as moving to the right of your snippet expansion.
    --  So if you have a snippet that's like:
    --  function $name($args)
    --    $body
    --  end
    --
    -- <c-l> will move you to the right of each of the expansion locations.
    -- <c-h> is similar, except moving you backwards.
    ['<C-l>'] = cmp.mapping(function()
      if luasnip.expand_or_locally_jumpable() then
        luasnip.expand_or_jump()
      end
    end, { 'i', 's' }),
    ['<C-h>'] = cmp.mapping(function()
      if luasnip.locally_jumpable(-1) then
        luasnip.jump(-1)
      end
    end, { 'i', 's' }),

    -- For more advanced Luasnip keymaps (e.g. selecting choice nodes, expansion) see:
    --    https://github.com/L3MON4D3/LuaSnip?tab=readme-ov-file#keymaps
  }

  return mapping
end

--  nvim-tree

vim.keymap.set('n', '<leader>n', ':NvimTreeToggle<CR>', { desc = '[E]xplorer Toggle' })

local list = {
  { key = 'a', action = 'create' }, -- 新建文件或文件夹
  { key = 'd', action = 'remove' }, -- 删除文件或文件夹
  { key = 'r', action = 'rename' }, -- 重命名文件或文件夹
  { key = '<C-r>', action = 'full_rename' }, -- 完整重命名
  { key = 'x', action = 'cut' }, -- 剪切文件
  { key = 'c', action = 'copy' }, -- 复制文件
  { key = 'p', action = 'paste' }, -- 粘贴文件
  { key = 'y', action = 'copy_name' }, -- 复制文件名称
  { key = 'Y', action = 'copy_path' }, -- 复制文件路径
  { key = 'I', action = 'toggle_ignored' }, -- 切换隐藏文件
  { key = 'H', action = 'toggle_dotfiles' }, -- 切换点文件
  { key = '<CR>', action = 'edit' }, -- 打开文件
  { key = 'o', action = 'edit' }, -- 另一种打开文件的方式
  { key = 'v', action = 'vsplit' }, -- 垂直分割打开文件
  { key = 's', action = 'split' }, -- 水平分割打开文件
  { key = 't', action = 'tabnew' }, -- 新标签页打开文件
  { key = '<BS>', action = 'close_node' }, -- 关闭当前节点
  { key = 'R', action = 'refresh' }, -- 刷新文件树
  { key = '?', action = 'toggle_help' }, -- 切换帮助菜单
}

-- markdown-preview

vim.keymap.set('n', '<leader>md', ':MarkdownPreviewToggle<CR>', { desc = '[M]ark [D]own' })

return M
