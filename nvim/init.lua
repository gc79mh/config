-- Enable line numbers
vim.opt.number = true

-- Disable the statusline
vim.opt.laststatus = 0

-- Enable syntax highlighting
vim.cmd('syntax on')

-- Transparent
vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
vim.api.nvim_set_hl(0, "NonText", { bg = "none" })

