require("configs.remaps")
require("configs.packer")

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

require('leap').add_default_mappings{}
require('bufferline').setup{}
require('Comment').setup()

    local lsp = require('lsp-zero').preset({})

lsp.on_attach(function(client, bufnr)
  lsp.default_keymaps({buffer = bufnr})
end)

-- (Optional) Configure lua language server for neovim
require('lspconfig').lua_ls.setup(lsp.nvim_lua_ls())

lsp.setup()


local diagnostics_active = true
vim.keymap.set('n', '<leader>c', function()
	diagnostics_active = not diagnostics_active
	if diagnostics_active then
		vim.diagnostics.show()
	else
		vim.diagnostics.hide()
	end
end)

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

vim.opt.termguicolors = true
require('nvim-tree').setup {
	update_cwd = true,
	update_focused_file = {
		enable = true,
		update_cwd = true,
		ignore_list = {}
	},
}

