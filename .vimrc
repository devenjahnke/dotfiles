set nocompatible

" Enable intelligent auto-indenting based on the filetype
if has('filetype')
	filetype indent plugin on
endif

" Enable syntax highlighting
if has('syntax')
	syntax on
endif

" Better command-line completion
set wildmenu

" Show partial commands in the last line of the screen
set showcmd

" Highlight searches
set hlsearch

" Use case insensitive search, except when using capital letters
set ignorecase
set smartcase

" Allow backspacing over autoindent, line breaks, and start of insert action
set backspace=indent,eol,start

" Match indent of current file if filetype-specific indenting is not enabled
set autoindent

" Prompt to save file changes if unsaved
set confirm

" Enable use of the mouse (for all modes)
if has ('mouse')
	set mouse=a
endif

" Display line numbers
set number

" Set tab width equivalent to 4 spaces
set shiftwidth=4
set tabstop=4
