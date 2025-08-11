-- lua/plugins/rose-pine.lua
return {
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
