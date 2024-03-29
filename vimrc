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
set colorcolumn=100
set textwidth=100
set scrolloff=10
set autoread
set relativenumber
set number
set wildmenu
set ruler
set tags=.git/tags,./tags,tags;$HOME
set lazyredraw
set ttyfast
if !has("nvim")
  " allow mouse to work beyond 220th column
  set ttymouse=sgr
endif
set mouse=a

highlight ColorColumn ctermbg=188
highlight Pmenu ctermbg=137 guibg=LightSalmon3 ctermfg=254 guifg=Grey89
highlight VertSplit ctermbg=54 ctermfg=54 guibg=Purple4 guifg=Purple4
highlight Visual ctermfg=15 ctermbg=89 guifg=White guibg=LightBlue
highlight PmenuThumb ctermbg=94 guibg=Orange4 ctermfg=180 guifg=Tan

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
\   'ruby': ['rufo'],
\}
let g:ale_fix_on_save = 1
let g:ale_completion_enabled = 1
let g:ale_linters = {
\   'javascript': ['eslint'],
\   'typescript': ['eslint'],
\   'typescriptreact': ['eslint'],
\}
" let g:ale_floating_window_border = ['║','═','╔','╗','╝','╚','║','═',]

if executable('rg')
  let g:rg_derive_root='true'
endif
let g:netrw_banner = 0
let g:netrw_browse_split = 2
let g:netrw_winsize = 15
let g:tsuquyomi_completion_detail = 1
" gui vim only
" set ballooneval
" autocmd FileType typescript setlocal balloonexpr=tsuquyomi#balloonexpr()

" let g:rufo_auto_formatting = 1
let g:SuperTabDefaultCompletionType = "<c-n>"
" use ctags to go to definition in ruby
" autocmd FileType ruby :nnoremap <Leader>gd <C-]>

" if executable('tsserver')
"     au User lsp_setup call lsp#register_server({
"         \ 'name': 'tsserver',
"         \ 'cmd': {server_info->['tsserver']},
"         \ 'allowlist': ['typescript', 'typescriptreact', 'javascript'],
"         \ })
" endif

if executable('ruby-lsp')
    au User lsp_setup call lsp#register_server({
        \ 'name': 'ruby-lsp',
        \ 'cmd': {server_info->['ruby-lsp']},
        \ 'allowlist': ['ruby'],
        \ })
endif

function! s:on_lsp_buffer_enabled() abort
    setlocal omnifunc=lsp#complete
    setlocal signcolumn=yes
    if exists('+tagfunc') | setlocal tagfunc=lsp#tagfunc | endif
    nmap <buffer> gd <plug>(lsp-definition)
    nmap <buffer> gr <plug>(lsp-references)
    nmap <buffer> gi <plug>(lsp-implementation)
    nmap <buffer> <leader>rn <plug>(lsp-rename)
    nmap <buffer> [g <Plug>(lsp-previous-diagnostic)
    nmap <buffer> ]g <Plug>(lsp-next-diagnostic)
    nmap <buffer> K <plug>(lsp-hover)

    " refer to doc to add more commands
endfunction

augroup lsp_install
    au!
    " call s:on_lsp_buffer_enabled only for languages that has the server registered.
    au User lsp_buffer_enabled call s:on_lsp_buffer_enabled()
augroup END

let g:lsp_document_code_action_signs_enabled = 0

" let g:LanguageClient_serverCommands = {
"   \ 'typescript': ['tsserver'],
"   \ 'typescriptreact': ['tsserver'],
"   \ 'javascript': ['tsserver'],
"   \ }

highlight iCursor ctermfg=Black ctermbg=Black guibg=Black guifg=Black
highlight vCursor ctermfg=89 ctermbg=89 guibg=DeepPink4 guibg=DeepPink4
set guicursor=n-c:block-blinkon0-Cursor,i-ci:block-blinkon175-blinkoff175-iCursor,v:hor100-blinkon175-blinkoff175-vCursor

call plug#begin('~/.vim/plugged')
Plug 'jremmen/vim-ripgrep'
Plug 'leafgarland/typescript-vim'
Plug 'mbbill/undotree'
Plug 'prettier/vim-prettier', {
  \ 'do': 'yarn install',
  \ 'branch': 'release/0.x'
  \ }
Plug 'dense-analysis/ale'
Plug 'Quramy/tsuquyomi'
Plug 'nicwest/vim-camelsnek'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-commentary'
Plug 'jgdavey/vim-blockle'
Plug 'prabirshrestha/vim-lsp'
Plug 'rhysd/vim-lsp-ale'
Plug 'mattn/vim-lsp-settings'
Plug 'vim-ruby/vim-ruby'
Plug 'tpope/vim-dadbod'
Plug 'kristijanhusak/vim-dadbod-ui'
Plug 'tpope/vim-dotenv'
Plug 'AndrewRadev/splitjoin.vim'
Plug 'vim-crystal/vim-crystal'
Plug 'justinmk/vim-syntax-extra'
Plug 'rrethy/vim-hexokinase', { 'do': 'make hexokinase' }
Plug 'johansenja/qdocs-vim'
Plug 'justinmk/vim-sneak'
Plug 'ervandew/supertab'
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install'  }
Plug 'Shougo/vimproc.vim', { 'do': 'make' }
Plug 'jmg5e/vim-css-js-converter'
call plug#end()

