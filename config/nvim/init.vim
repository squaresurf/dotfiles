" Specify a directory for plugins
call plug#begin('~/.local/share/nvim/plugged')

" Make sure you use single quotes

" color shemes
Plug 'chriskempson/vim-tomorrow-theme'

" Self Explanatory plugins
Plug 'avdgaag/vim-phoenix'
Plug 'b4b4r07/vim-hcl'
Plug 'benmills/vimux'
Plug 'christoomey/vim-tmux-navigator'
Plug 'editorconfig/editorconfig-vim'
Plug 'ekalinin/Dockerfile.vim'
Plug 'elixir-lang/vim-elixir'
Plug 'elmcast/elm-vim'
Plug 'elzr/vim-json'
Plug 'evanmiller/nginx-vim-syntax'
Plug 'fatih/vim-go'
Plug 'glench/vim-jinja2-syntax'
Plug 'groenewege/vim-less'
Plug 'hail2u/vim-css3-syntax'
Plug 'hashivim/vim-hashicorp-tools'
Plug 'hhsnopek/vim-sugarss'
Plug 'jalvesaq/Nvim-R'
Plug 'jgdavey/vim-turbux'
Plug 'jlanzarotta/bufexplorer'
Plug 'junegunn/vim-easy-align'
Plug 'kien/ctrlp.vim'
" Plug 'maralla/completor.vim'
Plug 'mattn/emmet-vim'
Plug 'mxw/vim-jsx'
Plug 'nazo/pt.vim'
Plug 'pangloss/vim-javascript'
Plug 'rizzatti/dash.vim'
Plug 'sbdchd/neoformat'
Plug 'slashmili/alchemist.vim'
Plug 'slim-template/vim-slim'
Plug 'syngan/vim-vimlint'
Plug 'tmux-plugins/vim-tmux'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-git'
Plug 'tpope/vim-markdown'
Plug 'tpope/vim-obsession'
Plug 'tpope/vim-ragtag'
Plug 'tpope/vim-rails'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-rsi'
Plug 'tpope/vim-sleuth'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-vinegar'
Plug 'vim-ruby/vim-ruby'
Plug 'vim-scripts/taglist.vim'
Plug 'w0rp/ale'
Plug 'ynkdir/vim-vimlparser'

" Initialize plugin system
call plug#end()

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

" search via pt
nnoremap <Leader>s :Pt

" open BufExplorer
nnoremap <Leader>e :BufExplorer<cr>

" turn off higlight
nnoremap <Leader>n :noh<cr>

" force unix lineendings
nnoremap <Leader>u :e ++ff=unix<cr>

nnoremap <Leader>d :Dash<cr>
nnoremap <Leader>h :ElmShowDocs<cr>
nnoremap <Leader>H :ElmBrowseDocs<cr>

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
colorscheme Tomorrow-Night

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
set cursorcolumn
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
let g:ctrlp_custom_ignore = '\v[\/](_build|priv|coverage|db/postgres|deps|node_modules|elm-stuff|public|tmp|.git|.direnv|.vagrant)$'

" tell ctrlp to use ripgrep
let g:ackprg = 'rg --vimgrep --no-heading'
if executable("rg")
    set grepprg=rg\ --vimgrep\ --no-heading
    set grepformat=%f:%l:%c:%m,%f:%l:%m
endif

" elm vim
let g:elm_format_autosave = 1

" vimux
let g:VimuxOrientation = "h"

" turbux
let g:turbux_command_rspec = "rubyspec"
let g:turbux_command_test_unit = "rubyunit"
let g:turbux_command_elixir_test = "time mixtest"

" Neoformat

" Write on save
autocmd BufWritePre *.js Neoformat

" RagTag
let g:ragtag_global_maps = 1
