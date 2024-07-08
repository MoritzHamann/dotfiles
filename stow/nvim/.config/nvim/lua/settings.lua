vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.hlsearch = false
vim.opt.incsearch = true
vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.smarttab = true
vim.opt.expandtab = true

vim.opt.cursorline = true
vim.opt.signcolumn = "yes"

vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
vim.opt.foldtext = "nvim_treesitter#foldtext()"
vim.opt.foldenable = false

-- colorscheme
vim.cmd.colorscheme "catppuccin-mocha"

-- plugin specific

-- omnisharp
vim.g.OmniSharp_server_use_net6 = 1

