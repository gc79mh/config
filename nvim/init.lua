-----------------------------------------------------------

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

-----------------------------------------------------------

vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Enable line numbers
vim.opt.number = true
-- Use the system clipboard
vim.opt.clipboard = 'unnamedplus'  
-- Disable the statusline
vim.opt.laststatus = 0

-- Setup lazy.nvim
require("lazy").setup({
  spec = {
	{
		"nvim-treesitter/nvim-treesitter", 
		build = ":TSUpdate"
	},
	{
		"folke/tokyonight.nvim",
		lazy = false,
		priority = 1000,
		opts = {}
	},
  },
})

require("nvim-treesitter.configs").setup({
	ensure_installed = { "python" , "cpp" , "bash" },
	highlight = { enable = true },
	indent = { enable = true },
})

-- Color
vim.cmd("colorscheme tokyonight")
-- Transparent
vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
vim.api.nvim_set_hl(0, "NonText", { bg = "none" })