:nmap <Leader>. <C-w>
:nnoremap <Leader>tsi :TsuImport<CR>
:nnoremap <Leader>v <C-v>
:nnoremap <Leader>s <C-s>
:nnoremap <Leader>e :Vex<CR>
:nnoremap <Leader>u :UndotreeToggle<CR>
" ÷ = alt+/ on mac
:nnoremap ÷ :Rg<SPACE>
:nnoremap <Leader>/ *
:nnoremap <C-p> :GFiles<CR>
:nnoremap <silent> <Leader>gd :ALEGoToDefinition<CR>
" :nnoremap <silent> <Leader>gf :YcmCompleter FixIt<CR>
:nnoremap <Leader>y "*y
:vnoremap <Leader>y "*y
:nnoremap <Leader>p "*p
:nnoremap <Leader>r "zyiw :%s/<C-r>z
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
:nmap <Leader>s <C-w>v<C-w>l<C-]>
" corresponds to alt-h on mac
:nnoremap ˙ <C-w>h
" corresponds to alt-j on mac
:nnoremap ∆ <C-w>j
" corresponds to alt-k on mac
:nnoremap ˚ <C-w>k
" corresponds to alt-l on mac
:nnoremap ¬ <C-w>l
" go to css file
:nnoremap <Leader>css :vsp <C-R>=expand('%:p:r') . '.module.scss'<CR><CR>

function DbGuiNewtab()
  :tabe
  :DBUI
endfunction
:nnoremap <Leader>db :exec DbGuiNewtab()<CR>

" move visual lines up and down
:vnoremap J :m'>+1<CR>gv=gv
:vnoremap K :m'>-2<CR>gv=gv

:cnoremap vr vertical resize

" jump between errors with ale
:nmap <silent> <C-k> <Plug>(ale_previous_wrap)
:nmap <silent> <C-j> <Plug>(ale_next_wrap)
:nmap <Leader>h :LspHover<CR>
:nmap <Leader>d :LspPeekDefinition<CR>
:nmap <Leader>a :LspCodeAction<CR>

:nmap <Leader>j :%!jq .<CR>

autocmd FileType typescript :nmap <buffer> <Leader>n <Plug>(TsuquyomiRenameSymbol)
autocmd FileType typescript :nmap <buffer> <Leader>N <Plug>(TsuquyomiRenameSymbolC)
autocmd FileType typescript :nmap <Leader>f <Plug>(Prettier)
autocmd FileType typescript :inoremap <C-q> <C-x><C-o>
autocmd FileType typescriptreact :inoremap <C-q> <C-x><C-o>

" use leader enter to open file from quick fix in new vertical split
autocmd! FileType qf nnoremap <buffer> <leader><Enter> <C-w><Enter><C-w>L

if &term =~ '^screen'
  " tmux will send xterm-style keys when its xterm-keys option is on
  execute "set <xUp>=\e[1;*A"
  execute "set <xDown>=\e[1;*B"
  execute "set <xRight>=\e[1;*C"
  execute "set <xLeft>=\e[1;*D"
endif

" crystal syntax for gloss files (for now)
autocmd BufNewFile,BufRead *.gl set syntax=crystal

set wildignore+=.git,log/*,tmp/*,.DS_Store,*.zip,*.tgz,*.ico,*.jpg,*.png,*.gif,.config,.cache,node_modules/*,*.min.*
" global find/replace inside working directory
function! FindReplace()
  set noignorecase
  " figure out which directory we're in
	let dir = expand('%:h')
  " ask for patterns
  call inputsave()
  let find = input('[global find and replace] Pattern: ')
  call inputrestore()
  let replace = input('[global find and replace] Replacement: ')
  call inputrestore()
  " are you sure?
  let confirm = input('[global find and replace] WARNING: About to replace ' . find . ' with ' . replace . ' in ' . dir . '/**/* (y/n):')
  " clear echoed message
  :redraw
  if confirm == 'y'
    " find with rigrep (populate quickfix )
    :silent exe 'Rg ' . find
    " use cfdo to substitute on all quickfix files
    :silent exe 'cfdo %s/' . find . '/' . replace . '/g | update'
    " close quickfix window
    :silent exe 'cclose'
    :echom('Replaced ' . find . ' with ' . replace . ' in all files in ' . dir )
  else
    :echom('Find/Replace Aborted :(')
    return
  endif
endfunction
:nnoremap ® :call FindReplace()<CR>

let g:airline_theme='soda'
" soda doesn't have this by default
au VimEnter * if exists('airline#themes#soda#palette') | let g:airline#themes#soda#palette.normal_modified = { 'airline_c': [ '#ffffff', '#d75faf', 255, 169, ''] } | endif
