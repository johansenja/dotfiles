syntax on
filetype plugin indent on

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
set relativenumber
set number

highlight ColorColumn ctermbg=darkcyan guibg=darkcyan
highlight Pmenu ctermbg=darkcyan guibg=darkcyan ctermfg=white guifg=white
highlight VertSplit ctermbg=red ctermfg=red guibg=red guifg=red
highlight QuickScopePrimary ctermfg=darkred gui=underline
highlight QuickScopeSecondary ctermfg=darkblue gui=underline

autocmd FileType typescript setlocal completeopt+=menu,preview

if has("multi_byte")
  set encoding=utf-8
  setglobal fileencoding=utf-8
else
  echoerr "Sorry, this version of (g)vim was not compiled with +multi_byte"
endif

let mapleader = " "
let g:ale_fixers = {
\   '*': ['remove_trailing_lines', 'trim_whitespace'],
\   'javascript': ['eslint', 'prettier'],
\   'typescript': ['eslint', 'prettier'],
\   'typescriptreact': ['eslint', 'prettier'],
\   'scss': ['prettier'],
\   'css': ['prettier'],
\}
let g:ale_fix_on_save = 1
if executable('rg')
  let g:rg_derive_root='true'
endif
" let g:ctrlp_user_command = ['.git/', 'git --git-dir=%s/.git ls-files -oc --exclude-standard']
let g:netrw_banner = 0
let g:netrw_browse_split = 2
let g:netrw_winsize = 15
let g:ycm_autoclose_preview_window_after_completion = 1
let g:ycm_key_list_select_completion = ['<TAB>', '<Down>']
let g:ycm_key_list_stop_completion = ['<C-y>']
let g:tsuquyomi_completion_detail = 1
let g:airline_theme='light'
let g:rufo_auto_formatting = 1
let g:closetag_filenames = '*.html'
let g:closetag_xhtml_filenames = '*.jsx,*.tsx'
let g:closetag_filetypes = 'html'
let g:closetag_xhtml_filetypes = 'tsx,jsx,typescriptreact,javascriptreact'
let g:closetag_emptyTags_caseSensitive = 1
let g:closetag_regions = {
    \ 'typescript.tsx': 'jsxRegion,tsxRegion',
    \ 'javascript.jsx': 'jsxRegion',
    \ }

call plug#begin('~/.vim/plugged')
Plug 'jremmen/vim-ripgrep'
Plug 'leafgarland/typescript-vim'
Plug 'vim-utils/vim-man'
Plug 'mbbill/undotree'
Plug 'prettier/vim-prettier', {
  \ 'do': 'yarn install',
  \ 'branch': 'release/0.x'
  \ }
" Plug 'Valloric/YouCompleteMe'
Plug 'dense-analysis/ale'
Plug 'sirosen/vim-rockstar'
Plug 'Quramy/tsuquyomi'
Plug 'nicwest/vim-camelsnek'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'unblevable/quick-scope'
Plug 'ruby-formatter/rufo-vim'
Plug 'tpope/vim-endwise'
Plug 'alvan/vim-closetag'
call plug#end()

:nnoremap <Leader>. <C-w>
:nnoremap <Leader>tsi :TsuImport<CR>
:nnoremap <Leader>v <C-v>
:nnoremap <Leader>s <C-s>
:nnoremap <Leader>e :Vex<CR>
:nnoremap <Leader>u :UndotreeToggle<CR>
:nnoremap <Leader>ps :Rg<SPACE>
:nnoremap <C-p> :GFiles<CR>
:nnoremap <silent> <Leader>gd :ALEGoToDefinition<CR>
" :nnoremap <silent> <Leader>gf :YcmCompleter FixIt<CR>
:nnoremap <Leader>y "*y
:vnoremap <Leader>y "*y
:nnoremap <Leader>p "*p
:nnoremap <Leader>r :%s/
" prettier uses leader p by default to format, but I remapped leader p for
" pasting from system clipboard
" enforce d as black hole register, and use x for cutting
:nnoremap d "_d
:nnoremap D "_D
:vnoremap d "_d
:vnoremap D "_D
" auto add closing brace
:inoremap {<CR> {<CR>}<Esc>ko
:inoremap [<CR> [<CR>]<Esc>ko
:inoremap (<CR> (<CR>)<Esc>ko
" game-changer: § is sooo much closer to w and q, doesn't involve shift, and
" is otherwise not used :)
:nmap § :
:nmap §w :w<CR>
:nmap §q :q<CR>
" corresponds to alt-h on mac
:nnoremap ˙ <C-w>h
" corresponds to alt-j on mac
:nnoremap ∆ <C-w>j
" corresponds to alt-k on mac
:nnoremap ˚ <C-w>k
" corresponds to alt-l on mac
:nnoremap ¬ <C-w>l

" move visual lines up and down
:vnoremap J :m'>+1<CR>gv=gv
:vnoremap K :m'>-2<CR>gv=gv

:cnoremap vr vertical resize

" jump between errors with ale
:nmap <silent> <C-k> <Plug>(ale_previous_wrap)
:nmap <silent> <C-j> <Plug>(ale_next_wrap)

autocmd FileType typescript :nmap <buffer> <Leader>n <Plug>(TsuquyomiRenameSymbol)
autocmd FileType typescript :nmap <buffer> <Leader>N <Plug>(TsuquyomiRenameSymbolC)
autocmd FileType typescript :nmap <Leader>f <Plug>(Prettier)

if &term =~ '^screen'
  " tmux will send xterm-style keys when its xterm-keys option is on
  execute "set <xUp>=\e[1;*A"
  execute "set <xDown>=\e[1;*B"
  execute "set <xRight>=\e[1;*C"
  execute "set <xLeft>=\e[1;*D"
endif
