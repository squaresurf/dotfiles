call plug#begin('~/.local/share/nvim/plugged')

Plug 'sheerun/vim-polyglot'

Plug 'elmcast/elm-vim'
Plug 'jalvesaq/Nvim-R'

Plug 'benmills/vimux'
Plug 'chriskempson/vim-tomorrow-theme'
Plug 'christoomey/vim-tmux-navigator'
Plug 'editorconfig/editorconfig-vim'
Plug 'jgdavey/vim-turbux'
Plug 'jlanzarotta/bufexplorer'
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
Plug 'lervag/vimtex'
Plug 'ludovicchabant/vim-gutentags'
Plug 'mattn/emmet-vim'
Plug 'rizzatti/dash.vim'
Plug 'sbdchd/neoformat'
Plug 'scrooloose/nerdtree'
Plug 'slashmili/alchemist.vim'
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
Plug 'w0rp/ale'
Plug 'ynkdir/vim-vimlparser'

" Initialize plugin system
call plug#end()

scriptencoding utf8

syntax on
"colorscheme Tomorrow-Night
colorscheme default

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

" set leader to space
let g:mapleader = "\<space>"

" force unix lineendings
nnoremap <Leader>u :e ++ff=unix<cr>

" Quick buffer changes
nnoremap <Leader>l :b#<cr>
nnoremap <Leader>k :bn<cr>
nnoremap <Leader>j :bp<cr>

nnoremap <Leader>n :noh<cr>
nnoremap <Leader>d :Dash<cr>
nnoremap <Leader>h :ElmShowDocs<cr>
nnoremap <Leader>H :ElmBrowseDocs<cr>
nnoremap <Leader>z za
nnoremap <Leader>a :ALENext<cr>

" copy and paste with the system clipboard
vmap <Leader>y "+y
vmap <Leader>d "+d
nmap <Leader>p "+p
nmap <Leader>P "+P
vmap <Leader>p "+p
vmap <Leader>P "+P

" nerdtree settings
nnoremap - :Explore<cr>
let g:NERDTreeShowLineNumbers=1

augroup filetypes
  autocmd BufNewFile,BufRead Capfile,Gemfile,Berksfile,Vagrantfile,Guardfile setlocal filetype=ruby
  autocmd BufNewFile,BufRead .eslintrc setlocal filetype=json
  autocmd BufNewFile,BufRead .envrc setlocal filetype=sh
  autocmd BufNewFile,BufRead *.m setlocal filetype=octave
augroup END

augroup commentary
  autocmd FileType octave setlocal commentstring=%\ %s
augroup END

let g:bufExplorerShowRelativePath = 1
let g:bufExplorerSortBy = "fullpath"
let g:bufExplorerSplitOutPathName = 0
nnoremap <Leader>e :BufExplorer<cr>

let g:polyglot_disabled = ['elm', 'r']

let g:gutentags_cache_dir = '~/.tags_cache'

let g:jsx_ext_required = 0

let g:turbux_command_rspec = "rubyspec"
let g:turbux_command_test_unit = "rubyunit"
let g:turbux_command_elixir_test = "time mixtest"

augroup neoformat
  autocmd!
  autocmd BufWritePre * Neoformat
augroup END

" RagTag
let g:ragtag_global_maps = 1

" FZF
nnoremap <Leader>o :Files<cr>
nnoremap <Leader>s :Find

command! -bang -nargs=* Find call fzf#vim#grep(
      \ 'rg --column --line-number --no-heading --fixed-strings --ignore-case --no-ignore --hidden --follow '.$RG_IGNORE.' --color "always" '.shellescape(<q-args>), 1, <bang>0)
