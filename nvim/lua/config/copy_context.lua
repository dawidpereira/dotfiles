local M = {}

function M.copy_context()
	local filepath = vim.fn.expand("%:p")
	local script_path = vim.fn.expand("~/dotfiles/scripts/nvim_copy_context.sh")

	-- Check current mode to determine if we're in visual mode
	local mode = vim.fn.mode()

	if mode == "v" or mode == "V" or mode == "" then
		-- Visual mode - get selected text using registers
		vim.cmd('normal! "zy')
		local selected_text = vim.fn.getreg("z")

		-- Get visual selection marks
		local start_pos = vim.fn.getpos("'<")
		local end_pos = vim.fn.getpos("'>")
		local start_line = start_pos[2]
		local end_line = end_pos[2]

		-- Escape selected text for shell
		selected_text = selected_text:gsub('"', '\\"'):gsub("\\", "\\\\")
		local cmd =
			string.format('bash "%s" "%s" "%s" "%d" "%d"', script_path, filepath, selected_text, start_line, end_line)
		local output = vim.fn.system(cmd)
		if output and output ~= "" then
			print(vim.trim(output))
		end

		-- Exit visual mode
		vim.cmd("normal! \\<Esc>")
	else
		-- Normal mode - just copy filepath with current line number
		local current_line = vim.fn.line(".")
		local cmd = string.format('bash "%s" "%s" "" "%d"', script_path, filepath, current_line)
		local output = vim.fn.system(cmd)
		if output and output ~= "" then
			print(vim.trim(output))
		end
	end
end

return M
