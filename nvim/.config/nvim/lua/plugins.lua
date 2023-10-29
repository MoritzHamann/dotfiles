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
	{'hrsh7th/cmp-nvim-lsp-signature-help'},
	{
		"hrsh7th/nvim-cmp",
		requires = {
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-nvim-lsp",
			'hrsh7th/cmp-nvim-lsp-signature-help',
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
