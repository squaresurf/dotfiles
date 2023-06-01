call plug#begin('~/.local/share/nvim/plugged')

Plug 'benmills/vimux'
Plug 'christoomey/vim-tmux-navigator'
Plug 'editorconfig/editorconfig-vim'
Plug 'jose-elias-alvarez/null-ls.nvim'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'lervag/vimtex'
Plug 'neovim/nvim-lspconfig'
Plug 'nvim-lua/plenary.nvim' " required by null-ls.nvim and used below
Plug 'shaunsingh/nord.nvim'
Plug 'sheerun/vim-polyglot'
Plug 'shumphrey/fugitive-gitlab.vim'
Plug 'terrastruct/d2-vim'
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
Plug 'tpope/vim-vinegar'
Plug 'williamboman/mason-lspconfig.nvim'
Plug 'williamboman/mason.nvim'
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

" Tell NeoVim to not try to load python
let g:loaded_python_provider = 1
let g:loaded_python3_provider = 1

let g:mapleader = "\<space>"
let g:maplocalleader = "\<space>l"

" force unix lineendings
nnoremap <leader>u :e ++ff=unix<cr>

nnoremap <leader>s :source ~/.config/nvim/init.vim<cr>
nnoremap <leader>S :vs ~/.config/nvim/init.vim<cr>
nnoremap <leader>n :noh<cr>
nnoremap <leader>l f(l

nnoremap <leader>b :Buffers<cr>
nnoremap <leader>f :Files<cr>
nnoremap <leader>/ :Rg<cr>
nnoremap <localleader>/ :Rg

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

let g:tex_flavor = 'latex'

" Runners
augroup runners
  autocmd!
  autocmd FileType markdown nnoremap <buffer> <localleader>r :!pandoc % -s -o /tmp/$(basename %).pdf && open -a skim /tmp/$(basename %).pdf<cr>
  autocmd FileType markdown nnoremap <buffer> <localleader>R :!pandoc % -s -o /tmp/$(basename %).html && open /tmp/$(basename %).html<cr>
  autocmd FileType rust nnoremap <buffer> <localleader>r :!cargo run<cr>
  autocmd FileType rust nnoremap <buffer> <localleader>R :!cargo test<cr>
  autocmd FileType go nnoremap <buffer> <localleader>r :!go run %<cr>
augroup END

" Mason | lsp | dap | linters | formatters
lua <<EOF
  -------------------------------------------------------------------
  -- https://github.com/neovim/nvim-lspconfig#suggested-configuration
  -- Mappings.
  -- See `:help vim.diagnostic.*` for documentation on any of the below functions
  local opts = { noremap=true, silent=true }
  vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, opts)
  vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
  vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
  vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, opts)

  -- Use an on_attach function to only map the following keys
  -- after the language server attaches to the current buffer
  local on_attach = function(client, bufnr)
    -- Enable completion triggered by <c-x><c-o>
    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

    -- Mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    local bufopts = { noremap=true, silent=true, buffer=bufnr }
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
    -- vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts) -- conflicts with my movement cmd
    vim.keymap.set('n', '<localleader>wa', vim.lsp.buf.add_workspace_folder, bufopts)
    vim.keymap.set('n', '<localleader>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
    vim.keymap.set('n', '<localleader>wl', function()
      print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, bufopts)
    vim.keymap.set('n', '<localleader>D', vim.lsp.buf.type_definition, bufopts)
    vim.keymap.set('n', '<localleader>rn', vim.lsp.buf.rename, bufopts)
    vim.keymap.set('n', '<localleader>ca', vim.lsp.buf.code_action, bufopts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
    vim.keymap.set('n', '<localleader>f', function() vim.lsp.buf.format { async = true } end, bufopts)
  end

  -- END Suggested Config
  -----------------------

  require('mason').setup()
  require('mason-lspconfig').setup()

  -- All setup calls must set on_attach
  require('lspconfig').ember.setup{ on_attach = on_attach }
  require('lspconfig').eslint.setup{ on_attach = on_attach }
  require('lspconfig').gopls.setup{ on_attach = on_attach }
  require('lspconfig').rust_analyzer.setup{ on_attach = on_attach }

  local null_ls = require('null-ls')
  local path = require('plenary.path')

  null_ls.setup({
      sources = {
          null_ls.builtins.diagnostics.golangci_lint.with({
            extra_args = function(params)
              local makefiles_config = '.modules/cloud-makefiles/golangci/config.yml'
              if path.new(makefiles_config):exists() then
                return { '--config', makefiles_config }
              else
                return {}
              end
            end
          }),
          null_ls.builtins.formatting.goimports,
          null_ls.builtins.formatting.prettier,
          null_ls.builtins.formatting.rustfmt,
      },
  })

  vim.cmd [[autocmd BufWritePre * lua vim.lsp.buf.format()]] -- format on save
EOF
