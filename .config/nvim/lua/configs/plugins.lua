local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

local plugins = {
    'tpope/vim-fugitive',
    'navarasu/onedark.nvim',
    'ggandor/leap.nvim',
    'akinsho/bufferline.nvim',
    'nvim-tree/nvim-web-devicons',
    'nvim-treesitter/nvim-treesitter',
    'nvim-tree/nvim-tree.lua',
    'numToStr/comment.nvim',
    'nvim-telescope/telescope.nvim',
    'nvim-lua/plenary.nvim',
     {
        'VonHeikemen/lsp-zero.nvim',
         dependencies = {
            'neovim/nvim-lspconfig',
            'williamboman/mason.nvim',
            'williamboman/mason-lspconfig.nvim',
            'hrsh7th/nvim-cmp',
            'hrsh7th/cmp-nvim-lsp',
            'L3MON4D3/LuaSnip',
        },
     }

}

local opts = {}
require("lazy").setup(plugins, opts)
