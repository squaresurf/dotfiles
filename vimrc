set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

" color shemes
Plugin 'chriskempson/vim-tomorrow-theme'

" Self Explanatory plugins
" Plugin 'jcf/vim-latex'
Plugin 'avdgaag/vim-phoenix'
Plugin 'benmills/vimux'
Plugin 'christoomey/vim-tmux-navigator'
Plugin 'editorconfig/editorconfig-vim'
Plugin 'ekalinin/Dockerfile.vim'
Plugin 'elixir-lang/vim-elixir'
Plugin 'elzr/vim-json.git'
Plugin 'evanmiller/nginx-vim-syntax'
Plugin 'fatih/vim-go'
Plugin 'flowtype/vim-flow'
Plugin 'glench/vim-jinja2-syntax'
Plugin 'groenewege/vim-less'
Plugin 'hail2u/vim-css3-syntax'
Plugin 'hhsnopek/vim-sugarss'
Plugin 'jalvesaq/Nvim-R'
Plugin 'jgdavey/vim-turbux'
Plugin 'jlanzarotta/bufexplorer'
Plugin 'junegunn/vim-easy-align'
Plugin 'kien/ctrlp.vim'
Plugin 'markcornick/vim-terraform.git'
Plugin 'mxw/vim-jsx'
Plugin 'nazo/pt.vim'
Plugin 'neomake/neomake'
Plugin 'pangloss/vim-javascript'
" Plugin 'rizzatti/dash.vim'
" Plugin 'scrooloose/syntastic'
Plugin 'slashmili/alchemist.vim'
Plugin 'slim-template/vim-slim'
Plugin 'sunaku/vim-ruby-minitest'
Plugin 'syngan/vim-vimlint'
Plugin 'tmux-plugins/vim-tmux'
Plugin 'tpope/vim-commentary'
Plugin 'tpope/vim-endwise'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-git'
Plugin 'tpope/vim-markdown'
Plugin 'tpope/vim-obsession'
Plugin 'tpope/vim-ragtag'
Plugin 'tpope/vim-rails'
Plugin 'tpope/vim-repeat'
Plugin 'tpope/vim-rsi'
Plugin 'tpope/vim-sleuth'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-unimpaired'
Plugin 'tpope/vim-vinegar'
Plugin 'vim-ruby/vim-ruby'
Plugin 'vim-scripts/taglist.vim'
Plugin 'ynkdir/vim-vimlparser'

" all of your plugins must be added before the following line
call vundle#end()            " required
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

" save a file
nnoremap <Leader>w :w<cr>

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
set tabstop=2 softtabstop=2 shiftwidth=2
autocmd FileType php,python setlocal tabstop=4 softtabstop=4 shiftwidth=4

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

" " latext settings
" " important: grep will sometimes skip displaying the file name if you
" " search in a singe file. this will confuse latex-suite. set your grep
" " program to always generate a file-name.
" set grepprg=grep\ -nh\ $*

" " optional: starting with vim 7, the filetype of empty .tex files defaults to
" " 'plaintex' instead of 'tex', which results in vim-latex not being loaded.
" " the following changes the default filetype back to 'tex':
" let g:tex_flavor='latex'
" let g:tex_treatmacviewerasunix = 1
" let g:tex_defaulttargetformat = 'dvi'
" let g:tex_viewrule_dvi = 'xdvi -s 3'
" let g:tex_compilerule_dvi = 'latex -src-specials -interaction=nonstopmode $*'
" " this turns off the placeholders and allows me to set <c-j> to what i want.
" let g:imap_useplaceholders = 0

" taglist options
" set the names of flags
let g:tlist_php_settings = 'php;c:class;f:function;d:constant'
" close all folds except for current file
let g:Tlist_File_Fold_Auto_Close = 1
" make tlist pane active when opened
let g:Tlist_GainFocus_On_ToggleOpen = 1
" width of window
let g:Tlist_WinWidth = 40
" set tlist to show on the right
let g:Tlist_Use_Right_Window = 1

" set custom file extension syntax
autocmd BufNewFile,BufRead Capfile,Gemfile,Berksfile,Vagrantfile,Guardfile setlocal filetype=ruby
autocmd BufNewFile,BufRead .eslintrc setlocal filetype=json
autocmd BufNewFile,BufRead .envrc setlocal filetype=sh

" open php documentation
autocmd FileType php setlocal keywordprg=~/bin/phpdoc.sh

autocmd! BufWritePost,BufEnter * Neomake
" function! neomake#makers#ft#elixir#EnabledMakers()
"     return ['elixir', 'credo']
" endfunction
"
" Configure a nice credo setup, courtesy https://github.com/neomake/neomake/pull/300
let g:neomake_elixir_enabled_makers = ['mix', 'mycredo', 'elixir']
function! NeomakeCredoErrorType(entry)
  if a:entry.type ==# 'F'      " Refactoring opportunities
    let l:type = 'W'
  elseif a:entry.type ==# 'D'  " Software design suggestions
    let l:type = 'I'
  elseif a:entry.type ==# 'W'  " Warnings
    let l:type = 'W'
  elseif a:entry.type ==# 'R'  " Readability suggestions
    let l:type = 'I'
  elseif a:entry.type ==# 'C'  " Convention violation
    let l:type = 'W'
  else
    let l:type = 'M'           " Everything else is a message
  endif
  let a:entry.type = l:type
endfunction

let g:neomake_elixir_mycredo_maker = {
      \ 'exe': 'mix',
      \ 'args': ['credo', 'list', '%:p', '--format=oneline'],
      \ 'errorformat': '[%t] %. %f:%l:%c %m,[%t] %. %f:%l %m',
      \ 'postprocess': function('NeomakeCredoErrorType')
      \ }

function! neomake#makers#ft#ruby#EnabledMakers()
    return ['mri', 'rubocop', 'reek']
endfunction

" " Old Syntastic Config
" " syntastic

" " 63 will log all debug messages
" " let g:syntastic_debug = 63
" let g:syntastic_c_checkers = ["oclint"]
" let g:syntastic_css_checkers = ["csslint"]
" let g:syntastic_go_checkers = ["gofmt", "govet", "go"]
" let g:syntastic_javascript_checkers = ["eslint"]
" let g:syntastic_php_checkers = ["php", "phpcs"]
" let g:syntastic_ruby_checkers = ["rubocop"]
" let g:syntastic_slim_checkers = ["slim_lint", "slimrb"]
" let g:syntastic_elixir_checkers = ["credo"]

" let g:syntastic_mode_map = { 'mode': 'active', 'passive_filetypes': ['go'] }

" let g:syntastic_python_pylint_post_args = '--msg-template="{path}:{line}:{column}:{C}: [{symbol} {msg_id}] {msg}"'

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
