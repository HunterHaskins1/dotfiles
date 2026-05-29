-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    local lazyrepo = "https://github.com/folke/lazy.nvim.git"
    local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
    if vim.v.shell_error ~= 0 then
        vim.api.nvim_echo({
            { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
            { out, "WarningMsg" },
            { "\nPress any key to exit..." },
        }, true, {})
        vim.fn.getchar()
        os.exit(1)
    end
end
vim.opt.rtp:prepend(lazypath)

local plugins = {
    'tpope/vim-fugitive',
    'tpope/vim-rsi',
    -- 'navarasu/onedark.nvim',
    {
        'folke/tokyonight.nvim',
        opts = {
            style = "moon",
            transparent = true,
        }
    },
    'nvim-tree/nvim-web-devicons',
    { 'akinsho/bufferline.nvim', opts = {} },
    {
        'nvim-treesitter/nvim-treesitter',
        branch = 'main',
        lazy = false,
        build = ':TSUpdate',
        config = function()
            -- 1. Initialize the new treesitter plugin module
            require('nvim-treesitter').setup()

            -- 2. Define and install your language parsers
            require('nvim-treesitter').install({
                'lua',
                'python',
                'typescript',
                'javascript',
                'markdown',
                'markdown_inline', -- Essential for your LSP 'K' hover docs!
            })
        end
    },
    {
        'nvim-tree/nvim-tree.lua',
        opts = {},
    },
    {
        'nvim-telescope/telescope.nvim',
        dependencies = { 'nvim-lua/plenary.nvim' },
        opts = {},
        keys = {
            { '<C-p>', function() require('telescope.builtin').find_files() end, desc = 'Telescope Find Files' },
            { '<leader>g', function() require('telescope.builtin').live_grep() end, desc = 'Telescope Live Grep' },
        },
    },

    -- Completion
    {
        'saghen/blink.cmp',
        build = function() require('blink.cmp').build():wait(60000) end,
        dependencies = {
            {
                'saghen/blink.lib',
                build = function() require('blink.cmp').build():wait(60000) end,
            },
        },
        opts = {
            keymap = {
                preset = 'default',
                -- ['<CR>']      = { 'accept', 'fallback' },
                -- ['<Tab>']     = { 'select_next', 'fallback' },
                -- ['<S-Tab>']   = { 'select_prev', 'fallback' },
                ['<C-Space>'] = { 'show', 'show_documentation', 'hide_documentation' },
                ['<C-u>']     = { 'scroll_documentation_up', 'fallback' },
                ['<C-d>']     = { 'scroll_documentation_down', 'fallback' },
            },
            appearance = {
                use_nvim_cmp_as_default = false,
                nerd_font_variant = 'mono',
            },
            sources = {
                default = { 'lsp', 'path', 'buffer' },
            },
            completion = {
                documentation = { auto_show = true, auto_show_delay_ms = 200 },
                ghost_text    = { enabled = false },
            },
        },
    },

    -- LSP (Modern Native Configuration)
    {
        'neovim/nvim-lspconfig',
        dependencies = {
            {
                'williamboman/mason.nvim',
                opts = {},
            },
            {
                'williamboman/mason-lspconfig.nvim',
                opts = {
                    ensure_installed = { 'pyright', 'ts_ls', 'lua_ls' },
                    automatic_installation = true,
                },
            },
        },
        config = function()
            -- 1. Native Global Attach Autocommand (Replaces loop-based on_attach)
            vim.api.nvim_create_autocmd('LspAttach', {
                callback = function(event)
                    local bufnr = event.buf
                    local map = function(keys, func, desc)
                        vim.keymap.set('n', keys, func, { buffer = bufnr, desc = 'LSP: ' .. desc })
                    end

                    map('gd',         vim.lsp.buf.definition,     'Go to Definition')
                    map('gD',         vim.lsp.buf.declaration,    'Go to Declaration')
                    map('gr',         vim.lsp.buf.references,     'Go to References')
                    map('gi',         vim.lsp.buf.implementation, 'Go to Implementation')
                    map('K',          vim.lsp.buf.hover,          'Hover Docs')
                    map('<leader>rn', vim.lsp.buf.rename,         'Rename')
                    map('<leader>ca', vim.lsp.buf.code_action,    'Code Action')
                    map('<leader>f',  vim.lsp.buf.format,         'Format')
                    map(']d',         vim.diagnostic.goto_next,    'Next Diagnostic')
                    map('[d',         vim.diagnostic.goto_prev,    'Previous Diagnostic')
                end,
            })

            -- 2. Register global autocomplete capabilities for blink.cmp
            local capabilities = require('blink.cmp').get_lsp_capabilities()
            vim.lsp.config('*', { capabilities = capabilities })

            -- 3. Core Diagnostic Engine Settings
            vim.diagnostic.config({
                virtual_text     = true,
                signs            = true,
                underline        = true,
                update_in_insert = false,
                severity_sort    = true,
            })

            -- 4. Keymap to toggle virtual text
            vim.keymap.set('n', '<leader>tv', function()
                local current = vim.diagnostic.config().virtual_text
                vim.diagnostic.config({ virtual_text = not current })
            end, { desc = 'LSP: Toggle Diagnostic Virtual Text' })
        end,
    },
}

require("lazy").setup(plugins, {})
