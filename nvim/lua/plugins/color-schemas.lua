return {
	{ "akinsho/bufferline.nvim", enabled = false },
	{
		"catppuccin/nvim",
		name = "catppuccin",
		opts = {
			flavour = "mocha",
			transparent_background = true,
			styles = {
				comments = { "italic" },
				keywords = { "italic" },
				types = { "bold" },
			},
			integrations = {
				neotree = true,
				telescope = { enabled = true },
				native_lsp = { enabled = true },
			},
		},
	},
	{
		"rose-pine/neovim",
		name = "rose-pine",
		opts = {
			transparent = true,
			styles = {
				sidebars = "transparent",
				floats = "transparent",
			},
		},
	},
	{
		"EdenEast/nightfox.nvim",
		config = function()
			require("nightfox").setup({
				options = {
					transparent = true,
					styles = {
						comments = "italic",
						keywords = "italic",
						types = "bold",
					},
				},
				groups = {
					all = {
						NormalFloat = { bg = "NONE" },
						NormalSB = { bg = "NONE" },
						NormalNC = { bg = "NONE" },
						FloatBorder = { bg = "NONE" },
						Pmenu = { bg = "NONE" },
						PmenuSel = { bg = "bg2" },
						TelescopeNormal = { bg = "NONE" },
						TelescopeBorder = { bg = "NONE" },
						NeoTreeNormal = { bg = "NONE" },
						NeoTreeNormalNC = { bg = "NONE" },
					},
				},
			})
		end,
	},
}
