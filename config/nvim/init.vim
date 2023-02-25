call plug#begin('~/.local/share/nvim/plugged')

Plug 'benmills/vimux'
Plug 'christoomey/vim-tmux-navigator'
Plug 'editorconfig/editorconfig-vim'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'lervag/vimtex'
Plug 'shaunsingh/nord.nvim'
Plug 'sheerun/vim-polyglot'
Plug 'shumphrey/fugitive-gitlab.vim'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-git'
Plug 'tpope/vim-ragtag'
Plug 'tpope/vim-rails'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-rhubarb'
Plug 'tpope/vim-rsi'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-vinegar'
Plug '~/code/vision.vim'

" Initialize plugin system
call plug#end()

scriptencoding utf8

syntax on
colorscheme nord

set conceallevel=2 " conceal markdown links
set backspace=indent,eol,start
set cursorline
set expandtab
set foldlevel=20
set foldmethod=indent
set hidden
set ignorecase
set list
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

" " Tell NeoVim to not try to load python
let g:loaded_python_provider = 1
let g:loaded_python3_provider = 1

let g:mapleader = "\<space>"
let g:maplocalleader = "\<space>l"

" force unix lineendings
nnoremap <leader>u :e ++ff=unix<cr>

" quick view of markdown
nnoremap <leader>m :!pandoc % -s -o /tmp/$(basename %).pdf && open -a skim /tmp/$(basename %).pdf<cr>
nnoremap <localleader>m :!pandoc % -s -o /tmp/$(basename %).html && open /tmp/$(basename %).html<cr>

nnoremap <leader>s :source ~/.config/nvim/init.vim<cr>
nnoremap <leader>S :vs ~/.config/nvim/init.vim<cr>
nnoremap <leader>n :noh<cr>
nnoremap <leader>l f(l

" copy and paste with the system clipboard
vnoremap <leader>y "+y
vnoremap <leader>d "+d
nnoremap <leader>p "+p
nnoremap <leader>P "+P
vnoremap <leader>p "+p
vnoremap <leader>P "+P

augroup filetypes
  autocmd!
  autocmd BufNewFile,BufRead *.m setlocal filetype=octave
  autocmd BufNewFile,BufRead *.mmd setlocal filetype=mermaid
  autocmd BufNewFile,BufRead *.nomad setlocal filetype=hcl
  autocmd BufNewFile,BufRead *.sarif setlocal filetype=json
  autocmd BufNewFile,BufRead .envrc setlocal filetype=sh
  autocmd BufNewFile,BufRead .eslintrc setlocal filetype=json
  autocmd BufNewFile,BufRead Capfile,Gemfile,Berksfile,Vagrantfile,Guardfile setlocal filetype=ruby
  autocmd BufNewFile,BufRead Dockerfile.* setlocal filetype=dockerfile
augroup END

augroup commentary
  autocmd!
  autocmd FileType octave setlocal commentstring=%\ %s
  autocmd FileType mermaid setlocal commentstring=%%\ %s
augroup END

" FZF
set rtp+=/usr/local/opt/fzf
set grepprg=rg\ --vimgrep
command! -bang -nargs=* Rg
      \ call fzf#vim#grep(
      \   'rg --column --line-number --no-heading --color=always '.$RG_IGNORE.' '.shellescape(<q-args>), 1,
      \   <bang>0 ? fzf#vim#with_preview('up:60%')
      \           : fzf#vim#with_preview('right:50%:hidden', '?'),
      \   <bang>0)
      " \ 'rg --column --line-number --no-heading --fixed-strings --ignore-case --no-ignore --hidden --follow '.$RG_IGNORE.' --color "always" '.shellescape(<q-args>), 3, <bang>0)

nnoremap <leader>b :Buffers<cr>
nnoremap <leader>f :Files<cr>
nnoremap <leader>/ :Rg<cr>
nnoremap <localleader>/ :Rg

""" Language Specific Things """

""""" LaTeX
let g:tex_flavor = 'latex'

""""" Runners
augroup runners
  autocmd!
  autocmd FileType rust nnoremap <buffer> <localleader>r :!cargo run<cr>
  autocmd FileType rust nnoremap <buffer> <localleader>R :!cargo test<cr>
augroup END
