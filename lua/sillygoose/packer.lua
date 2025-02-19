-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

-- :PackerCompile whenever this file is updated
vim.cmd([[
  augroup packer_user_config
  autocmd!
  autocmd BufWritePost packages.lua source <afile> | PackerCompile
  augroup end
]])

return require('packer').startup(function(use)
	-- Packer can manage itself
	use 'wbthomason/packer.nvim'

	-- File + Codebase Motions
	use {
		'nvim-telescope/telescope.nvim',
		tag = '0.1.8', -- or branch = '0.1.x'
		requires = { 'nvim-lua/plenary.nvim' }
	}
	use "nvim-telescope/telescope-file-browser.nvim"

	use {
		'nvim-treesitter/nvim-treesitter',
		run = ':TSUpdate'
	}

	use 'theprimeagen/harpoon'

	-- colorscheme
	use {
		'trusktr/seti.vim',
		config = function()
			vim.cmd('colorscheme seti')
		end
	}

	-- Transparent.nvim for making backgrounds transparent
	use {
		'xiyaowong/transparent.nvim',
		config = function()
			-- Set up transparent.nvim with your preferred options
			require("transparent").setup({
				enable = true, -- enable transparency
				extra_groups = { "NormalFloat", "NvimTreeNormal", "NvimTreeNormalNC" },
				exclude = {} -- groups to exclude from transparency
			})
		end
	}
	-- LSP
	use {
		'VonHeikemen/lsp-zero.nvim',
		requires = {
			-- LSP Support
			'neovim/nvim-lspconfig',
			'williamboman/mason.nvim',
			'williamboman/mason-lspconfig.nvim',

			-- Autocompletion
			'hrsh7th/nvim-cmp',
			'hrsh7th/cmp-buffer',
			'hrsh7th/cmp-path',
			'saadparwaiz1/cmp_luasnip',
			'hrsh7th/cmp-nvim-lsp',
			'hrsh7th/cmp-nvim-lua',

			-- Snippets
			'L3MON4D3/LuaSnip',
			'rafamadriz/friendly-snippets',
		}
	}
	-- LSP For GO
	use 'ray-x/go.nvim'
	use 'ray-x/guihua.lua'


	-- toggle term is cool
	use "akinsho/toggleterm.nvim"
end)
