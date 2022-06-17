require('packer').startup(function(use)
	use 'wbthomason/packer.nvim'
	use 'nvim-lua/plenary.nvim'
	use 'vim-airline/vim-airline'
	use 'vim-airline/vim-airline-themes'
	use 'olimorris/onedarkpro.nvim'
	use 'joshdick/onedark.vim'
	use 'lervag/vimtex'
	use {
        'neoclide/coc.nvim',
        branch='release',
    }
	use {
        'lewis6991/gitsigns.nvim',
        config=function() require('gitsigns').setup() end,
    }
	use 'preservim/nerdtree'
	use {
        'akinsho/toggleterm.nvim',
        tag='v1.*',
        config=function() require('toggleterm').setup() end,
    }
	use 'leafOfTree/vim-svelte-plugin'
	use 'iamcco/markdown-preview.nvim'
	use 'tpope/vim-obsession'
	use 'mhinz/vim-startify'
	use 'sindrets/diffview.nvim'
	use 'kyazdani42/nvim-web-devicons'
	use 'romgrk/barbar.nvim'
    use {
        'folke/which-key.nvim',
        config=require('keymap'),
    }
    use {
        'nvim-telescope/telescope.nvim',
        requires = { {'nvim-lua/plenary.nvim'} }
    }
end)
