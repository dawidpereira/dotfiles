return {
  "sindrets/diffview.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  cmd = {
    "DiffviewOpen",
    "DiffviewClose",
    "DiffviewToggleFiles",
    "DiffviewFocusFiles",
    "DiffviewRefresh",
    "DiffviewFileHistory",
  },
  keys = {
    { "<leader>gv", group = "Diff View" },
    { "<leader>gvd", "<cmd>DiffviewOpen<cr>", desc = "Diff Index" },
    { "<leader>gvD", "<cmd>DiffviewOpen HEAD<cr>", desc = "Diff HEAD" },
    { "<leader>gvm", "<cmd>DiffviewOpen main<cr>", desc = "Diff vs main" },
    { "<leader>gvh", "<cmd>DiffviewFileHistory %<cr>", desc = "File History (current)" },
    { "<leader>gvH", "<cmd>DiffviewFileHistory<cr>", desc = "File History (repo)" },
    { "<leader>gvf", "<cmd>DiffviewToggleFiles<cr>", desc = "Toggle File Panel" },
    { "<leader>gvr", "<cmd>DiffviewRefresh<cr>", desc = "Refresh" },
    { "<leader>gvq", "<cmd>DiffviewClose<cr>", desc = "Close Diffview" },
  },
  opts = {
    enhanced_diff_hl = true,
    show_help_hints = false,
    use_icons = true,
    watch_index = true,
    view = {
      default = {
        layout = "diff2_horizontal",
        disable_diagnostics = true,
        winbar_info = true,
      },
      merge_tool = {
        layout = "diff3_mixed",
        disable_diagnostics = true,
        winbar_info = true,
      },
      file_history = {
        layout = "diff2_horizontal",
        disable_diagnostics = true,
        winbar_info = true,
      },
    },
    file_panel = {
      listing_style = "tree",
      tree_options = {
        flatten_dirs = true,
        folder_statuses = "only_folded",
      },
      win_config = {
        position = "left",
        width = 35,
      },
    },
    file_history_panel = {
      log_options = {
        git = {
          single_file = { diff_merges = "combined" },
          multi_file = { diff_merges = "first-parent" },
        },
      },
      win_config = {
        position = "bottom",
        height = 16,
      },
    },
  },
}
