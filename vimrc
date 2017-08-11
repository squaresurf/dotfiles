set nocompatible              " be iMproved, required
filetype off                  " required

" " set the runtime path to include Vundle and initialize
" set rtp+=~/.vim/bundle/Vundle.vim
" call vundle#begin()
" " alternatively, pass a path where Vundle should install plugins
" "call vundle#begin('~/some/path/here')

" " let Vundle manage Vundle, required
" Plugin 'gmarik/Vundle.vim'

" " color shemes
" Plugin 'chriskempson/vim-tomorrow-theme'

" " Self Explanatory plugins
" Plugin 'avdgaag/vim-phoenix'
" Plugin 'b4b4r07/vim-hcl'
" Plugin 'benmills/vimux'
" Plugin 'christoomey/vim-tmux-navigator'
" Plugin 'editorconfig/editorconfig-vim'
" Plugin 'ekalinin/Dockerfile.vim'
" Plugin 'elixir-lang/vim-elixir'
" Plugin 'elzr/vim-json.git'
" Plugin 'evanmiller/nginx-vim-syntax'
" Plugin 'fatih/vim-go'
" Plugin 'glench/vim-jinja2-syntax'
" Plugin 'groenewege/vim-less'
" Plugin 'hail2u/vim-css3-syntax'
" Plugin 'hashivim/vim-hashicorp-tools'
" Plugin 'hhsnopek/vim-sugarss'
" Plugin 'jalvesaq/Nvim-R'
" Plugin 'jgdavey/vim-turbux'
" Plugin 'jlanzarotta/bufexplorer'
" Plugin 'junegunn/vim-easy-align'
" Plugin 'kien/ctrlp.vim'
" Plugin 'lambdatoast/elm.vim'
" Plugin 'mxw/vim-jsx'
" Plugin 'nazo/pt.vim'
" Plugin 'pangloss/vim-javascript'
" Plugin 'rizzatti/dash.vim'
" Plugin 'slashmili/alchemist.vim'
" Plugin 'slim-template/vim-slim'
" Plugin 'syngan/vim-vimlint'
" Plugin 'tmux-plugins/vim-tmux'
" Plugin 'tpope/vim-commentary'
" Plugin 'tpope/vim-endwise'
" Plugin 'tpope/vim-fugitive'
" Plugin 'tpope/vim-git'
" Plugin 'tpope/vim-markdown'
" Plugin 'tpope/vim-obsession'
" Plugin 'tpope/vim-ragtag'
" Plugin 'tpope/vim-rails'
" Plugin 'tpope/vim-repeat'
" Plugin 'tpope/vim-rsi'
" Plugin 'tpope/vim-sleuth'
" Plugin 'tpope/vim-surround'
" Plugin 'tpope/vim-unimpaired'
" Plugin 'tpope/vim-vinegar'
" Plugin 'vim-ruby/vim-ruby'
" Plugin 'vim-scripts/taglist.vim'
" Plugin 'w0rp/ale'
" Plugin 'ynkdir/vim-vimlparser'

" " all of your plugins must be added before the following line
" call vundle#end()            " required
filetype plugin indent on    " required

set backspace=indent,eol,start

" set up folding
set foldmethod=indent
" unfold the file on load
set foldlevel=20

" set up invisible chars view
scriptencoding utf8
set listchars=tab:»\ ,eol:\¬
set list

" update tab completion to be more akin to bash.
set wildmode=longest,list,full
set wildmenu

" smart casing when searching
set ignorecase
set smartcase

" set leader to space
let g:mapleader = "\<space>"

" see errors
nnoremap <Leader>s :Pt

" rubocop the errors
nnoremap <Leader>f :!rubocop -a %<cr>

" run neomake
nnoremap <Leader>r :Neomake<cr>

" open BufExplorer
nnoremap <Leader>e :BufExplorer<cr>

" turn off higlight
nnoremap <Leader>n :noh<cr>

" force unix lineendings
nnoremap <Leader>u :e ++ff=unix<cr>

nnoremap <Leader>d :Dash<cr>

" copy and paste with the system clipboard
vmap <Leader>y "+y
vmap <Leader>d "+d
nmap <Leader>p "+p
nmap <Leader>P "+P
vmap <Leader>p "+p
vmap <Leader>P "+P

" stop that stupid window from popping up.
map q: :q

" save all vim tmp files to ~/.vim-tmp/
set dir=~/.vim-tmp//

" set 256 colors
set t_Co=256

" disable background color erase
set t_ut=

" Quick buffer changes
nnoremap <Leader>l :b#<cr>
nnoremap <Leader>k :bn<cr>
nnoremap <Leader>j :bp<cr>

syntax on
" colorscheme Tomorrow-Night

set omnifunc=syntaxcomplete#Complete

set smartindent
set smarttab
set expandtab

" get more info about commands and visual selections
set showcmd

" turn on 256 colors for vim
set t_co=256

" allow switching between modified buffers
set hidden

" show line numbers
set number
set relativenumber

" Set netrw to allow line numbers
let g:netrw_bufsettings = 'noma nomod nu nobl nowrap ro'

" cursor settings
" set cursorcolumn
set cursorline

" bufexplorer settings
let g:bufExplorerShowRelativePath = 1
let g:bufExplorerSortBy = "fullpath"
let g:bufExplorerSplitOutPathName = 0

" set custom file extension syntax
autocmd BufNewFile,BufRead Capfile,Gemfile,Berksfile,Vagrantfile,Guardfile setlocal filetype=ruby
autocmd BufNewFile,BufRead .eslintrc setlocal filetype=json
autocmd BufNewFile,BufRead .envrc setlocal filetype=sh

" start interactive easyalign in visual mode (e.g. vip<enter>)
vmap <Enter> <Plug>(EasyAlign)

" start interactive easyalign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)<f37>

" mxw/vim-jsx
let g:jsx_ext_required = 0

" ctrlp
nnoremap <Leader>o :CtrlP<cr>
nnoremap <Leader>pc :CtrlPClearCache<cr>
let g:ctrlp_show_hidden = 1
let g:ctrlp_open_multiple_files = '1vjr'
let g:ctrlp_custom_ignore = '\v[\/](_build|coverage|db/postgres|deps|node_modules|tmp|.git|.direnv|.vagrant)$'

" tell ctrlp to use ripgrep
let g:ackprg = 'rg --vimgrep --no-heading'
if executable("rg")
    set grepprg=rg\ --vimgrep\ --no-heading
    set grepformat=%f:%l:%c:%m,%f:%l:%m
endif

" vimux
let g:VimuxOrientation = "h"

" turbux
let g:turbux_command_rspec = "rubyspec"
let g:turbux_command_test_unit = "rubyunit"
let g:turbux_command_elixir_test = "time mixtest"
