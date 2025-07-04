return {
	"coder/claudecode.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"MunifTanjim/nui.nvim",
	},
	config = function()
		require("claudecode").setup({
			terminal = {
				split_side = "right",
				split_width_percentage = 0.5, -- 50% width
			},
		})

		-- Keybindings using which-key
		local wk = require("which-key")
		wk.add({
			{ "<leader>o", group = "AI Agent", icon = "🤖" },
			{ "<leader>oc", "<cmd>ClaudeCode<CR>", desc = "Claude Chat", icon = "🤖" },
			{ "<leader>oa", "<cmd>ClaudeCodeDiffAccept<CR>", desc = "Accept Changes", icon = "✓" },
			{ "<leader>or", "<cmd>ClaudeCodeDiffDeny<CR>", desc = "Reject Changes", icon = "✗" },
			{ "<leader>ov", "<cmd>ClaudeCodeFocus<CR>", desc = "Focus Claude", icon = "👁" },
			{ "<leader>os", "<cmd>ClaudeCodeStop<CR>", desc = "Stop Claude", icon = "⏹" },
			{ "<leader>ot", "<cmd>ClaudeCodeOpen<CR>", desc = "Open Window", icon = "🔄" },
			{ "<leader>oh", "<cmd>ClaudeCodeStatus<CR>", desc = "Show Status", icon = "📜" },
			{ "<leader>od", "<cmd>ClaudeCodeClose<CR>", desc = "Close Window", icon = "🗑" },
		})
	end,
}
