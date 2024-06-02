-- TODO: create commands/api to 
-- 1. install venv from requirements.txt/pyproject.toml
-- 2. build and publish library to pypi
-- 3. run single test file

ns = vim.api.nvim_create_namespace("indent")
overlay = nil

local function insert_virtual_indent()

    overlay = vim.api.nvim_buf_set_extmark(0, ns, 0, 0, {
        virt_text = {{"****", ""}},
        virt_text_pos = "overlay"
    })
end

vim.api.nvim_create_user_command("InsertVirtId", insert_virtual_indent, {})
