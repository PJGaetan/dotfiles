local function open_menu_popup()
	-- ordered entries
	local entries = {
		{ key = "w", file = "work.org" },
		{ key = "p", file = "perso.org" },
		{ key = "i", file = "interest.org" },
		{ key = "r", file = "refile.org" },
	}

	-- buffer
	local buf = vim.api.nvim_create_buf(false, true)

	-- fill buffer lines
	local lines = {}
	for _, entry in ipairs(entries) do
		table.insert(lines, string.format("[%s] %s", entry.key, entry.file))
	end
	vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)

	-- calculate popup size
	local width = 30
	local height = #lines
	local ui = vim.api.nvim_list_uis()[1]
	local row = math.floor((ui.height - height) / 2)
	local col = math.floor((ui.width - width) / 2)

	-- open floating window
	local win = vim.api.nvim_open_win(buf, true, {
		relative = "editor",
		width = width,
		height = height,
		row = row,
		col = col,
		style = "minimal",
		border = "rounded",
	})

	-- buffer opts
	vim.bo[buf].buftype = "nofile"
	vim.bo[buf].bufhidden = "wipe"
	vim.bo[buf].swapfile = false
	vim.bo[buf].modifiable = false

	-- helper to open file
	local function open_file(file)
		vim.api.nvim_win_close(win, true)
		vim.cmd("edit ~/Jottacloud/orgfiles/" .. file)
	end

	local function open_file_vsplit(file)
		vim.api.nvim_win_close(win, true)
		vim.cmd("vsplit ~/Jottacloud/orgfiles/" .. file)
	end

	-- map single-key shortcuts
	local opts = { noremap = true, silent = true, buffer = buf }
	for _, entry in ipairs(entries) do
		vim.keymap.set("n", entry.key, function()
			open_file(entry.file)
		end, opts)
		vim.keymap.set("n", "<C-" .. entry.key .. ">", function()
			open_file_vsplit(entry.file)
		end, opts)
	end

	-- map <Enter> on the current line
	vim.keymap.set("n", "<CR>", function()
		local lnum = vim.api.nvim_win_get_cursor(0)[1]
		local entry = entries[lnum]
		if entry then
			open_file(entry.file)
		end
	end, opts)

	-- map q to close popup without opening
	vim.keymap.set("n", "q", function()
		vim.api.nvim_win_close(win, true)
	end, opts)
end

-- Command to launch the popup
vim.keymap.set("n", "<leader>om", open_menu_popup, { noremap = true, silent = true, desc = "Open Org Menu" })
