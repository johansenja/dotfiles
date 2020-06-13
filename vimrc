syntax on

set noerrorbells

set backspace=indent,eol,start
set tabstop=2 shiftwidth=2 expandtab softtabstop=2
set smartindent
set nu
set nowrap
set smartcase
set noswapfile
set nobackup
set undodir=~/.vim/undodir
set undofile
set incsearch
set colorcolumn=120
set autoread

highlight ColorColumn ctermbg=darkcyan guibg=lightgrey

if has("multi_byte")
  set encoding=utf-8
  setglobal fileencoding=utf-8
else
  echoerr "Sorry, this version of (g)vim was not compiled with +multi_byte"
endif

:let mapleader = ","
let g:ale_fixers = {
\   '*': ['remove_trailing_lines', 'trim_whitespace'],
\   'javascript': ['eslint', 'prettier'],
\   'typescript': ['eslint', 'prettier'],
\}
let g:ale_fix_on_save = 1
if executable('rg')
  let g:rg_derive_root='true'
endif
let g:ctrlp_user_command = ['.git/', 'git --git-dir=%s/.git ls-files -oc --exclude-standard']
let g:netrw_banner = 0
let g:netrw_browse_split = 2
let g:netrw_winsize = 25
let g:ycm_autoclose_preview_window_after_completion = 1
let g:ycm_key_list_select_completion = ['<TAB>', '<Down>']
let g:ycm_key_list_stop_completion = ['<C-y>', '<CR>']

call plug#begin('~/.vim/plugged')
Plug 'jremmen/vim-ripgrep'
Plug 'tpope/vim-fugitive'
Plug 'leafgarland/typescript-vim'
Plug 'vim-utils/vim-man'
Plug 'git@github.com:kien/ctrlp.vim.git'
Plug 'mbbill/undotree'
Plug 'terryma/vim-multiple-cursors'
Plug 'prettier/vim-prettier', {
  \ 'do': 'yarn install',
  \ 'branch': 'release/0.x'
  \ }
Plug 'Valloric/YouCompleteMe'
Plug 'dense-analysis/ale'
Plug 'mbbill/undotree'
call plug#end()


:nnoremap <Leader>w <C-w>
:nnoremap <Leader>v <C-v>
:nnoremap <Leader>s <C-s>
:nnoremap <Leader>u :UndotreeToggle<CR>
:nnoremap <Leader>ps :Rg<SPACE>
:nnoremap <silent> <Leader>gd :YcmCompleter GoTo<CR>
:nnoremap <silent> <Leader>gf :YcmCompleter FixIt<CR>
