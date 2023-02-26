local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<C-p>', builtin.git_files, {})
vim.keymap.set('n', '<leader>fs', builtin.live_grep, {})

vim.keymap.set('n', '<leader>kl', builtin.keymaps, {}) -- keymap list

-- GIT --
vim.keymap.set('n', '<leader>gs', builtin.git_status, {})
vim.keymap.set('n', '<leader>gb', builtin.git_branches, {})
vim.keymap.set('n', '<leader>gac', builtin.git_commits, {}) -- [g]it [a]ll [c]ommits
vim.keymap.set('n', '<leader>gc', builtin.git_bcommits, {}) -- [g]it [c]ommits


-- LSP --
vim.keymap.set("n", "gd", builtin.lsp_definitions, {})
vim.keymap.set("n", "<leader>lr", builtin.lsp_references, {}) -- list references
vim.keymap.set("n", "<leader>ds", builtin.lsp_document_symbols, {}) -- document symbols
vim.keymap.set("n", "<leader>ws", builtin.lsp_workspace_symbols, {}) -- workspace symbols

