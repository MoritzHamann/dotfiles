-- setup keybindings
local builtin = require("telescope.builtin")
local utils = require("telescope.utils")
local api = require("nvim-tree.api")
local commentApi = require("Comment.api")

vim.g.mapleader = " "


local function getGitDir(path)
    local git_dir = vim.fs.find({ '.git' }, { path = path, upward = true })
    if git_dir then
        return vim.fs.dirname(git_dir[1])
    else
        return nil
    end
end

-- symbol search
vim.keymap.set('n', '<leader>fs', builtin.lsp_document_symbols)
vim.keymap.set('n', '<leader>ws', builtin.lsp_dynamic_workspace_symbols)

-- fuzzy file finder
vim.keymap.set('n', "<leader>ff", function()
    local search_dir = getGitDir(utils.buffer_dir()) or utils.buffer_dir()
    builtin.find_files({ cwd = search_dir })
end, {})

vim.keymap.set('n', '<C-p>', function()
    local search_dir = getGitDir(utils.buffer_dir()) or utils.buffer_dir()
    builtin.git_files({ cwd = search_dir })
end, {})

-- string search
vim.keymap.set('n', '<leader>fg', function()
    local search_dir = getGitDir(utils.buffer_dir()) or utils.buffer_dir()
    builtin.grep_string({ cwd = search_dir })
end, {})

vim.keymap.set('n', '<leader>gg', function()
    builtin.live_grep()
end, {})


vim.keymap.set('n', '<leader>fb', function()
    builtin.buffers({ show_all_buffers = true })
end, {})
vim.keymap.set('n', '<C-b>', api.tree.toggle, {})

-- VS Code like comments
vim.keymap.set('n', '<C-/>', commentApi.toggle.linewise.current)
vim.keymap.set('v', '<C-/>', commentApi.call('toggle.linewise', 'g@'), { expr = true })

-- Project fuzzy find

-- function changeCWD()
-- 	vim.ui.input({prompt="Change to Project: ", completion="dir"}, function(directory)
-- 		if directory then
-- 			vim.api.nvim_set_current_dir(directory)
-- 		end
-- 	end)
-- end
vim.keymap.set('n', '<leader>fp', function()
    require('telescope').extensions.project.project({})
end, {})

-- set up lsp keybindings
vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('UserLspConfig', {}),
    callback = function(ev)
        -- Buffer local mappings.
        -- See `:help vim.lsp.*` for documentation on any of the below functions
        local opts = { buffer = ev.buf }
        vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
        vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
        vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
        vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
        vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
        vim.keymap.set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, opts)
        vim.keymap.set('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, opts)
        vim.keymap.set('n', '<leader>wl', function()
            print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
        end, opts)
        vim.keymap.set('n', '<leader>D', vim.lsp.buf.type_definition, opts)
        vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
        vim.keymap.set({ 'n', 'v' }, '<leader>ca', vim.lsp.buf.code_action, opts)
        vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
        vim.keymap.set('n', '<leader>fo', function()
            vim.lsp.buf.format { async = true }
        end, opts)
    end,
})
