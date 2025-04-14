return {
	"epwalsh/obsidian.nvim",
	version = "*", -- Use the latest stable version
	dependencies = {
		"nvim-lua/plenary.nvim", -- Required dependency
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
			{ "<leader>o", group = "Obsidian", icon = " " },
			{ "<leader>oO", "<cmd>ObsidianTOC<CR>", desc = "Table of contents" },
			{ "<leader>oT", group = "Template" },
			{ "<leader>oTi", "<cmd>ObsidianTemplate<CR>", desc = "Insert template" },
			{ "<leader>oTn", "<cmd>ObsidianNewFromTemplate<CR>", desc = "New from template" },
			{ "<leader>ob", "<cmd>ObsidianBacklinks<CR>", desc = "Backlinks" },
			{ "<leader>oc", "<cmd>ObsidianToggleCheckbox<CR>", desc = "Toggle checkbox" },
			{ "<leader>od", group = "Daily notes" },
			{ "<leader>odd", "<cmd>ObsidianDailies<CR>", desc = "List dailies" },
			{ "<leader>odr", "<cmd>ObsidianTomorrow<CR>", desc = "Tomorrow" },
			{ "<leader>odt", "<cmd>ObsidianToday<CR>", desc = "Today" },
			{ "<leader>ody", "<cmd>ObsidianYesterday<CR>", desc = "Yesterday" },
			{ "<leader>of", "<cmd>ObsidianFollowLink<CR>", desc = "Follow link" },
			{ "gd", "<cmd>ObsidianFollowLink<CR>", desc = "Follow link" },
			{ "<leader>ol", group = "Link" },
			{ "<leader>olL", "<cmd>ObsidianLinks<CR>", desc = "Collect links" },
			{ "<leader>on", "<cmd>ObsidianNew<CR>", desc = "New note" },
			{ "<leader>oo", "<cmd>ObsidianOpen<CR>", desc = "Open note" },
			{ "<leader>op", "<cmd>ObsidianPasteImg<CR>", desc = "Paste image" },
			{ "<leader>oq", "<cmd>ObsidianQuickSwitch<CR>", desc = "Quick switch" },
			{ "<leader>or", "<cmd>ObsidianRename<CR>", desc = "Rename note" },
			{ "<leader>os", "<cmd>ObsidianSearch<CR>", desc = "Search notes" },
			{ "<leader>ot", "<cmd>ObsidianTags<CR>", desc = "Tags" },
			{ "<leader>ow", "<cmd>ObsidianWorkspace<CR>", desc = "Workspace" },
		}
		wk.add(normal_mappings, { mode = "n" })

		local visual_mappings = {
			{ "<leader>oll", "<cmd>ObsidianLink<CR>", desc = "Link selection" },
			{ "<leader>oln", "<cmd>ObsidianLinkNew<CR>", desc = "New link" },
			{ "<leader>olx", "<cmd>ObsidianExtractNote<CR>", desc = "Extract note" },
		}
		wk.add(visual_mappings, { mode = "v" })
	end,
}
