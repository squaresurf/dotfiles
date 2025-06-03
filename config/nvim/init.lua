-- Set leader keys first
vim.g.mapleader = ' '
vim.g.maplocalleader = ' l'

-- Disable Python providers for performance
vim.g.loaded_python_provider = 1
vim.g.loaded_python3_provider = 1

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- Setup lazy.nvim with plugins
require("lazy").setup({
  -- Core utilities
  {
    "nvim-lua/plenary.nvim",
    lazy = true,
  },

  -- Colorscheme
  {
    "shaunsingh/nord.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      vim.cmd.colorscheme('nord')
    end,
  },

  -- Tmux integration
  "benmills/vimux",
  "christoomey/vim-tmux-navigator",

  -- Editor configuration
  "editorconfig/editorconfig-vim",

  -- FZF fuzzy finder
  {
    "junegunn/fzf",
    build = function()
      vim.fn["fzf#install"]()
    end,
  },
  "junegunn/fzf.vim",

  -- LaTeX support
  "lervag/vimtex",

  -- LSP and Mason
  {
    "williamboman/mason.nvim",
    config = function()
      require('mason').setup()
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = { "williamboman/mason.nvim" },
    config = function()
      require('mason-lspconfig').setup()
    end,
  },
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
    },
  },

  -- Null-ls for formatting/linting
  "jose-elias-alvarez/null-ls.nvim",

  -- Language support
  "sheerun/vim-polyglot",
  "terrastruct/d2-vim",

  -- Git integration
  "tpope/vim-fugitive",
  "tpope/vim-git",
  "tpope/vim-rhubarb",
  "shumphrey/fugitive-gitlab.vim",

  -- Text manipulation
  "tpope/vim-commentary",
  "tpope/vim-endwise",
  "tpope/vim-ragtag",
  "tpope/vim-repeat",
  "tpope/vim-rsi",
  "tpope/vim-surround",
  "tpope/vim-unimpaired",
  "tpope/vim-vinegar",

  -- Local plugin
  {
    dir = "~/code/vision.vim",
    name = "vision.vim",
  },
})

-- Basic settings
vim.opt.encoding = 'utf8'
vim.cmd.syntax('on')
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
vim.api.nvim_create_user_command('Rg', function(opts)
  local args = opts.args
  local bang = opts.bang
  vim.fn['fzf#vim#grep'](
    'rg --column --line-number --no-heading --color=always '..(vim.env.RG_IGNORE or '')..' '..vim.fn.shellescape(args),
    1,
    bang and vim.fn['fzf#vim#with_preview']('up:60%') or vim.fn['fzf#vim#with_preview']('right:50%:hidden', '?'),
    bang
  )
end, { bang = true, nargs = '*' })

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
vim.keymap.set('ia', ';d', function()
  return vim.fn.strftime('%Y-%m-%d')
end, { expr = true })

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
