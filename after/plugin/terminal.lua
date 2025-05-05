local toggleterm = require("toggleterm")

toggleterm.setup({
    size = 100,
    open_mapping = [[<C-\>]],
    hide_numbers = true,
    shade_filetypes = {},
    shade_terminals = true,
    shading_factor = 2,
    start_in_insert = true,
    insert_mappings = true,
    persist_size = true,
    direction =  "vertical",
    close_on_exit = true,
    shell = vim.o.shell,
    float_opts = {
        border = "curved",
        winblend = 0,
        highlights = {
            border = "Normal",
            background = "Normal",
        },
    },
})

-- toggleterm.setup({
--     size = 10,
--     open_mapping = [[<C-|>]],
--     hide_numbers = true,
--     shade_filetypes = {},
--     shade_terminals = true,
--     shading_factor = 2,
--     start_in_insert = true,
--     insert_mappings = true,
--     persist_size = true,
--     direction =  "horizontal",
--     close_on_exit = true,
--     shell = vim.o.shell,
--     float_opts = {
--         border = "curved",
--         winblend = 0,
--         highlights = {
--             border = "Normal",
--             background = "Normal",
--         },
--     },
-- })

function _G.set_terminal_keymaps()
    local opts = {noremap = true}
    vim.api.nvim_buf_set_keymap(0, 't', '<esc>', [[<C-\><C-n>]], opts)
    vim.api.nvim_buf_set_keymap(0, 't', 'jk', [[<C-\><C-n>]], opts)
    vim.api.nvim_buf_set_keymap(0, 't', '<C-h>', [[<C-\><C-n><C-W>h]], opts)
    vim.api.nvim_buf_set_keymap(0, 't', '<C-j>', [[<C-\><C-n><C-W>j]], opts)
    vim.api.nvim_buf_set_keymap(0, 't', '<C-k>', [[<C-\><C-n><C-W>k]], opts)
    vim.api.nvim_buf_set_keymap(0, 't', '<C-l>', [[<C-\><C-n><C-W>l]], opts)
    vim.api.nvim_set_keymap("n", "<leader>t", "<cmd>lua _COMPILE()<CR>", opts)
end

vim.cmd('autocmd! TermOpen term://* lua set_terminal_keymaps()')

local Terminal = require("toggleterm.terminal").Terminal

--local python = Terminal:new({ cmd = "python", hidden = true, direction = "float" })

--function _PYTHON_TOGGLE()
--    python:toggle()
--end


function _COMPILE()
    local fileExtension = vim.fn.expand("%:e")
    if fileExtension == "py" then
        _PYTHON_TOGGLE()
    elseif fileExtension == "c" then
        _GCC_TOGGLE()
    elseif fileExtension == "cpp" then
        _GPP_TOGGLE()
    elseif fileExtension == "pl" then
        _PERL_TOGGLE()
    elseif fileExtension == "go" then
        _GO_TOGGLE()
    else 
        print("No compiler found for this file type")
    end
end

function _PYTHON_TOGGLE()
    local path = vim.fn.expand("%:p:h")
    local pathlessFileName = vim.fn.expand("%:t:r")
    local comm = string.format("cd \"%s\" && python \"%s.py\"", path, pathlessFileName, pathlessFileName, pathlessFileName)
    print(comm)
    local terminal = Terminal:new({ cmd = comm, direction = "float", close_on_exit = false, hidden = true }) 
    terminal:toggle()
end

function _PERL_TOGGLE()
    local path = vim.fn.expand("%:p:h")
    local pathlessFileName = vim.fn.expand("%:t:r")
    local comm = string.format("cd \"%s\" && perl \"%s.pl\"", path, pathlessFileName, pathlessFileName, pathlessFileName)
    print(comm)
    local terminal = Terminal:new({ cmd = comm, direction = "float", close_on_exit = false, hidden = true }) 
    terminal:toggle()
end

function _GCC_TOGGLE()
    local path = vim.fn.expand("%:p:h")
    local pathlessFileName = vim.fn.expand("%:t:r")
    local comm = string.format("cd \"%s\" && gcc \"%s.c\" -o a.out && ./a.out", path, pathlessFileName, pathlessFileName, pathlessFileName)
    -- local comm = "gcc " .. pathlessFileName .. ".c -o " .. pathlessFileName .. " && ./" .. pathlessFileName
    print(comm)
    local terminal = Terminal:new({ cmd = comm, direction = "float", close_on_exit = false, hidden = true }) 
    terminal:toggle()
end

function _GPP_TOGGLE()
    local path = vim.fn.expand("%:p:h")
    local pathlessFileName = vim.fn.expand("%:t:r")
    -- local comm = "g++ " .. pathlessFileName .. ".cpp -o " .. pathlessFileName .. " && ./" .. pathlessFileName
    local comm = string.format("cd \"%s\" && g++ \"%s.cpp\" -o a.out && ./a.out", path, pathlessFileName, pathlessFileName, pathlessFileName)
    print(comm)
    local terminal = Terminal:new({ cmd = comm, direction = "float", close_on_exit = false, hidden = true }) 
    terminal:toggle()
end

function _GO_TOGGLE()
    local path = vim.fn.expand("%:p:h")
    -- local comm = "g++ " .. pathlessFileName .. ".cpp -o " .. pathlessFileName .. " && ./" .. pathlessFileName
    local comm = string.format("cd \"%s\" && go run .", path, pathlessFileName, pathlessFileName, pathlessFileName)
    print(comm)
    local terminal = Terminal:new({ cmd = comm, direction = "float", close_on_exit = false, hidden = true }) 
    terminal:toggle()
end
