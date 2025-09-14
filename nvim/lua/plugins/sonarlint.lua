return {
	"https://gitlab.com/schrieveslaach/sonarlint.nvim",
	dependencies = {
		"neovim/nvim-lspconfig",
	},
	config = function()
		local extension_path = vim.fn.stdpath("data") .. "/mason/packages/sonarlint-language-server/extension"

		-- Override the global LSP progress handler to filter out SonarLint
		local original_progress_handler = vim.lsp.handlers["$/progress"]
		vim.lsp.handlers["$/progress"] = function(err, result, ctx, config)
			local client = vim.lsp.get_client_by_id(ctx.client_id)
			if client and (client.name == "sonarlint" or client.name == "sonarlint.nvim") then
				return -- Ignore progress from SonarLint
			end
			if original_progress_handler then
				return original_progress_handler(err, result, ctx, config)
			end
		end

		-- -- Configure diagnostic display
		-- vim.diagnostic.config({
		-- 	virtual_text = false, -- Disable inline diagnostics
		-- 	signs = true,
		-- 	underline = true,
		-- 	update_in_insert = false, -- Don't update diagnostics in insert mode
		-- 	severity_sort = true,
		-- })

		require("sonarlint").setup({
			server = {
				cmd = {
					vim.fn.exepath("java"),
					"-jar",
					extension_path .. "/server/sonarlint-ls.jar",
					"-stdio",
					"-analyzers",
					extension_path .. "/analyzers/sonargo.jar",
					extension_path .. "/analyzers/sonarhtml.jar",
					extension_path .. "/analyzers/sonariac.jar",
					extension_path .. "/analyzers/sonarjava.jar",
					extension_path .. "/analyzers/sonarjavasymbolicexecution.jar",
					extension_path .. "/analyzers/sonarjs.jar",
					extension_path .. "/analyzers/sonarphp.jar",
					extension_path .. "/analyzers/sonarpython.jar",
					extension_path .. "/analyzers/sonartext.jar",
					extension_path .. "/analyzers/sonarxml.jar",
				},
				on_attach = function(client, bufnr)
					-- Block textDocument/didChange notifications to prevent analysis on every keystroke
					local original_notify = client.notify
					client.notify = function(method, params, callback)
						if method == "textDocument/didChange" then
							return
						end
						return original_notify(method, params, callback)
					end

					-- Hide this client from statusline plugins
					client.name = "sonarlint"
				end,
				flags = {
					debounce_text_changes = 5000, -- 5 seconds debounce
				},
				handlers = {
					-- Suppress all notifications from SonarLint
					["$/progress"] = function() end,
					["window/showMessage"] = function() end,
					["window/logMessage"] = function() end,
				},
			},
			filetypes = {
				"csharp",
				"cs",
				"javascript",
				"javascriptreact",
				"typescript",
				"typescriptreact",
				"python",
				"java",
				"xml",
				"yaml",
				"json",
				"html",
				"css",
				"scss",
				"lua",
				"go",
				"rust",
				"c",
				"cpp",
			},
		})

		-- Keymap to show diagnostics in floating window
		vim.keymap.set("n", "<leader>sd", vim.diagnostic.open_float, { desc = "Show SonarLint diagnostics" })
	end,
}
