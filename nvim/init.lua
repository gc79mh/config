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

-- Map <leader>s to save the current file
vim.keymap.set("n", "<leader>w", ":!bash -c 'cat odp | wc -w'<CR>", { noremap = true, silent = true })

-- vim.api.nvim_set_keymap('n', '<leader><CR>', ':w | !python %:p <CR>', { noremap = true, silent = true })

vim.keymap.set('n', '<leader>r', function()
  -- Save the file first
  vim.cmd('write')

  -- Get filetype or extension
  local ft = vim.bo.filetype
  local filename = vim.fn.expand('%:p')

  if ft == 'cpp' then
    -- Example: compile and run the C++ file
    vim.cmd('!g++ ' .. filename .. ' -o /tmp/a.out && /tmp/a.out && clear')
  elseif ft == 'python' then
    -- Run Python script
    vim.cmd('!python3 ' .. filename)
  else
    -- Default fallback
    print('No run command set for filetype: ' .. ft)
  end
end, { desc = "Save and run file based on type" })


-- Enable line numbers
vim.opt.number = true
-- Use the system clipboard
vim.opt.clipboard = 'unnamedplus'  
-- Disable the statusline
vim.opt.laststatus = 0

vim.opt.linebreak = true

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
	{
  		"preservim/nerdtree",
  		config = function()
    		-- Optional: You can set a keybinding to toggle NERDTree
    			vim.keymap.set('n', '<leader>n', ':NERDTreeToggle<CR>', { noremap = true, silent = true })
  		end
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
