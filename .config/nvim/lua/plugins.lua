require('packer').startup(function(use)
	use 'wbthomason/packer.nvim'
	use 'nvim-lua/plenary.nvim'
	use 'vim-airline/vim-airline'
	use 'vim-airline/vim-airline-themes'
	use 'olimorris/onedarkpro.nvim'
	use 'joshdick/onedark.vim'
	use 'lervag/vimtex'
	use 'ctrlpvim/ctrlp.vim'
	use {'neoclide/coc.nvim', branch = 'release' }
	use 'lewis6991/gitsigns.nvim'
	use 'junegunn/fzf.vim'
	use 'preservim/nerdtree'
	use {'akinsho/toggleterm.nvim', tag='v1.*'}
	use 'leafOfTree/vim-svelte-plugin'
	use 'iamcco/markdown-preview.nvim'
	use 'tpope/vim-obsession'
	use 'mhinz/vim-startify'
	use 'sindrets/diffview.nvim'
	use 'kyazdani42/nvim-web-devicons'
	use 'romgrk/barbar.nvim'
end)
