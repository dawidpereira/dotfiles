-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
local keymap = vim.keymap
local defaultOpts = { noremap = true, silent = true }
local Util = require("lazyvim.util")

local function map(mode, lhs, rhs, desc, opts)
	local outer_opts = vim.tbl_extend("force", { noremap = true, silent = true, desc = desc or "" }, opts or {})
	vim.keymap.set(mode, lhs, rhs, outer_opts)
end

-- Center buffer while navigating
-- Temprorary dissabled
-- map("n", "<C-u>", "<C-u>zz")
-- map("n", "<C-u>", "<C-u>zz")
-- map("n", "<C-d>", "<C-d>zz")
-- map("n", "{", "{zz")
-- map("n", "}", "}zz")
-- map("n", "N", "nzz")
-- map("n", "n", "nzz")
-- map("n", "G", "Gzz")
-- map("n", "gg", "ggzz")
-- map("n", "<C-i>", "<C-i>zz")
-- map("n", "<C-o>", "<C-o>zz")
-- map("n", "%", "%zz")
-- map("n", "*", "*zz")
-- map("n", "#", "#zz")

map("i", "jj", "<Esc>")
map("i", "kk", "<Esc>")

keymap.set("n", "<C-h>", "<Cmd>NvimTmuxNavigateLeft<CR>", { silent = true })
keymap.set("n", "<C-j>", "<Cmd>NvimTmuxNavigateDown<CR>", { silent = true })
keymap.set("n", "<C-k>", "<Cmd>NvimTmuxNavigateUp<CR>", { silent = true })
keymap.set("n", "<C-l>", "<Cmd>NvimTmuxNavigateRight<CR>", { silent = true })
keymap.set("n", "<C-\\>", "<Cmd>NvimTmuxNavigateLastActive<CR>", { silent = true })
keymap.set("n", "<C-Space>", "<Cmd>NvimTmuxNavigateNavigateNext<CR>", { silent = true })

-- Press 'U' for redo
keymap.set("n", "U", "<C-r>", defaultOpts)
