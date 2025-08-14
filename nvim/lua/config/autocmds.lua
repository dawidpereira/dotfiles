-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")

-- Allow dd to remove items from quickfix list
vim.api.nvim_create_autocmd("FileType", {
  pattern = "qf",
  callback = function()
    vim.keymap.set("n", "dd", function()
      local qflist = vim.fn.getqflist()
      local idx = vim.fn.line(".")
      table.remove(qflist, idx)
      vim.fn.setqflist(qflist, "r")
      -- Reopen to refresh the view
      vim.cmd("copen")
      -- Move cursor to appropriate position
      local new_idx = math.min(idx, #qflist)
      if new_idx > 0 then
        vim.cmd("normal! " .. new_idx .. "G")
      end
    end, { buffer = true, desc = "Remove quickfix item" })
  end,
})
