-- Load Omarchy's theme configuration dynamically
local omarchy_theme_path = vim.fn.expand("~/.config/omarchy/current/theme/neovim.lua")

if vim.fn.filereadable(omarchy_theme_path) == 1 then
	-- Load and return Omarchy's theme configuration
	local ok, theme_config = pcall(dofile, omarchy_theme_path)
	if ok then
		return theme_config
	end
end

-- Fallback: disable LazyVim's default colorscheme
return {
	{
		"LazyVim/LazyVim",
		opts = {
			-- Don't set any colorscheme by default
			colorscheme = function() end,
		},
	},
}