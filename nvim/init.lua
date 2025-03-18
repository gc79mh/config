require("config.lazy")
require("hardtime").setup()
require("nvim-treesitter.configs").setup({
  ensure_installed = { "python" },
  highlight = { enable = true },
  indent = { enable = true },
})

-- Enable line numbers
vim.opt.number = true

-- Use the system clipboard
vim.opt.clipboard = 'unnamedplus'  

-- Disable the statusline
vim.opt.laststatus = 0

-- Enable syntax highlighting
-- vim.cmd('syntax off')
vim.cmd("colorscheme tokyonight")

-- Transparent
vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
vim.api.nvim_set_hl(0, "NonText", { bg = "none" })
