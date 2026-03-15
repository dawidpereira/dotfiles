-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
local keymap = vim.keymap
local defaultOpts = { noremap = true, silent = true }

local function map(mode, lhs, rhs, desc, opts)
  local outer_opts = vim.tbl_extend("force", { noremap = true, silent = true, desc = desc or "" }, opts or {})
  vim.keymap.set(mode, lhs, rhs, outer_opts)
end

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

-- Snacks Explorer keymaps
local snacks_explorer = require("snacks.explorer")

vim.keymap.set("n", "<leader>e", function()
  snacks_explorer.open({ root = true })
end, { desc = "Explorer Snacks (root dir)" })

vim.keymap.set("n", "<leader>E", function()
  snacks_explorer.open({ root = false })
end, { desc = "Explorer Snacks (cwd)" })

-- Global quit keybinding (close nvim)
vim.keymap.set("n", "<C-q>", "<cmd>qa<cr>", { desc = "Quit nvim" })
