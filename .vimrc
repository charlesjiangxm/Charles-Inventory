" Tpope
" execute pathogen#infect()
" syntax on
" filetype plugin indent on

" enable using chinese
set termencoding=utf-8
set encoding=utf8
set fileencodings=utf8,ucs-bom,gbk,cp936,gb2312,gb18030

" some general settings
set mouse=a
set number
set hlsearch
set ignorecase
set tabstop=4
set nowrap
set backspace=indent,eol,start

" color scheme
colorscheme darkblue

" remaping ctrl+shift+up/down to moving current line up or down
nnoremap <C-S-Up> :m .-2<CR>==
nnoremap <C-S-Down> :m .+1<CR>==

" remapping shift+backspace to delete forward (word or whole line) in insert mode
imap <S-BS> <C-W>
imap <C-S-BS> <C-U>

" remapping:
" use shift+right/left to move small steps
" use ctrl+right/left to move big steps
" use home/end to move to the begging or end of the line
noremap <S-Right> e
noremap <S-Left> b
imap <S-Right> <esc>ea
imap <S-Left> <esc>bi

" copy and paste from clipboard
imap <S-Ins> <C-r><C-p>+
imap <C-c> <esc>y

" remapping shift+del to delete backward in insert and visual mode
noremap <S-Del> dW
inoremap <S-Del> <esc>lcW

" NerdTree
" autocmd StdinReadPre * let s:std_in=1
" autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | endif
" autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
" map <F5> :NERDTreeToggle<CR>
