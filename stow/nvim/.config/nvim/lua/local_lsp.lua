
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

-- vala
lsp_config['vala_ls'].setup({
    capabilities = capabilities
})

-- dart
lsp_config['dartls'].setup({
    capabilities = capabilities
})

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
    filetypes = { "swift", "c", "cpp", "objective-c", "objective-cpp"},
})

lsp_config['ocamllsp'].setup({
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

lsp_config['omnisharp'].setup({
    cmd = { "dotnet", "/Users/moe/Projects/omnisharp/OmniSharp.dll" },

    settings = {
      FormattingOptions = {
        -- Enables support for reading code style, naming convention and analyzer
        -- settings from .editorconfig.
        EnableEditorConfigSupport = true,
        -- Specifies whether 'using' directives should be grouped and sorted during
        -- document formatting.
        OrganizeImports = true,
      },
      MsBuild = {
        -- If true, MSBuild project system will only load projects for files that
        -- were opened in the editor. This setting is useful for big C# codebases
        -- and allows for faster initialization of code navigation features only
        -- for projects that are relevant to code that is being edited. With this
        -- setting enabled OmniSharp may load fewer projects and may thus display
        -- incomplete reference lists for symbols.
        LoadProjectsOnDemand = false,
      },
      RoslynExtensionsOptions = {
        -- Enables support for roslyn analyzers, code fixes and rulesets.
        EnableAnalyzersSupport = true,
        -- Enables support for showing unimported types and unimported extension
        -- methods in completion lists. When committed, the appropriate using
        -- directive will be added at the top of the current file. This option can
        -- have a negative impact on initial completion responsiveness,
        -- particularly for the first few completion sessions after opening a
        -- solution.
        EnableImportCompletion = true,
        -- Only run analyzers against open files when 'enableRoslynAnalyzers' is
        -- true
        AnalyzeOpenDocumentsOnly = false,
      },
      Sdk = {
        -- Specifies whether to include preview versions of the .NET SDK when
        -- determining which version to use for project loading.
        IncludePrereleases = true,
      },
    },
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
