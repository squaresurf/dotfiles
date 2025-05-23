-- Minimal init.lua for gradual migration from init.vim
-- This file sources the existing init.vim while we incrementally migrate to Lua

-- Set leader keys first (needed for keymaps defined in this file)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' l'

-- Source the existing vimscript configuration
vim.cmd('source ~/.config/nvim/init.vim')

-- TODO: Migrate sections one by one:
-- [ ] Basic settings (vim options)
-- [ ] Key mappings
-- [ ] Plugin manager setup
-- [ ] Plugin configurations
-- [ ] Autocommands
-- [ ] Custom functions

-- As you migrate each section, comment out the corresponding parts in init.vim
-- and add the Lua equivalents below or in separate files under lua/

-- MIGRATED: MCP Copy functionality
-- Function to convert local file path to MCP server path
print("About to define copy_mcp_path function")
function copy_mcp_path()
  local filepath = vim.fn.expand('%:p')

  -- Resolve symlinks to get the real path
  local real_filepath = vim.fn.resolve(filepath)
  vim.fn.setreg('+', real_filepath)
  -- local mcp_path = nil

  -- -- Convert based on your mount points (check both original and resolved paths)
  -- if string.match(filepath, '^/Users/daniel/%.dotfiles/') then
  --   mcp_path = string.gsub(filepath, '^/Users/daniel/%.dotfiles/', '/dotfiles/')
  -- elseif string.match(real_filepath, '^/Users/daniel/%.dotfiles/') then
  --   mcp_path = string.gsub(real_filepath, '^/Users/daniel/%.dotfiles/', '/dotfiles/')
  -- elseif string.match(filepath, '^/Users/daniel/code/') then
  --   mcp_path = string.gsub(filepath, '^/Users/daniel/code/', '/code/')
  -- elseif string.match(real_filepath, '^/Users/daniel/code/') then
  --   mcp_path = string.gsub(real_filepath, '^/Users/daniel/code/', '/code/')
  -- else
  --   vim.notify("File is not in a mounted directory accessible to Claude MCP server\nOriginal: " .. filepath .. "\nResolved: " .. real_filepath, vim.log.levels.WARN)
  --   return
  -- end

  -- -- Copy to system clipboard
  -- vim.fn.setreg('+', mcp_path)
  -- vim.notify("Copied MCP path: " .. mcp_path, vim.log.levels.INFO)
end

-- Create user command
vim.api.nvim_create_user_command('CopyMCPPath', copy_mcp_path, {
  desc = 'Copy current file path in format for Claude MCP filesystem server'
})

vim.keymap.set('n', '<leader>cp', copy_mcp_path, { desc = 'Copy MCP path' })
