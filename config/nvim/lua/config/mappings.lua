-- Doom Emacs style necessities
vim.keymap.set('n', '<leader>bk', '<cmd>q<cr>')
vim.keymap.set('n', '<leader>fs', '<cmd>w<cr>')
vim.keymap.set('n', '<leader>sa', 'gg<S-v>G')
vim.keymap.set('n', '<leader>wV', ':vsplit<Return><C-w>w', { silent = true })
vim.keymap.set('n', '<leader>w', '<C-w>')
vim.keymap.set('n', '<leader>op', '<cmd>:NvimTreeOpen<cr>')
vim.keymap.set('n', '<leader>ot', '<cmd>:ToggleTerm<cr>')
vim.keymap.set('t', '<C-q>', '<cmd>:ToggleTerm<cr>')

vim.keymap.set('n', ']o', '<cmd>:s/^\\(\\s*\\).*$/\\0\\r\\1<cr><esc>')
vim.keymap.set('n', '[o', '<cmd>:s/^\\(\\s*\\).*$/\\1\\r\\0<cr><esc>k')



-- See `:help telescope.builtin`
vim.keymap.set('n', '<leader>fr', require('telescope.builtin').oldfiles, { desc = '[?] Find recently opened files' })
vim.keymap.set('n', '<leader>bi', require('telescope.builtin').buffers, { desc = '[ ] Find existing buffers' })
vim.keymap.set('n', '<leader>/', function()
  -- You can pass additional configuration to telescope to change theme, layout, etc.
  require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
    winblend = 10,
    previewer = false,
  })
end, { desc = '[/] Fuzzily search in current buffer' })

vim.keymap.set('n', '<leader>gf', require('telescope.builtin').git_files, { desc = 'Search [G]it [F]iles' })
vim.keymap.set('n', '<leader>.', require('telescope.builtin').find_files, { desc = '[S]earch [F]iles' })
vim.keymap.set('n', '<leader>sh', require('telescope.builtin').help_tags, { desc = '[S]earch [H]elp' })
vim.keymap.set('n', '<leader>sw', require('telescope.builtin').grep_string, { desc = '[S]earch current [W]ord' })
vim.keymap.set('n', '<leader>sg', require('telescope.builtin').live_grep, { desc = '[S]earch by [G]rep' })
vim.keymap.set('n', '<leader>sd', require('telescope.builtin').diagnostics, { desc = '[S]earch [D]iagnostics' })
vim.keymap.set('n', '<leader>sr', require('telescope.builtin').resume, { desc = '[S]earch [R]resume' })




-- Diagnostic keymaps
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic message' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic message' })
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Open floating diagnostic message' })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostics list' })
