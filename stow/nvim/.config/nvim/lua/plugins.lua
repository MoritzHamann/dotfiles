require("lazy").setup({
    { "nvim-lua/plenary.nvim" },
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
				file_ignore_patterns = { ".git", "venv", "node_modules" },
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
	{
		'nvim-treesitter/nvim-treesitter',
		build = ":TSUpdate",
		config = function()
			local configs = require("nvim-treesitter.configs")
			configs.setup({
				ensure_installed = { "cpp", "lua", "typescript", "python", "rust" },
				sync_install = false,
				highlight = { enable = true, additional_vim_regex_highlighting = false},
				indent = { enable = true },
			})
		end
	},
	{
		"hrsh7th/nvim-cmp",
		dependencies = {
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-nvim-lua",
			"L3MON4D3/LuaSnip",
		},
		opts = function()
			local cmp = require('cmp')
			local luasnip = require('luasnip')
			return {
				completion = {
					completeopt = "menu,menuone,noinsert",
				},
				snippet = {
					expand = function(args)
						luasnip.lsp_expand(args.body)
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
				sources = cmp.config.sources({
					{ name = "nvim_lsp" },
				},{
					{ name = "nvim_lua"},
					{ name = 'luasnip' }
				}, {
					{ name = 'buffer'},
					{ name = 'path'}
				})
			}
		end,
	},
	-- {"github/copilot.vim"},
	{
		"neovim/nvim-lspconfig",
	},
	{
		"nvim-tree/nvim-tree.lua",
		version = "*",
		lazy = true,
		enabled = true,
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
	},
    {
        "numToStr/Comment.nvim",
        lazy = false,
        opts = {}
    },
    {
        'folke/neodev.nvim',
        opts = {}
    },
    {
        'tpope/vim-fugitive'
    }
})


