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
				split_width_percentage = 0.35, -- 50% width
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
			{ "<leader>ox", "<cmd>ClaudeCodeStop<CR>", desc = "Stop Claude", icon = "⏹" },
			{ "<leader>ot", "<cmd>ClaudeCodeOpen<CR>", desc = "Open Window", icon = "🔄" },
			{ "<leader>oh", "<cmd>ClaudeCodeStatus<CR>", desc = "Show Status", icon = "📜" },
			{ "<leader>od", "<cmd>ClaudeCodeClose<CR>", desc = "Close Window", icon = "🗑" },
			{ "<leader>on", "<cmd>ClaudeCodeStart<CR>", desc = "Start Claude", icon = "▶" },
			{ "<leader>oa", "<cmd>ClaudeCodeSend<CR>", desc = "Send to Claude", icon = "📤", mode = "v" },
			{ "<leader>oA", "<cmd>ClaudeCodeAdd %<CR>", desc = "Add Current Buffer", icon = "➕" },
			{ "<leader>oT", "<cmd>ClaudeCodeTreeAdd<CR>", desc = "Add Tree to Context", icon = "🌳" },
		})
	end,
}
