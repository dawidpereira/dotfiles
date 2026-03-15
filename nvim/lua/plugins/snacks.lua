return {
  "folke/snacks.nvim",
  opts = {
    picker = {
      sources = {
        notifications = {
          confirm = function(picker, item)
            if item and item.item then
              vim.fn.setreg("+", item.item.msg)
              Snacks.notify("Copied to clipboard", { title = "Notifications" })
            end
            picker:close()
          end,
        },
      },
      layouts = {
        sidebar = {
          layout = {
            position = "left",
          },
        },
      },
    },
    lazygit = {
      env = {
        SHELL = "/bin/zsh",
      },
    },
  },
}
