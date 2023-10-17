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


-- setup plugins
require("lazy").setup({
	{
		"nvim-telescope/telescope.nvim",
		dependencies = { "nvim-lua/plenary.nvim" }
	},
	{
		"github/copilot.vim"
	},
	{
		"nvim-tree/nvim-tree.lua",
		version = "*",
		lazy = false,
		config = function()
			require("nvim-tree").setup({
				renderer = {
					icons = {
						show = {
							file = false,
							folder = false,
							folder_arrow = false,
							git = false,
							modified = false,
							diagnostics = false,
							bookmarks = false
						}
					}
				}
			})
		end,
	}
})

-- setup editor
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.hlsearch = false
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4


-- setup keybindings
vim.g.mapleader = " "
vim.api.nvim_set_keymap("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { noremap = true })