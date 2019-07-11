call plug#begin('~/.local/share/nvim/plugged')

" Plug 'elmcast/elm-vim'
" Temporarily point at fork in order to support elm 0.19
" Plug 'zaptic/elm-vim'
Plug 'sheerun/vim-polyglot'
" let g:polyglot_disabled = ['elm', 'r']

" Plug 'jalvesaq/Nvim-R'

" Plug 'slashmili/alchemist.vim'
Plug 'christoomey/vim-tmux-navigator'
Plug 'editorconfig/editorconfig-vim'
" Plug 'guns/vim-sexp'
" Plug 'jlanzarotta/bufexplorer'
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
" Plug 'junegunn/goyo.vim'
" Plug 'junegunn/limelight.vim'
Plug 'junegunn/seoul256.vim'
" Plug 'justinmk/vim-dirvish'
" Plug 'kien/rainbow_parentheses.vim'
" Plug 'lervag/vimtex'
" Plug 'ludovicchabant/vim-gutentags'
" Plug 'majutsushi/tagbar'
" Plug 'mattn/emmet-vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
" Plug 'neoclide/coc.nvim', {'do': 'yarn install --frozen-lockfile'}
" Plug 'rizzatti/dash.vim'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-endwise'
" Plug 'tpope/vim-fireplace'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-git'
Plug 'tpope/vim-ragtag'
Plug 'tpope/vim-repeat'
" Plug 'tpope/vim-rhubarb'
Plug 'tpope/vim-rsi'
" Plug 'tpope/vim-sexp-mappings-for-regular-people'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-vinegar'
" Plug 'venantius/vim-cljfmt', { 'tag': '0.6' }
" Plug 'w0rp/ale'

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

" " Tell NeoVim to not try to load python
" let g:loaded_python_provider = 1
" let g:loaded_python3_provider = 1

" set leader to space
let g:mapleader = "\<space>"
let g:maplocalleader = "\<space>\<space>"

" force unix lineendings
nnoremap <leader>u :e ++ff=unix<cr>

" Quick buffer changes
nnoremap <leader>l :b#<cr>

nnoremap <leader>n :noh<cr>
nnoremap <leader>d :Dash<cr>
nnoremap <leader>h :ElmShowDocs<cr>
" nnoremap <leader>H :ElmBrowseDocs<cr>
" nnoremap <leader>z za
" nnoremap <leader>t :Tagbar<cr>
" nnoremap <leader>T :Tags<cr>
" nnoremap <leader>B :BTags<cr>
" nnoremap <leader>g :Goyo<cr>:Limelight!!<cr>
" nnoremap <leader>m :ALENext<cr>

" copy and paste with the system clipboard
vmap <leader>y "+y
vmap <leader>d "+d
nmap <leader>p "+p
nmap <leader>P "+P
vmap <leader>p "+p
vmap <leader>P "+P

augroup filetypes
  autocmd!
  autocmd BufNewFile,BufRead Capfile,Gemfile,Berksfile,Vagrantfile,Guardfile setlocal filetype=ruby
  autocmd BufNewFile,BufRead .eslintrc setlocal filetype=json
  autocmd BufNewFile,BufRead .envrc setlocal filetype=sh
  autocmd BufNewFile,BufRead *.m setlocal filetype=octave
augroup END

augroup commentary
  autocmd!
  autocmd FileType octave setlocal commentstring=%\ %s
augroup END

" let g:rbpt_colorpairs = [
"       \ [ '13', '#6c71c4'],
"       \ [ '5',  '#d33682'],
"       \ [ '1',  '#dc322f'],
"       \ [ '9',  '#cb4b16'],
"       \ [ '3',  '#b58900'],
"       \ [ '2',  '#859900'],
"       \ [ '6',  '#2aa198'],
"       \ [ '4',  '#268bd2'],
"       \ ]

" " augroup lisp
" "   autocmd!
" "   autocmd VimEnter * RainbowParenthesesToggle
" "   autocmd Syntax * RainbowParenthesesLoadChevron
" "   autocmd Syntax * RainbowParenthesesLoadRound
" "   autocmd Syntax * RainbowParenthesesLoadSquare
" "   autocmd Syntax * RainbowParenthesesLoadBraces
" " augroup END

" let g:bufExplorerShowRelativePath = 1
" let g:bufExplorerSortBy = "fullpath"
" let g:bufExplorerSplitOutPathName = 0
" nnoremap <leader>e :BufExplorer<cr>
nnoremap <leader>e :Buffers<cr>

