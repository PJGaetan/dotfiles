vim.api.nvim_create_user_command("GPG", function(opts)
	local function decrypt_to_buffer(filename)
		-- Create a new vertical split buffer
		vim.cmd("vsplit")
		local buf = vim.api.nvim_create_buf(false, true)
		vim.api.nvim_win_set_buf(0, buf)

		-- Set buffer name and options
		-- Setting the buffer name makes it crash if I want to run it multiple time
		-- vim.api.nvim_buf_set_name(buf, "[GPG Decrypt: " .. filename .. "]")
		vim.api.nvim_buf_set_option(buf, "buftype", "nofile")
		vim.api.nvim_buf_set_option(buf, "swapfile", false)

		-- Create floating terminal window
		local width = math.floor(vim.o.columns * 0.8)
		local height = math.floor(vim.o.lines * 0.8)
		local row = math.floor((vim.o.lines - height) / 2)
		local col = math.floor((vim.o.columns - width) / 2)

		local float_buf = vim.api.nvim_create_buf(false, true)
		local float_win = vim.api.nvim_open_win(float_buf, true, {
			relative = "editor",
			width = width,
			height = height,
			row = row,
			col = col,
			style = "minimal",
			border = "rounded",
		})
		vim.cmd("startinsert")
		vim.api.nvim_set_current_win(float_win)

		-- Prepare the command
		local cmd = "gpg --pinentry-mode loopback --decrypt --output - " .. vim.fn.shellescape(filename)

		-- Variable to store output
		local output_lines = {}
		local job_finished = false

		-- Start terminal job
		local job_id = vim.fn.termopen(cmd, {
			on_stdout = function(_, data, _)
				if data then
					for _, line in ipairs(data) do
						if line ~= "" then
							local cleaned = line:gsub("\r", "")
							table.insert(output_lines, cleaned)
						end
					end
				end
			end,
			on_exit = function(_, exit_code, _)
				job_finished = true
				-- Close the floating window
				if vim.api.nvim_win_is_valid(float_win) then
					vim.api.nvim_win_close(float_win, true)
				end

				-- Write output to the vertical buffer
				if exit_code == 0 and #output_lines > 0 then
					vim.api.nvim_buf_set_lines(buf, 0, -1, false, output_lines)
					-- Set cursor to the beginning of the buffer
					vim.api.nvim_win_set_cursor(vim.fn.bufwinid(buf), { 1, 0 })
					print("GPG decryption completed successfully")
				else
					vim.api.nvim_buf_set_lines(buf, 0, -1, false, { "Error: GPG decryption failed" })
					print("GPG decryption failed with exit code: " .. exit_code)
				end
			end,
		})

		-- Set terminal buffer options
		vim.api.nvim_buf_set_option(float_buf, "bufhidden", "wipe")

		-- Add keybinding to close floating window manually if needed
		vim.api.nvim_buf_set_keymap(float_buf, "n", "q", "<cmd>close<CR>", { noremap = true, silent = true })
		vim.api.nvim_buf_set_keymap(float_buf, "t", "<Esc>", "<C-\\><C-n>", { noremap = true, silent = true })
	end
	local filename = vim.api.nvim_buf_get_name(0)
	decrypt_to_buffer(filename)
end, {})
