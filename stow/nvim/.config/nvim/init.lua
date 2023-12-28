-- disable default netrw file explorer
-- vim.g.loaded_netrwPlugin = 1
-- vim.g.loaded_netrw = 1

-- ensure lazypath is available
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable",
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

require('plugins')
require('local_lsp')
require('mappings')
require('settings')


-- local tickets = require("ticket-manager")
-- tickets.getTickets("asdf")
-- print(vim.inspect(tickets))




