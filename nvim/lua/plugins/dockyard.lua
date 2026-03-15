return {
  "emrearmagan/dockyard.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "akinsho/toggleterm.nvim",
  },
  cmd = { "Dockyard", "DockyardFloat" },
  keys = {
    { "<leader>od", "<cmd>Dockyard<cr>", desc = "Open Dockyard" },
  },
  opts = {},
}
