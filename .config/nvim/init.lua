require("configs.remaps")
require("configs.plugins")

function Tog()
	local cfg = vim.g.onedark_config
	if vim.g.onedark_config["transparent"] == true
		then
			cfg["transparent"] = false
			vim.g.onedark_config = cfg
			require('onedark').load()
		else
			cfg["transparent"] = true
			vim.g.onedark_config = cfg
			require('onedark').load()
		end
	end

require('onedark').setup {
    style = 'darker',
    transparent = false,
    lualine = {
        transparent = true
    },

    vim.api.nvim_set_keymap('n', '<leader>t', ':lua Tog()<cr>',{ noremap = true, silent = true })
}


require('onedark').load()
require('bufferline').setup()
require('Comment').setup()
require('nvim-tree').setup()
require('mason').setup()

require'lspconfig'.clangd.setup{}
require'lspconfig'.lua_ls.setup {
  on_init = function(client)
    if client.workspace_folders then
      local path = client.workspace_folders[1].name
      if vim.loop.fs_stat(path..'/.luarc.json') or vim.loop.fs_stat(path..'/.luarc.jsonc') then
        return
      end
    end

    client.config.settings.Lua = vim.tbl_deep_extend('force', client.config.settings.Lua, {
      runtime = {
        -- Tell the language server which version of Lua you're using
        -- (most likely LuaJIT in the case of Neovim)
        version = 'LuaJIT'
      },
      -- Make the server aware of Neovim runtime files
      workspace = {
        checkThirdParty = false,
        library = {
          vim.env.VIMRUNTIME
          -- Depending on the usage, you might want to add additional paths here.
          -- "${3rd}/luv/library"
          -- "${3rd}/busted/library",
        }
        -- or pull in all of 'runtimepath'. NOTE: this is a lot slower and will cause issues when working on your own configuration (see https://github.com/neovim/nvim-lspconfig/issues/3189)
        -- library = vim.api.nvim_get_runtime_file("", true)
      }
    })
  end,
  settings = {
    Lua = {}
  }
}

vim.api.nvim_create_autocmd({"TextYankPost"}, { callback = function() vim.highlight.on_yank {higroup=(vim.fn['hlexists']('HighlightedyankRegion') > 0 and 'HighlightedyankRegion' or 'IncSearch'), timeout=500} end, })

-- local lsp = require('lsp-zero').preset({})

-- lsp.on_attach(function(client, bufnr)
--   lsp.default_keymaps({buffer = bufnr})
-- end)

-- (Optional) Configure lua language server for neovim
-- require('lspconfig').lua_ls.setup(lsp.nvim_lua_ls())

-- lsp.setup()


-- local diagnostics_active = true
-- vim.keymap.set('n', '<leader>c', function()
-- 	diagnostics_active = not diagnostics_active
-- 	if diagnostics_active then
-- 		vim.diagnostics.show()
-- 	else
-- 		vim.diagnostics.hide()
-- 	end
-- end)

-- vim.g.loaded_netrw = 1
-- vim.g.loaded_netrwPlugin = 1
--
-- vim.opt.termguicolors = true
-- require('nvim-tree').setup {
-- 	update_cwd = true,
-- 	update_focused_file = {
-- 		enable = true,
-- 		update_cwd = true,
-- 		ignore_list = {}
-- 	},
-- }
--
