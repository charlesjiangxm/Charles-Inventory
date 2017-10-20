" Tpope
execute pathogen#infect()
syntax on
filetype plugin indent on

" General settings
set mouse=a
set number
set hlsearch
set colorcolumn=100

" NerdTree
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | endif
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
map <F5> :NERDTreeToggle<CR>
