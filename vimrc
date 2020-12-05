" User interface
set number
set numberwidth=4
set ruler
set cursorline
set mouse=a
set title

" Code folding
set foldenable
set foldlevelstart=10
set foldnestmax=10
set foldmethod=indent

" Indentation
set tabstop=4
set shiftwidth=4
set shiftround

" Search
set hlsearch
set smartcase

" Text rendering
set encoding=utf-8
set scrolloff=999
syntax enable
set wrap

" Misc
set history=1000
set spell

" Color scheme
if has("termguicolors")
	set termguicolors
endif
set background=dark
colorscheme solarized8_flat

" Vim-Plug package manager configuration
call plug#begin('~/.vim/plugged')

Plug 'lifepillar/vim-solarized8'

Plug 'sheerun/vim-polyglot'

Plug 'vim-airline/vim-airline'

Plug 'vim-airline/vim-airline-themes'

call plug#end()























































