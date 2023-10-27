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
		"catppuccin/nvim",
		name = "catppuccin",
		priority = 1000,
	},
	{
		"folke/tokyonight.nvim",
		lazy = false,
		priority = 1000,
	},
	{
		"nvim-telescope/telescope.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		opts = {
			defaults = {
				file_ignore_patterns = { "node_modules", ".git" },
			},
			pickers = {
				find_files = {
					hidden = true,
				},
				live_grep = {
					additional_args = { "--hidden" },
				},
			}
		}
	},
	{"hrsh7th/cmp-nvim-lsp"},
	{'L3MON4D3/LuaSnip'},
	{'hrsh7th/nvim_lsp_signature_help'},
	{
		"hrsh7th/nvim-cmp",
		requires = {
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-nvim-lsp",
			'hrsh7th/nvim_lsp_signature_help',
			'L3MON4D3/LuaSnip',
		},
		opts = function()
			local cmp = require('cmp')
			return {
				completion = {
					completeopt = "menu,menuone,noinsert",
				},
				snippet = {
					expand = function(args)
						require("luasnip").lsp_expand(args.body)
					end,
				},
				mapping = {
					["<C-p>"] = cmp.mapping.select_prev_item(),
					["<C-n>"] = cmp.mapping.select_next_item(),
					["<C-d>"] = cmp.mapping.scroll_docs(-4),
					["<C-f>"] = cmp.mapping.scroll_docs(4),
					["<C-Space>"] = cmp.mapping.complete(),
					["<C-e>"] = cmp.mapping.close(),
					["<CR>"] = cmp.mapping.confirm({
						behavior = cmp.ConfirmBehavior.Replace,
						select = true,
					}),
				},
				sources = {
					{ name = "nvim_lsp" },
					{ name = "buffer" },
					{ name = "path" },
					{ name = "luasnip"},
					{ name = 'nvim_lsp_signature_help' }
				},
			}
		end,
	},
	-- {"github/copilot.vim"},
	{
		"neovim/nvim-lspconfig",
		config = function()
			require("lspconfig").pyright.setup({})
			require("lspconfig").tsserver.setup({})
			require("lspconfig").gopls.setup({})
		end
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

-- disable copilot on startup
-- TODO

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


-- setup keybindings
local builtin = require("telescope.builtin")
vim.g.mapleader = " "
vim.keymap.set('n', "<leader>ff", builtin.find_files, {})
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})