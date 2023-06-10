vim.g.mapleader = " "

vim.opt.nu = true
vim.opt.relativenumber = true

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.smartindent = true

vim.opt.swapfile = false

vim.opt.hlsearch = false
vim.opt.incsearch = false

vim.opt.termguicolors = true

vim.opt.scrolloff = 6


vim.opt.updatetime = 50

vim.opt.ignorecase = true
vim.opt.wildignorecase = true
vim.opt.formatoptions:remove { "c", "r", "o" }

vim.opt.clipboard = "unnamedplus"
vim.opt.cursorline = true

--remaps
vim.keymap.set("i", "jk", "<Esc>")
vim.keymap.set("n", "<leader>w", ":w<cr>")
vim.keymap.set("n", "<leader>q", ":q<cr>")
vim.keymap.set("n", "<leader>;", ":<C-p>")

vim.keymap.set("v", "J", ":m '>+1<cr>gv=gv")
vim.keymap.set("v", "K", ":m '>-2<cr>gv=gv")

vim.keymap.set("n", "<C-u", "<C-u>zz")
vim.keymap.set("n", "<C-d", "<Cud>zz")

vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

vim.keymap.set("n", "<leader>-", "<C-w>s")
vim.keymap.set("n", "<leader>\\", "<c-w>v")

vim.keymap.set("n", "<leader>h", "<C-w>h")
vim.keymap.set("n", "<leader>j", "<C-w>j")
vim.keymap.set("n", "<leader>k", "<C-w>k")
vim.keymap.set("n", "<leader>l", "<C-w>l")

vim.keymap.set("n", "<leader>i", ":bp<cr>")
vim.keymap.set("n", "<leader>o", ":bn<cr>")
vim.keymap.set("n", "<leader>d", ":bdelete<cr>")

vim.keymap.set("n", "<leader>n", ":NvimTreeFindFileToggle<cr>")
