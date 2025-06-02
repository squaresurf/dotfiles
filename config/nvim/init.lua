-- Set leader keys first
vim.g.mapleader = ' '
vim.g.maplocalleader = ' l'

-- Disable Python providers for performance
vim.g.loaded_python_provider = 1
vim.g.loaded_python3_provider = 1

-- Plugin management with vim-plug (keeping existing setup)
vim.cmd([[
call plug#begin('~/.local/share/nvim/plugged')

Plug 'benmills/vimux'
Plug 'christoomey/vim-tmux-navigator'
Plug 'editorconfig/editorconfig-vim'
Plug 'jose-elias-alvarez/null-ls.nvim'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'lervag/vimtex'
Plug 'neovim/nvim-lspconfig'
Plug 'nvim-lua/plenary.nvim'
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

call plug#end()
]])

-- Basic settings
vim.opt.encoding = 'utf8'
vim.cmd('syntax on')
vim.cmd('colorscheme nord')
vim.opt.background = 'dark'

-- Editor settings
vim.opt.conceallevel = 2  -- conceal markdown links
vim.opt.backspace = { 'indent', 'eol', 'start' }
vim.opt.cursorline = true
vim.opt.expandtab = true
vim.opt.foldlevel = 20
vim.opt.foldmethod = 'indent'
vim.opt.hidden = true
vim.opt.list = true
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.showcmd = true
vim.opt.smartcase = true
vim.opt.smartindent = true
vim.opt.smarttab = true
vim.opt.termguicolors = true
vim.opt.wildmenu = true
vim.opt.wildmode = { 'longest', 'list', 'full' }

-- FZF setup
vim.opt.runtimepath:append('/usr/local/opt/fzf')
vim.opt.grepprg = 'rg --vimgrep'

-- Custom FZF Rg command
vim.cmd([[
command! -bang -nargs=* Rg
      \ call fzf#vim#grep(
      \   'rg --column --line-number --no-heading --color=always '.$RG_IGNORE.' '.shellescape(<q-args>), 1,
      \   <bang>0 ? fzf#vim#with_preview('up:60%')
      \           : fzf#vim#with_preview('right:50%:hidden', '?'),
      \   <bang>0)
]])

-- VimTeX settings
vim.g.tex_flavor = 'latex'

-- Key mappings
local opts = { noremap = true, silent = true }

-- General keymaps
vim.keymap.set('n', '<leader>u', ':e ++ff=unix<cr>', opts)
vim.keymap.set('n', '<leader>s', ':source ~/.config/nvim/init.lua<cr>', opts)
vim.keymap.set('n', '<leader>S', ':vs ~/.config/nvim/init.lua<cr>', opts)
vim.keymap.set('n', '<leader>n', ':noh<cr>', opts)
vim.keymap.set('n', '<leader>l', 'f(l', opts)

-- FZF keymaps
vim.keymap.set('n', '<leader>b', ':Buffers<cr>', opts)
vim.keymap.set('n', '<leader>f', ':Files<cr>', opts)
vim.keymap.set('n', '<leader>/', ':Rg<cr>', opts)
vim.keymap.set('n', '<localleader>/', ':Rg', { noremap = true })

-- System clipboard keymaps
vim.keymap.set('v', '<leader>y', '"+y', opts)
vim.keymap.set('v', '<leader>d', '"+d', opts)
vim.keymap.set('n', '<leader>p', '"+p', opts)
vim.keymap.set('n', '<leader>P', '"+P', opts)
vim.keymap.set('v', '<leader>p', '"+p', opts)
vim.keymap.set('v', '<leader>P', '"+P', opts)

-- Abbreviations
vim.cmd([[iabbrev <expr> ;d strftime("%Y-%m-%d")]])

-- Autocommands
local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

