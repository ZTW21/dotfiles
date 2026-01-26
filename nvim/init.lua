-- -----------------------------------------------------------------------------
-- BOOTSTRAP LAZY.NVIM
-- -----------------------------------------------------------------------------
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({ "git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git", "--branch=stable", lazypath })
end
vim.opt.rtp:prepend(lazypath)

-- -----------------------------------------------------------------------------
-- GENERAL SETTINGS
-- -----------------------------------------------------------------------------
vim.g.mapleader = " "
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.termguicolors = true
vim.opt.cursorline = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

-- -----------------------------------------------------------------------------
-- PLUGINS
-- -----------------------------------------------------------------------------
require("lazy").setup({
  -- 1. Theme (Matches your p3rception itermcolors)
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      require("tokyonight").setup({ style = "night", transparent = true })
      vim.cmd([[colorscheme tokyonight-night]])
    end,
  },

  -- FILE EXPLORER: The Sidebar
  {
    "nvim-tree/nvim-tree.lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function() require("nvim-tree").setup() end,
  },

  {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function() require("telescope").setup() end,
  },

  {
    "akinsho/bufferline.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function() require("bufferline").setup() end,
  },

  -- 2. Treesitter (The specific fix for your error)
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    build = ":TSUpdate",
    opts = {
      ensure_installed = { "swift", "python", "lua", "vim", "bash", "json", "yaml" },
      auto_install = true,
      highlight = { enable = true },
      indent = { enable = true },
    },
    config = function(_, opts)
      require("nvim-treesitter.config").setup(opts)
    end,
  },

  -- 3. Utility
  { "NvChad/nvim-colorizer.lua", config = function() require("colorizer").setup() end },
})

-- -----------------------------------------------------------------------------
-- KEYBINDINGS
-- -----------------------------------------------------------------------------
local keymap = vim.keymap.set

-- Sidebar: Toggle the file tree
keymap('n', '<leader>e', ':NvimTreeToggle<CR>') 

-- Finding Files: Cmd+P equivalent
keymap('n', '<leader>ff', ':Telescope find_files<CR>') 

-- Global Search: Search for text inside files
keymap('n', '<leader>fg', ':Telescope live_grep<CR>') 

-- Tab Navigation: Use Shift+H (Left) and Shift+L (Right)
keymap('n', '<S-l>', ':BufferLineCycleNext<CR>')
keymap('n', '<S-h>', ':BufferLineCyclePrev<CR>')

-- Closing: Save with Space+w, Close tab with Space+x
keymap('n', '<leader>w', ':w<CR>')
keymap('n', '<leader>x', ':bdelete<CR>')
