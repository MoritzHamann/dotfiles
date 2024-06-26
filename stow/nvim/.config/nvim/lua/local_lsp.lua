
-- make sure we have the Neovim docs available for development
require("neodev").setup({})
local capabilities = require('cmp_nvim_lsp').default_capabilities()
local lsp_config = require('lspconfig')
local util = require('lspconfig.util')

-- Python config
lsp_config['pyright'].setup{
    capabilities = capabilities,
    settings = {}
}

-- Go config
lsp_config['gopls'].setup{
    capabilities = capabilities,
    settings = {
        gopls = {
            usePlaceholders = true
        },
    }
}

-- Rust config
lsp_config['rust_analyzer'].setup{
    capabilities = capabilities
}

-- TS config
lsp_config['tsserver'].setup({
    capabilities = capabilities
})

-- gleam
lsp_config['gleam'].setup({
    capabilities = capabilities
})

lsp_config['sourcekit'].setup({
    capabilities = capabilities
})

lsp_config["ionide"].setup({
    -- capabilities = capabilities,
    cmd = { 'fsautocomplete', '--adaptive-lsp-server-enabled' },
    root_dir = util.root_pattern('*.sln', '*.fsproj', '.git'),
    filetypes = { 'fsharp' },
    init_options = {
      AutomaticWorkspaceInit = true,
    },
})

lsp_config['jdtls'].setup({
    cmd = {
        "/Users/moe/Projects/jdt-language-server-latest/bin/jdtls",
        "-configuration",
        "/Users/moe/.cache/jdtls/config",
        "-data",
        "/Users/moe/.cache/jdtls/workspace"
    }
})

lsp_config['zls'].setup({
    capabilities = capabilities
})

-- lua config 
lsp_config['lua_ls'].setup({
    capabilities = capabilities,
    settings = {
        Lua = {
            runtime = {
                -- Tell the language server which version of Lua you're using
                -- (most likely LuaJIT in the case of Neovim)
                version = 'LuaJIT'
            },
            -- Make the server aware of Neovim runtime files
            workspace = {
                checkThirdParty = false,
                library = {
                    vim.env.VIMRUNTIME
                    -- "${3rd}/luv/library"
                    -- "${3rd}/busted/library",
                }
                -- or pull in all of 'runtimepath'. NOTE: this is a lot slower
                -- library = vim.api.nvim_get_runtime_file("", true)
            },
            completion = {
                showWord = "Disable",
                callSnippet = "Replace"
            }
        }

    }
})
