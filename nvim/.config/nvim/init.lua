-- disable default netrw file explorer
vim.g.loaded_netrwPlugin = 1
vim.g.loaded_netrw = 1

-- ensure lazypath is available
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable",
		releaselazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

require('plugins')
require('mappings')



-- setup completion
local cmp = require('cmp')
local capabilities = require('cmp_nvim_lsp').default_capabilities()
require('lspconfig')['pyright'].setup {
	capabilities = capabilities
}
require('lspconfig')['gopls'].setup {
	capabilities = capabilities
}



-- setup editor
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.hlsearch = false
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.cmd.colorscheme "catppuccin-macchiato"

-- setup spaces instead of tabs for python
vim.g.python_recommended_style = 1


