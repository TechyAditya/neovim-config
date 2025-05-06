local toggleterm = require("toggleterm")
local Terminal = require("toggleterm.terminal").Terminal

toggleterm.setup({
    size = 100,
    open_mapping = false,
    hide_numbers = true,
    shade_filetypes = {},
    shade_terminals = true,
    shading_factor = 2,
    start_in_insert = true,
    insert_mappings = true,
    persist_size = true,
    direction = "vertical",
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
    local opts = { noremap = true }
    vim.api.nvim_buf_set_keymap(0, 't', '<esc>', [[<C-\><C-n>]], opts)
    vim.api.nvim_buf_set_keymap(0, 't', 'jk', [[<C-\><C-n>]], opts)
    vim.api.nvim_buf_set_keymap(0, 't', '<C-h>', [[<C-\><C-n><C-W>h]], opts)
    vim.api.nvim_buf_set_keymap(0, 't', '<C-j>', [[<C-\><C-n><C-W>j]], opts)
    vim.api.nvim_buf_set_keymap(0, 't', '<C-k>', [[<C-\><C-n><C-W>k]], opts)
    vim.api.nvim_buf_set_keymap(0, 't', '<C-l>', [[<C-\><C-n><C-W>l]], opts)
end

vim.api.nvim_create_autocmd("TermOpen", {
    pattern = "term://*toggleterm#*",
    callback = _G.set_terminal_keymaps,
})

vim.keymap.set("n", "<C-\\>", "<cmd>ToggleTerm<CR>", { noremap = true, silent = true })

local terminals = {}
local last_compile_cmd

local function get_compiler_term(cmd)
    print(terminals)
    if not terminals[cmd] then
        terminals[cmd] = Terminal:new {
            cmd           = cmd,
            direction     = "float",
            hidden        = true,
            close_on_exit = false,
            start_in_insert= false,
        }
    end
    return terminals[cmd]
end

vim.keymap.set("n", "<leader>t", "<cmd>lua _COMPILE()<CR><C-\\><C-n>", { noremap = true, silent = true })

function _COMPILE()
  -- if we’re in a term buffer, just re-toggle the last compile terminal
  if vim.bo.buftype == "terminal" then
    if last_compile_cmd and terminals[last_compile_cmd] then
      terminals[last_compile_cmd]:toggle()
    else
      print("No compile terminal to toggle")
    end
    return
  end

  -- we’re in a file; detect extension
  local ext     = vim.fn.expand("%:e")
  local dir     = vim.fn.expand("%:p:h")
  local base    = vim.fn.expand("%:t:r")

  -- map extensions to shell commands
  local cmds = {
    py   = string.format('cd "%s" && python "%s.py"',         dir, base),
    c    = string.format('cd "%s" && gcc "%s.c" -o a.out && ./a.out', dir, base),
    cpp  = string.format('cd "%s" && g++ "%s.cpp" -o a.out && ./a.out', dir, base),
    pl   = string.format('cd "%s" && perl "%s.pl"',           dir, base),
    go   = string.format('cd "%s" && go run .',               dir),
    html = string.format('cd "%s" && ws -p 2669',             dir),
  }

  local cmd = cmds[ext]
  if not cmd then
    print("No compiler found for extension: " .. ext)
    return
  end

  -- store and toggle
  last_compile_cmd = cmd
  get_compiler_term(cmd):toggle()
end

function _PYTHON_TOGGLE()
    local path = vim.fn.expand("%:p:h")
    local pathlessFileName = vim.fn.expand("%:t:r")
    local comm = string.format("cd \"%s\" && python \"%s.py\"", path, pathlessFileName, pathlessFileName,
        pathlessFileName)
    get_compiler_term(comm):toggle()
end

function _PERL_TOGGLE()
    local path = vim.fn.expand("%:p:h")
    local pathlessFileName = vim.fn.expand("%:t:r")
    local comm = string.format("cd \"%s\" && perl \"%s.pl\"", path, pathlessFileName, pathlessFileName, pathlessFileName)
    get_compiler_term(comm):toggle()
end

function _GCC_TOGGLE()
    local path = vim.fn.expand("%:p:h")
    local pathlessFileName = vim.fn.expand("%:t:r")
    local comm = string.format("cd \"%s\" && gcc \"%s.c\" -o a.out && ./a.out", path, pathlessFileName, pathlessFileName,
        pathlessFileName)
    get_compiler_term(comm):toggle()
end

function _GPP_TOGGLE()
    local path = vim.fn.expand("%:p:h")
    local pathlessFileName = vim.fn.expand("%:t:r")
    local comm = string.format("cd \"%s\" && g++ \"%s.cpp\" -o a.out && ./a.out", path, pathlessFileName,
        pathlessFileName, pathlessFileName)
    get_compiler_term(comm):toggle()
end

function _GO_TOGGLE()
    local path = vim.fn.expand("%:p:h")
    local comm = string.format("cd \"%s\" && go run .", path)
    get_compiler_term(comm):toggle()
end

function _HTTP_TOGGLE()
    local path = vim.fn.expand("%:p:h")
    local comm = string.format("cd \"%s\" && ws -p 2669", path)
    get_compiler_term(comm):toggle()
end
