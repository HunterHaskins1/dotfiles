vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
    use 'wbthomason/packer.nvim'
    use 'tpope/vim-fugitive'
    use 'navarasu/onedark.nvim'
    use 'ggandor/leap.nvim'
    use {'akinsho/bufferline.nvim', tag = "*", requires = 'nvim-tree/nvim-web-devicons'}
    use {'nvim-treesitter/nvim-treesitter', run = 'TSUpdate'}
    use {
        'nvim-tree/nvim-tree.lua',
        requires = {
            'nvim-tree/nvim-web-devicons', -- optional
        },
    }
    use {
        'numToStr/comment.nvim',
        config = function()
            require('Comment').setup()
        end
    }

	use {
		'nvim-telescope/telescope.nvim', tag = '0.1.1',
		requires = { { 'nvim-lua/plenary.nvim'} }
	}
	use {
		'VonHeikemen/lsp-zero.nvim',
		branch = 'v2.x',
		requires = {
			{'neovim/nvim-lspconfig'},
			{
				'williamboman/mason.nvim',
				run = function()
					pcall(vim.cmd, 'MasonUpdate')
				end,
			},
			{'williamboman/mason-lspconfig.nvim'},

			{'hrsh7th/nvim-cmp'},
			{'hrsh7th/cmp-nvim-lsp'},
			{'L3MON4D3/LuaSnip'},
		}
	}

end)
