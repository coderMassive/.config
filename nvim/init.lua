vim.g.mapleader = ' '
vim.wo.number = true
vim.wo.relativenumber = true
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)
require("lazy").setup({
{
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function () 
      local configs = require("nvim-treesitter.configs")
      configs.setup({
          ensure_installed = {"python", "java", "lua"},
          sync_install = false,
          highlight = { enable = true },
          indent = { enable = true },  
        })
    end
},
{ "ellisonleao/gruvbox.nvim", priority = 1000 , config = true, opts = ...},
{ "smoka7/hop.nvim", version = "*", opts = {},},
{
  'Exafunction/codeium.vim',
  event = 'BufEnter',
    config = function ()
    vim.keymap.set('i', '<c-l>', function() return vim.fn['codeium#CycleCompletions'](1) end, { expr = true, silent = true })
    vim.keymap.set('i', '<c-h>', function() return vim.fn['codeium#CycleCompletions'](-1) end, { expr = true, silent = true })
    vim.keymap.set('n', '<c-j>', function() return vim.fn['codeium#Chat']() end, { expr = true, silent = true })
  end
},
{
	'nvim-telescope/telescope.nvim', tag = '0.1.5',
	dependencies = { 'nvim-lua/plenary.nvim' }
},
{'akinsho/toggleterm.nvim', version = "*", opts = {
  size = 20,
  open_mapping = [[<c-t>]],
  hide_numbers = true,
  shade_filetypes = {},
  shade_terminals = true,
  shading_factor = 2,
  start_in_insert = true,
  insert_mappings = true,
  persist_size = true,
  direction = "float",
  close_on_exit = true,
  shell = vim.o.shell,
  float_opts = {
    border = "curved",
    winblend = 0,
    highlights = {
      border = "Normal",
      background = "Normal",
    },
  }
}}
})
require("gruvbox").setup({
    transparent_mode = true,
})
local hop = require('hop')
local directions = require('hop.hint').HintDirection
vim.keymap.set('n', 'f', function()
  hop.hint_words({ direction = directions.AFTER_CURSOR, current_line_only = false })
end, {remap=true})
vim.keymap.set('n', 'F', function()
  hop.hint_words({ direction = directions.BEFORE_CURSOR, current_line_only = false })
end, {remap=true})
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<Space>', builtin.find_files, {})
vim.keymap.set('t', '<Escape>', "<C-\\><C-n><C-w>h",{silent = true})
local hop = require('hop')
vim.cmd.colorscheme "gruvbox"
vim.o.tabstop = 4 -- A TAB character looks like 4 spaces
vim.o.expandtab = true -- Pressing the TAB key will insert spaces instead of a TAB character
vim.o.softtabstop = 4 -- Number of spaces inserted instead of a TAB character
vim.o.shiftwidth = 4 -- Number of spaces inserted when indenting`
