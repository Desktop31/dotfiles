vim.g.mapleader = " "
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

vim.keymap.set("n", "J", "mzJ`z")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- greatest remap ever
vim.keymap.set("x", "<leader>p", [["_dP]])

-- next greatest remap ever : asbjornHaland
-- copy to system clipboard
vim.keymap.set({"n", "v"}, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])

-- delete without copying
vim.keymap.set({"n", "v"}, "<leader>d", [["_d]])

vim.keymap.set("n", "Q", "<nop>")
vim.keymap.set("n", "<leader>f", vim.lsp.buf.format)

-- vim.keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz")
-- vim.keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz")
vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz")
vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz")

vim.keymap.set("n", "<leader>sr", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })

vim.keymap.set("n", "<leader>t", "<Cmd>:ToggleTerm size=115 dir=./ direction=vertical<CR>")
function _G.set_terminal_keymaps()
  local opts = {buffer = 0}
  vim.keymap.set('t', '<esc>', [[<C-\><C-n>]], opts)
  vim.keymap.set('t', 'jk', [[<C-\><C-n>]], opts)
  vim.keymap.set('t', '<C-h>', [[<Cmd>wincmd h<CR>]], opts)
  vim.keymap.set('n', '<C-h>', [[<Cmd>wincmd h<CR>]], opts)
  vim.keymap.set('t', '<C-j>', [[<Cmd>wincmd j<CR>]], opts)
  vim.keymap.set('t', '<C-k>', [[<Cmd>wincmd k<CR>]], opts)
end

-- if you only want these mappings for toggle term use term://*toggleterm#* instead
vim.cmd('autocmd! TermOpen term://* lua set_terminal_keymaps()')
vim.keymap.set("n", "<C-l>", [[<Cmd>wincmd l<CR>]])

-- Markdown previewer
vim.keymap.set("n", "<leader>md", "<cmd>MarkdownPreviewToggle<CR>")

-- Buffer navigation
vim.keymap.set("n", "<C-Tab>", "<cmd>bnext<CR>")
vim.keymap.set("n", "<C-S-Tab>", "<cmd>bprev<CR>")

-- Close current buffer
vim.keymap.set("n", "<leader>q", "<cmd>bd<CR>")

-- Subway Surfers
-- vim.keymap.set("n", "<leader>ss", "<Cmd>:TermExec cmd='mpv --vo=tct ~/Media/Funny/SubSurf.webm' size=60 dir=./ direction=vertical<CR>")
vim.keymap.set("n", "<leader>ss", "<Cmd>:TermExec cmd='mpv --start=01:35 --ytdl-format=242 --ytdl https://youtu.be/nNGQ7kMhGuQ --vo=tct' size=60 dir=./ direction=vertical<CR>")

-- Minecraft Parkour
vim.keymap.set("n", "<leader>mp", "<Cmd>:TermExec cmd='mpv --ytdl-format=242 --ytdl https://youtu.be/2VpG0WS4uCo --vo=tct' size=60 dir=./ direction=vertical<CR>")

