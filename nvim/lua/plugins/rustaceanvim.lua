return {
	"mrcjkb/rustaceanvim",
	version = "^5",
	lazy = false,
	config = function()
		vim.g.rustaceanvim = {
			server = {
				settings = {
					["rust-analyzer"] = {
						inlayHints = {
							enable = true,
						},
						procMacro = {
							enable = true,
						},
						cargo = {
							buildScripts = {
								enable = true,
							},
						},
					},
				},
			},
		}
	end,
}