-- Filetype detection
augroup('filetypes', { clear = true })
autocmd({ 'BufNewFile', 'BufRead' }, {
  group = 'filetypes',
  pattern = '*.m',
  callback = function() vim.bo.filetype = 'octave' end,
})
autocmd({ 'BufNewFile', 'BufRead' }, {
  group = 'filetypes',
  pattern = '*.mmd',
  callback = function() vim.bo.filetype = 'mermaid' end,
})
autocmd({ 'BufNewFile', 'BufRead' }, {
  group = 'filetypes',
  pattern = '*.nomad',
  callback = function() vim.bo.filetype = 'hcl' end,
})
autocmd({ 'BufNewFile', 'BufRead' }, {
  group = 'filetypes',
  pattern = '*.sarif',
  callback = function() vim.bo.filetype = 'json' end,
})
autocmd({ 'BufNewFile', 'BufRead' }, {
  group = 'filetypes',
  pattern = '.envrc',
  callback = function() vim.bo.filetype = 'sh' end,
})
autocmd({ 'BufNewFile', 'BufRead' }, {
  group = 'filetypes',
  pattern = '.eslintrc',
  callback = function() vim.bo.filetype = 'json' end,
})
autocmd({ 'BufNewFile', 'BufRead' }, {
  group = 'filetypes',
  pattern = { 'Capfile', 'Gemfile', 'Berksfile', 'Vagrantfile', 'Guardfile' },
  callback = function() vim.bo.filetype = 'ruby' end,
})
autocmd({ 'BufNewFile', 'BufRead' }, {
  group = 'filetypes',
  pattern = 'Dockerfile.*',
  callback = function() vim.bo.filetype = 'dockerfile' end,
})

-- Commentary settings
augroup('commentary', { clear = true })
autocmd('FileType', {
  group = 'commentary',
  pattern = 'octave',
  callback = function() vim.bo.commentstring = '% %s' end,
})
autocmd('FileType', {
  group = 'commentary',
  pattern = 'mermaid',
  callback = function() vim.bo.commentstring = '%% %s' end,
})
autocmd('FileType', {
  group = 'commentary',
  pattern = 'sql',
  callback = function() vim.bo.commentstring = '-- %s' end,
})

-- File-specific runners
augroup('runners', { clear = true })
autocmd('FileType', {
  group = 'runners',
  pattern = 'markdown',
  callback = function()
    vim.keymap.set('n', '<localleader>r',
      ':!pandoc % -s -o /tmp/$(basename %).pdf && open -a skim /tmp/$(basename %).pdf<cr>',
      { buffer = true, noremap = true })
    vim.keymap.set('n', '<localleader>R',
      ':!pandoc % -s -o /tmp/$(basename %).html && open /tmp/$(basename %).html<cr>',
      { buffer = true, noremap = true })
  end,
})
autocmd('FileType', {
  group = 'runners',
  pattern = 'rust',
  callback = function()
    vim.keymap.set('n', '<localleader>r', ':!cargo run<cr>', { buffer = true, noremap = true })
    vim.keymap.set('n', '<localleader>R', ':!cargo test<cr>', { buffer = true, noremap = true })
  end,
})
autocmd('FileType', {
  group = 'runners',
  pattern = 'go',
  callback = function()
    vim.keymap.set('n', '<localleader>r', ':!go run %<cr>', { buffer = true, noremap = true })
  end,
})

-- LSP Configuration
-- Diagnostic keymaps
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, opts)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, opts)

-- LSP on_attach function
local on_attach = function(client, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Buffer-specific LSP keymaps
  local bufopts = { noremap = true, silent = true, buffer = bufnr }
  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
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

-- Setup Mason and LSP servers
require('mason').setup()
require('mason-lspconfig').setup()

-- LSP server configurations
require('lspconfig').elixirls.setup{ on_attach = on_attach }
require('lspconfig').pyright.setup{ on_attach = on_attach }
require('lspconfig').ruff.setup{
  on_attach = on_attach,
  init_options = {
    settings = {
      organizeImports = true
    }
  }
}
require('lspconfig').gopls.setup{ on_attach = on_attach }
require('lspconfig').rust_analyzer.setup{ on_attach = on_attach }

-- null-ls setup for formatting
local null_ls = require('null-ls')

null_ls.setup({
  sources = {
    null_ls.builtins.formatting.goimports,
    null_ls.builtins.formatting.prettier,
    null_ls.builtins.formatting.rustfmt,
  },
})

-- Format on save
autocmd('BufWritePre', {
  callback = function()
    vim.lsp.buf.format()
  end,
})

-- MCP Copy functionality (migrated from previous init.lua)
function copy_mcp_path()
  local filepath = vim.fn.expand('%:p')
  local real_filepath = vim.fn.resolve(filepath)
  vim.fn.setreg('+', real_filepath)
end

vim.api.nvim_create_user_command('CopyMCPPath', copy_mcp_path, {
  desc = 'Copy current file path in format for Claude MCP filesystem server'
})

vim.keymap.set('n', '<leader>cp', copy_mcp_path, { desc = 'Copy MCP path' })
