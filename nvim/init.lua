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
{ "smoka7/hop.nvim", version = "*", opts = {},},
{
  'Exafunction/windsurf.vim',
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
}},
{ "catppuccin/nvim", name = "catppuccin", priority = 1000 },
{ "karb94/neoscroll.nvim", opts = {} },
{ 'mhinz/vim-startify' },
{ 'tpope/vim-commentary' },
{
  'stevearc/oil.nvim',
  ---@module 'oil'
  ---@type oil.SetupOpts
  opts = {},
  -- Optional dependencies
  dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if you prefer nvim-web-devicons
  -- Lazy loading is not recommended because it is very tricky to make it work correctly in all situations.
  lazy = false,
},
{ 'Vigemus/iron.nvim' },
{
  "GCBallesteros/NotebookNavigator.nvim",
  keys = {
    { "]h", function() require("notebook-navigator").move_cell "d" end },
    { "[h", function() require("notebook-navigator").move_cell "u" end },
    { "<leader>X", "<cmd>lua require('notebook-navigator').run_cell()<cr>" },
    { "<leader>x", "<cmd>lua require('notebook-navigator').run_and_move()<cr>" },
  },
  dependencies = {
    "echasnovski/mini.comment",
    "anuvyklack/hydra.nvim",
  },
  event = "VeryLazy",
  config = function()
    local nn = require "notebook-navigator"
    nn.setup({ activate_hydra_keys = "<leader>h" })
  end,
}
})
require("catppuccin").setup({
    flavour = "mocha",
    transparent_background = true
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
vim.keymap.set('n', '<Space>f', builtin.find_files, {})
vim.keymap.set('n', '<Space>g', builtin.live_grep, {})
vim.keymap.set('n', '<Space>b', builtin.buffers, {})
vim.keymap.set('n', '<Space>h', builtin.help_tags, {})
vim.keymap.set('t', '<Escape>', "<C-\\><C-n><C-w>h",{silent = true})
local hop = require('hop')
vim.cmd.colorscheme "catppuccin"
vim.o.tabstop = 4 -- A TAB character looks like 4 spaces
vim.o.expandtab = true -- Pressing the TAB key will insert spaces instead of a TAB character
vim.o.softtabstop = 4 -- Number of spaces inserted instead of a TAB character
vim.o.shiftwidth = 4 -- Number of spaces inserted when indenting`

local iron = require("iron.core")
local view = require("iron.view")

iron.setup {
  config = {
    repl_open_cmd = view.split.vertical.rightbelow("%40"),
  }
}
