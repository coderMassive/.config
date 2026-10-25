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
{ "smoka7/hop.nvim", version = "*", opts = {},},
  -- {
  --   'huggingface/llm.nvim',
  --   opts = {
  --     backend = "ollama",
  --     model = "qwen2.5-coder:7b-base",
  --           fim = {
  --   enabled = true,
  --   prefix = "<|fim_prefix|>",
  --   middle = "<|fim_middle|>",
  --   suffix = "<|fim_suffix|>",
  -- },
  -- url = "http://76.167.131.89:11434/", -- llm-ls uses "/api/generate"
  --   }
  -- },
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
{
  'benlubas/molten-nvim',
  dependencies = {
    '3rd/image.nvim', -- For rendering images/plots inline
    'nvim-treesitter/nvim-treesitter', -- Optional, but helpful for cell navigation
  },
  ft = { 'python', 'markdown', 'quarto' }, -- File types where Molten is active
},
{
  '3rd/image.nvim',
  config = function()
    require('image').setup {
      -- your configuration options here, ensure magick is installed
    }
  end
},
{
  "GCBallesteros/NotebookNavigator.nvim",
dependencies = {
    "echasnovski/mini.comment",
    "cathyprime/hydra.nvim",
  },
  event = "VeryLazy",
  config = function()
    local nn = require "notebook-navigator"
    nn.setup({
        activate_hydra_keys = "<leader>h",
        repl_provider = "molten",
    })
      end,
},
{
  "GCBallesteros/jupytext.nvim",
  config = true,
  -- Depending on your nvim distro or config you may need to make the loading not lazy
  -- lazy=false,
},
{
  "echasnovski/mini.hipatterns",
  event = "VeryLazy",
  dependencies = { "GCBallesteros/NotebookNavigator.nvim" },
  opts = function()
    local nn = require "notebook-navigator"

    local opts = { highlighters = { cells = nn.minihipatterns_spec } }
    return opts
  end,
},
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
vim.g.molten_image_provider = "image.nvim" -- Requires the image.nvim plugin
