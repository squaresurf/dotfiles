call plug#begin('~/.local/share/nvim/plugged')

Plug 'elmcast/elm-vim'
Plug 'sheerun/vim-polyglot'
let g:polyglot_disabled = ['elm', 'r']

Plug 'jalvesaq/Nvim-R'

Plug 'christoomey/vim-tmux-navigator'
Plug 'editorconfig/editorconfig-vim'
Plug 'jlanzarotta/bufexplorer'
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
Plug 'junegunn/goyo.vim'
Plug 'junegunn/limelight.vim'
Plug 'junegunn/seoul256.vim'
Plug 'justinmk/vim-dirvish'
Plug 'lervag/vimtex'
Plug 'ludovicchabant/vim-gutentags'
Plug 'majutsushi/tagbar'
Plug 'mattn/emmet-vim'
Plug 'rizzatti/dash.vim'
Plug 'sbdchd/neoformat'
Plug 'slashmili/alchemist.vim'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-git'
Plug 'tpope/vim-ragtag'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-rhubarb'
Plug 'tpope/vim-rsi'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'w0rp/ale'

" Initialize plugin system
call plug#end()

scriptencoding utf8

syntax on
colorscheme seoul256

set backspace=indent,eol,start
set cursorline
set dir=~/.vim-tmp//
set expandtab
set foldlevel=20
set foldmethod=indent
set hidden
set ignorecase
set list
set listchars=tab:»\ ,eol:\¬
set number
set relativenumber
set showcmd
set smartcase
set smartindent
set smarttab
set t_Co=256
set t_ut=
set wildmenu
set wildmode=longest,list,full

" Tell NeoVim to not try to load python
let g:loaded_python_provider = 1
let g:loaded_python3_provider = 1

" set leader to space
let g:mapleader = "\<space>"

" force unix lineendings
nnoremap <Leader>u :e ++ff=unix<cr>

" Quick buffer changes
nnoremap <Leader>l :b#<cr>

nnoremap <Leader>n :noh<cr>
nnoremap <Leader>d :Dash<cr>
nnoremap <Leader>h :ElmShowDocs<cr>
nnoremap <Leader>H :ElmBrowseDocs<cr>
nnoremap <Leader>z za
nnoremap <Leader>t :TagbarToggle<cr>
nnoremap <Leader>T :Tags<cr>
nnoremap <Leader>B :BTags<cr>

" copy and paste with the system clipboard
vmap <Leader>y "+y
vmap <Leader>d "+d
nmap <Leader>p "+p
nmap <Leader>P "+P
vmap <Leader>p "+p
vmap <Leader>P "+P

augroup filetypes
  autocmd BufNewFile,BufRead Capfile,Gemfile,Berksfile,Vagrantfile,Guardfile setlocal filetype=ruby
  autocmd BufNewFile,BufRead .eslintrc setlocal filetype=json
  autocmd BufNewFile,BufRead .envrc setlocal filetype=sh
  autocmd BufNewFile,BufRead *.m setlocal filetype=octave
augroup END

augroup goyo
  autocmd! User GoyoEnter Limelight
  autocmd! User GoyoLeave Limelight!
augroup END

augroup commentary
  autocmd FileType octave setlocal commentstring=%\ %s
augroup END

augroup neoformat
  autocmd!
  autocmd BufWritePre *.elm,*.js,*.jsx Neoformat
augroup END

let g:bufExplorerShowRelativePath = 1
let g:bufExplorerSortBy = "fullpath"
let g:bufExplorerSplitOutPathName = 0
nnoremap <Leader>e :BufExplorer<cr>

" set statusline+=%{gutentags#statusline()}
let g:gutentags_ctags_exclude = [
      \ ".git/*",
      \ "_build/*",
      \ "client/node_modules/*",
      \ "deps/*",
      \ "dist/*",
      \ "doc/*",
      \ "elm-stuff/*",
      \ "flow-typed/*",
      \ "node_modules/*",
      \ "tmp/*"
      \ ]

let g:jsx_ext_required = 0

let g:ale_cache_executable_check_failures = 1
let g:ale_open_list = 1
let g:ale_set_quickfix = 1

" RagTag
let g:ragtag_global_maps = 1

" FZF
nnoremap <Leader>o :Files<cr>
nnoremap <Leader>s :Find

command! -bang -nargs=* Find call fzf#vim#grep(
      \ 'rg --column --line-number --no-heading --fixed-strings --ignore-case --no-ignore --hidden --follow '.$RG_IGNORE.' --color "always" '.shellescape(<q-args>), 1, <bang>0)


let g:tagbar_left = 1
let g:tagbar_autofocus = 1
let g:tagbar_type_elixir = {
    \ 'ctagstype' : 'elixir',
    \ 'kinds' : [
        \ 'f:functions',
        \ 'functions:functions',
        \ 'c:callbacks',
        \ 'd:delegates',
        \ 'e:exceptions',
        \ 'i:implementations',
        \ 'a:macros',
        \ 'o:operators',
        \ 'm:modules',
        \ 'p:protocols',
        \ 'r:records',
        \ 't:tests'
    \ ]
\ }
