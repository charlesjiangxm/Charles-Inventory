" Tpope
" execute pathogen#infect()
" syntax on
" filetype plugin indent on

" Chinese encoding
set termencoding=utf-8
set encoding=utf8
set fileencodings=utf8,ucs-bom,gbk,cp936,gb2312,gb18030

" General settings
set mouse=a
set number
set hlsearch
set ignorecase
set tabstop=4

" Color scheme
colorscheme darkblue 

" Key mappings
nnoremap <C-S-Up> :m .-2<CR>==
nnoremap <C-S-Down> :m .+1<CR>==

" NerdTree
" autocmd StdinReadPre * let s:std_in=1
" autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | endif
" autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
" map <F5> :NERDTreeToggle<CR>
