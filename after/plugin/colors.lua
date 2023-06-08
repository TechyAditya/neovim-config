--[[require("transparent").setup({
  groups = { -- table: default groups
    'Normal', 'NormalNC', 'Comment', 'Constant', 'Special', 'Identifier',
    'Statement', 'PreProc', 'Type', 'Underlined', 'Todo', 'String', 'Function',
    'Conditional', 'Repeat', 'Operator', 'Structure', 'LineNr', 'NonText',
    'SignColumn', 'CursorLineNr', 'EndOfBuffer',
  },
  extra_groups = {}, -- table: additional groups that should be cleared
  exclude_groups = {}, -- table: groups you don't want to clear
})
--]]
function waifu(color)

	color = color or "aurora"
	vim.cmd.colorscheme(color)
	vim.g.transparent_groups = vim.list_extend({}, { "EndOfBuffer" })

	vim.api.nvim_set_hl(0, "Normal", { bg = "none" })	
	vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
	vim.api.nvim_set_hl(0, "EndOfBuffer", { bg = "none" })
--	vim.api.nvim_set_hl(0, "LineNr", { bg = "none" })
	vim.api.nvim_set_hl(0, "LineNrAbove", { bg = "none" })
	vim.api.nvim_set_hl(0, "LineNrBelow", { bg = "none" })
--	vim.api.nvim_command('redraw')
end

waifu()
