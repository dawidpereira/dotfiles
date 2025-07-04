return {
	"epwalsh/obsidian.nvim",
	version = "*", -- Use the latest stable version
	dependencies = {
		"nvim-lua/plenary.nvim", -- Required dependency
		"nvim-telescope/telescope.nvim", -- Required dependency
	},
	opts = {
		workspaces = {
			{
				name = "Zettelkasten",
				path = "~/Documents/Zettelkasten",
			},
		},
		daily_notes = {
			date_format = "%d-%m-%Y",
			alias_format = "%B %-d, %Y",
			default_tags = { "daily" },
			folder = "Daily", -- Default folder for daily notes
		},
		templates = {
			subdir = "Templates",
			date_format = "%d-%m-%Y",
			time_format = "%H:%M",
		},
		disable_frontmatter = true,
		preferred_link_style = "wiki", -- indicate that links should use alias only
		-- Do not override note_id_func; let obsidian.nvim generate the default ID.
		note_path_func = function(spec)
			local name = spec.title or spec.id
			local path = spec.dir / name
			return path:with_suffix(".md")
		end,
		note_frontmatter_func = function(note)
			-- Preserve the auto-generated ID and add the provided title as an alias, if available.
			if note.title and note.title ~= note.id then
				note:add_alias(note.title)
			end
			return { id = note.id, aliases = note.aliases, tags = note.tags }
		end,
		-- Override the wiki link function so that it uses only the alias (or title)
		wiki_link_func = function(opts)
			local note = opts.note
			local alias = (note.aliases and note.aliases[1]) or note.title or note.id
			return "[[" .. alias .. "]]"
		end,
	},
	config = function(_, opts)
		require("obsidian").setup(opts)

		local wk = require("which-key")
		local normal_mappings = {
			{ "<leader>O", group = "Obsidian", icon = " " },
			{ "<leader>OO", "<cmd>ObsidianTOC<CR>", desc = "Table of contents" },
			{ "<leader>OT", group = "Template" },
			{ "<leader>OTi", "<cmd>ObsidianTemplate<CR>", desc = "Insert template" },
			{ "<leader>OTn", "<cmd>ObsidianNewFromTemplate<CR>", desc = "New from template" },
			{ "<leader>Ob", "<cmd>ObsidianBacklinks<CR>", desc = "Backlinks" },
			{ "<leader>Oc", "<cmd>ObsidianToggleCheckbox<CR>", desc = "Toggle checkbox" },
			{ "<leader>Od", group = "Daily notes" },
			{ "<leader>Odd", "<cmd>ObsidianDailies<CR>", desc = "List dailies" },
			{ "<leader>Odr", "<cmd>ObsidianTomorrow<CR>", desc = "Tomorrow" },
			{ "<leader>Odt", "<cmd>ObsidianToday<CR>", desc = "Today" },
			{ "<leader>Ody", "<cmd>ObsidianYesterday<CR>", desc = "Yesterday" },
			{ "<leader>Of", "<cmd>ObsidianFollowLink<CR>", desc = "Follow link" },
			{ "gd", "<cmd>ObsidianFollowLink<CR>", desc = "Follow link" },
			{ "<leader>Ol", group = "Link" },
			{ "<leader>OlL", "<cmd>ObsidianLinks<CR>", desc = "Collect links" },
			{ "<leader>On", "<cmd>ObsidianNew<CR>", desc = "New note" },
			{ "<leader>Oo", "<cmd>ObsidianOpen<CR>", desc = "Open note" },
			{ "<leader>Op", "<cmd>ObsidianPasteImg<CR>", desc = "Paste image" },
			{ "<leader>Oq", "<cmd>ObsidianQuickSwitch<CR>", desc = "Quick switch" },
			{ "<leader>Or", "<cmd>ObsidianRename<CR>", desc = "Rename note" },
			{ "<leader>Os", "<cmd>ObsidianSearch<CR>", desc = "Search notes" },
			{ "<leader>Ot", "<cmd>ObsidianTags<CR>", desc = "Tags" },
			{ "<leader>Ow", "<cmd>ObsidianWorkspace<CR>", desc = "Workspace" },
		}
		wk.add(normal_mappings, { mode = "n" })

		local visual_mappings = {
			{ "<leader>Oll", "<cmd>ObsidianLink<CR>", desc = "Link selection" },
			{ "<leader>Oln", "<cmd>ObsidianLinkNew<CR>", desc = "New link" },
			{ "<leader>Olx", "<cmd>ObsidianExtractNote<CR>", desc = "Extract note" },
		}
		wk.add(visual_mappings, { mode = "v" })
	end,
}
