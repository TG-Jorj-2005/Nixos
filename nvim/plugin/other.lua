-- Lualine
require("lualine").setup({
    icons_enabled = true,
    theme = 'onedark',
})

-- Colorscheme
vim.cmd("colorscheme catppuccin")

-- Comment
require("Comment").setup()