" " " set statusline+=%{gutentags#statusline()}
" " " let g:gutentags_ctags_exclude = [
" " "       \ "**/.direnv/*",
" " "       \ "**/.elixir_ls/*",
" " "       \ "**/.git/*",
" " "       \ "**/.hypothesis/*",
" " "       \ "**/.mypy_cache/*",
" " "       \ "**/.pytest_cache/*",
" " "       \ "**/.serverless/*",
" " "       \ "**/_build/*",
" " "       \ "**/client/node_modules/*",
" " "       \ "**/compiled/*",
" " "       \ "**/deps/*",
" " "       \ "**/dist/*",
" " "       \ "**/doc/*",
" " "       \ "**/elm-stuff/*",
" " "       \ "**/flow-typed/*",
" " "       \ "**/htmlcov/*",
" " "       \ "**/node_modules/*",
" " "       \ "**/serverless/lib/*",
" " "       \ "**/tests/elm-stuff/*",
" " "       \ "**/tmp/*",
" " "       \ ".direnv/*",
" " "       \ ".elixir_ls/*",
" " "       \ ".git/*",
" " "       \ ".hypothesis/*",
" " "       \ ".mypy_cache/*",
" " "       \ ".pytest_cache/*",
" " "       \ ".serverless/*",
" " "       \ "_build/*",
" " "       \ "client/node_modules/*",
" " "       \ "compiled/*",
" " "       \ "deps/*",
" " "       \ "dist/*",
" " "       \ "doc/*",
" " "       \ "elm-stuff/*",
" " "       \ "flow-typed/*",
" " "       \ "htmlcov/*",
" " "       \ "node_modules/*",
" " "       \ "serverless/lib/*",
" " "       \ "tests/elm-stuff/*",
" " "       \ "tmp/*"
" " "       \ ]

" " let g:jsx_ext_required = 0

" " " let g:ale_virtualenv_dir_names = ['.direnv']
" " " " let g:ale_cache_executable_check_failures = 1
" " " " let g:ale_open_list = 1
" " " " let g:ale_set_quickfix = 1
" " " let g:ale_history_log_output = 1
" " " let g:ale_linters = {
" " "       \ 'elixir': [],
" " "       \}
" " " let g:ale_fix_on_save = 1
" " " let g:ale_fixers = {
" " "       \ 'elixir': ['mix_format'],
" " "       \ 'elm': ['elm-format'],
" " "       \ 'javascript': ['prettier'],
" " "       \ 'python': ['isort', 'black', 'yapf'],
" " "       \ 'typescript': ['prettier'],
" " "       \}

" " " RagTag
" " let g:ragtag_global_maps = 1

" " " Goyo
" " let g:goyo_width = 120

" FZF
set grepprg=rg\ --vimgrep
command! -bang -nargs=* Rg
      \ call fzf#vim#grep(
      \   'rg --column --line-number --no-heading --color=always '.$RG_IGNORE.' '.shellescape(<q-args>), 1,
      \   <bang>0 ? fzf#vim#with_preview('up:60%')
      \           : fzf#vim#with_preview('right:50%:hidden', '?'),
      \   <bang>0)
      \ 'rg --column --line-number --no-heading --fixed-strings --ignore-case --no-ignore --hidden --follow '.$RG_IGNORE.' --color "always" '.shellescape(<q-args>), 3, <bang>0)

nnoremap <leader>f :Files<cr>
nnoremap <leader>/ :Rg<cr>

" " " let g:tagbar_left = 1
" " " let g:tagbar_autoclose = 1
" " " let g:tagbar_autofocus = 1
" " " let g:tagbar_type_elixir = {
" " "     \ 'ctagstype' : 'elixir',
" " "     \ 'kinds' : [
" " "         \ 'f:functions',
" " "         \ 'functions:functions',
" " "         \ 'c:callbacks',
" " "         \ 'd:delegates',
" " "         \ 'e:exceptions',
" " "         \ 'i:implementations',
" " "         \ 'a:macros',
" " "         \ 'o:operators',
" " "         \ 'm:modules',
" " "         \ 'p:protocols',
" " "         \ 'r:records',
" " "         \ 't:tests'
" " "     \ ]
" " " \ }









""""""""""" START Coc stuff """""""""""""""""""""""
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

" function! s:check_back_space() abort
"   let col = col('.') - 1
"   return !col || getline('.')[col - 1]  =~# '\s'
" endfunction

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
autocmd CursorHold * silent call CocActionAsync('highlight')

" Remap for rename current word
nmap <leader>rn <Plug>(coc-rename)

" augroup mygroup
"   autocmd!
"   " Setup formatexpr specified filetype(s).
"   autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
"   " Update signature help on jump placeholder
"   autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
" augroup end

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
