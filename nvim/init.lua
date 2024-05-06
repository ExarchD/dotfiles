local opt = vim.opt
local icons = require("theme").icons
vim.g.mapleader = ";"
vim.g.maplocalleader = ";"
vim.opt.termguicolors = true

-- code folding settings
opt.foldmethod = "expr"
opt.foldexpr = "nvim_treesitter#foldexpr()"
opt.foldlevelstart = 99
opt.foldnestmax = 10 -- deepest fold is 10 levels
opt.foldenable = false -- don't fold by default
opt.foldlevel = 1

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

local theme = require("theme")
require("lazy").setup({
	{ import = "plugins" },
}, { ui = { border = theme.border } })

vim.g.catppuccin_flavour = "mocha"
-- vim.command.colorscheme "catppuccin"
vim.cmd([[ colorscheme catppuccin-macchiato ]])

-- set up custom symbols for LSP errors
local signs =
	{ Error = icons.error, Warning = icons.warning, Warn = icons.warning, Hint = icons.hint, Info = icons.hint }
for type, icon in pairs(signs) do
	local hl = "DiagnosticSign" .. type
	vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end
