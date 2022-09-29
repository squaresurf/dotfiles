call plug#begin('~/.local/share/nvim/plugged')

Plug 'benmills/vimux'
Plug 'christoomey/vim-tmux-navigator'
Plug 'editorconfig/editorconfig-vim'
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
Plug 'jgdavey/vim-turbux'
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
Plug 'junegunn/seoul256.vim'
Plug 'lervag/vimtex'
Plug 'ludovicchabant/vim-gutentags'
Plug 'majutsushi/tagbar'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'rizzatti/dash.vim'
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
colorscheme seoul256
" colorscheme seoul256-light

" Transparent background
hi Normal guibg=NONE ctermbg=NONE

" set background=light
set conceallevel=2 " conceal markdown links
set backspace=indent,eol,start
set cursorline
set expandtab
set foldlevel=20
set foldmethod=indent
set hidden
set ignorecase
set list
" set listchars=tab:»\ ,eol:\¬
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

" set leader to space
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
nnoremap <leader>d :Dash<cr>
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

" Turbux
let g:turbux_command_prefix = 'bin/spring'

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

" Tags
let g:gutentags_ctags_exclude = [
      \ "**/.direnv/*",
      \ "**/.elixir_ls/*",
      \ "**/.git/*",
      \ "**/.hypothesis/*",
      \ "**/.mypy_cache/*",
      \ "**/.pytest_cache/*",
      \ "**/.serverless/*",
      \ "**/_build/*",
      \ "**/client/node_modules/*",
      \ "**/compiled/*",
      \ "**/deps/*",
      \ "**/dist/*",
      \ "**/doc/*",
      \ "**/elm-stuff/*",
      \ "**/flow-typed/*",
      \ "**/htmlcov/*",
      \ "**/node_modules/*",
      \ "**/serverless/lib/*",
      \ "**/tests/elm-stuff/*",
      \ "**/tmp/*",
      \ ".direnv/*",
      \ ".elixir_ls/*",
      \ ".git/*",
      \ ".hypothesis/*",
      \ ".mypy_cache/*",
      \ ".pytest_cache/*",
      \ ".serverless/*",
      \ "_build/*",
      \ "client/node_modules/*",
      \ "compiled/*",
      \ "deps/*",
      \ "dist/*",
      \ "doc/*",
      \ "elm-stuff/*",
      \ "flow-typed/*",
      \ "htmlcov/*",
      \ "node_modules/*",
      \ "serverless/lib/*",
      \ "tests/elm-stuff/*",
      \ "tmp/*"
      \ ]

let g:tagbar_left = 1
let g:tagbar_autoclose = 1
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

nnoremap <silent> <localleader>t  :TagbarToggle<cr>

""""""""""" START Coc stuff """""""""""""""""""""""
" Set info color text to something readable.
highlight CocInfoSign ctermfg=144 guifg=#BDBC98

" if hidden is not set, TextEdit might fail.
set hidden

" Some servers have issues with backup files, see #649
set nobackup
set nowritebackup

" Better display for messages
" set cmdheight=2

" You will have bad experience for diagnostic messages when it's default 4000.
set updatetime=300

" don't give |ins-completion-menu| messages.
set shortmess+=c

" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use `[c` and `]c` to navigate diagnostics
nmap <silent> [c <Plug>(coc-diagnostic-prev)
nmap <silent> ]c <Plug>(coc-diagnostic-next)

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight symbol under cursor on CursorHold
augroup coc
  autocmd!
  autocmd CursorHold * silent call CocActionAsync('highlight')
augroup END

" Remap for rename current word
nmap <leader>rn <Plug>(coc-rename)

" Remap for do codeAction of selected region, ex: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap for do codeAction of current line
nmap <leader>ac  <Plug>(coc-codeaction)
" Fix autofix problem of current line
nmap <leader>qf  <Plug>(coc-fix-current)

" Using CocList
" Show all diagnostics
nnoremap <silent> <localleader>a  :<C-u>CocList diagnostics<cr>
" Manage extensions
nnoremap <silent> <localleader>e  :<C-u>CocList extensions<cr>
" Show commands
nnoremap <silent> <localleader>c  :<C-u>CocList commands<cr>
" Find symbol of current document
nnoremap <silent> <localleader>o  :<C-u>CocList outline<cr>
" Search workspace symbols
nnoremap <silent> <localleader>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent> <leader>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent> <leader>k  :<C-u>CocPrev<CR>
" Resume latest coc list
nnoremap <silent> <localleader>p  :<C-u>CocListResume<CR>

""""""""""" Plugins """"""""""""""
" Requires CocInstall coc-prettier and format on save config.
command! -nargs=0 Prettier :call CocAction('runCommand', 'prettier.formatFile')

""""""""""" END Coc stuff """""""""""""""""""""""

""" Language Specific Things """

""""" LaTeX
let g:tex_flavor = 'latex'

""""" Go
augroup go
  autocmd!
  autocmd BufWritePre *.go :GoImports
  autocmd BufWritePre *.go :GoFmt
  " autocmd BufWritePre *.go :GoLint
augroup END

""""" Runners
augroup runners
  autocmd!
  autocmd FileType rust nnoremap <buffer> <localleader>r :RustRun<cr>
  autocmd FileType go nnoremap <buffer> <localleader>r :GoRun<cr>
augroup END
