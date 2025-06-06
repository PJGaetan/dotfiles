local function zettelkasten(title)
	-- Create note IDs in a Zettelkasten format with a timestamp and a suffix.
	-- In this case a note with the title 'My new note' will given an ID that looks
	-- like '1657296016-my-new-note', and therefore the file name '1657296016-my-new-note.md'
	local suffix = ""
	if title ~= nil then
		-- If title is given, transform it into valid file name.
		suffix = title:gsub(" ", "-"):gsub("[^A-Za-z0-9-]", ""):lower()
	else
		-- If title is nil, just add 4 random uppercase letters to the suffix.
		for _ = 1, 4 do
			suffix = suffix .. string.char(math.random(65, 90))
		end
	end
	return tostring(os.time()) .. "-" .. suffix
end

local client = require("obsidian").setup({
	dir = "~/Documents/pjg-notes", -- no need to call 'vim.fn.expand' here

	-- Optional, if you keep notes in a specific subdirectory of your vault.
	notes_subdir = "notes",

	-- Optional, if you keep daily notes in a separate directory.
	daily_notes = {
		folder = "notes/dailies",
	},

	-- Optional, completion.
	completion = {
		nvim_cmp = true, -- if using nvim-cmp, otherwise set to false
		min_chars = 2,
	},
	acknowledge_conflicts = true,

	-- Optional, customize how names/IDs for new notes are created.
	note_id_func = function(title)
		-- create note from title name
		local suffix = ""
		if title ~= nil then
			-- If title is given, transform it into valid file name.
			suffix = title:gsub(" ", "-"):gsub("[^A-Za-z0-9-]", ""):lower()
		else
			-- If title is nil, just add 4 random uppercase letters to the suffix.
			for _ = 1, 4 do
				suffix = suffix .. string.char(math.random(65, 90))
			end
		end
		return suffix
	end,

	-- Optional, alternatively you can customize the frontmatter data.
	note_frontmatter_func = function(note)
		-- This is equivalent to the default frontmatter function.
		local out = { id = note.id, aliases = note.aliases, tags = note.tags }
		-- `note.metadata` contains any manually added fields in the frontmatter.
		-- So here we just make sure those fields are kept in the frontmatter.
		if note.metadata ~= nil and require("obsidian").util.table_length(note.metadata) > 0 then
			for k, v in pairs(note.metadata) do
				out[k] = v
			end
		end
		return out
	end,

	-- Optional, for templates (see below).
	templates = {
		subdir = "templates",
		date_format = "%Y-%m-%d",
		time_format = "%H:%M",
	},

	-- Optional, by default when you use `:ObsidianFollowLink` on a link to an external
	follow_url_func = function(url)
		-- Open the URL in the default web browser.
		vim.fn.jobstart({ "open", url }) -- Mac OS
	end,
	wiki_link_func = "use_path_only",
	picker = {
		-- Set your preferred picker. Can be one of 'telescope.nvim', 'fzf-lua', or 'mini.pick'.
		name = "telescope.nvim",
		-- Optional, configure key mappings for the picker. These are the defaults.
		-- Not all pickers support all mappings.
		mappings = {
			-- Create a new note from your query.
			new = "<C-x>",
			-- Insert a link to the selected note.
			insert_link = "<C-l>",
		},
	},
	sort_by = "modified",
	sort_reversed = true,
	open_notes_in = "current",
	ui = {
		enable = false,
	},
})

-- Override the 'gf' keymap to utilize Obsidian's search functionality.
local function obsidian_follow_link()
	if require("obsidian").util.cursor_on_markdown_link() then
		return "<cmd>ObsidianFollowLink<CR>"
	else
		return "gf"
	end
end

local Input = require("nui.input")
local event = require("nui.utils.autocmd").event

local popup_options = {
	-- relative = "cursor",
	position = "50%",
	size = "25%",
	border = {
		style = "rounded",
		text = {
			top = "[Note]",
			top_align = "left",
		},
	},
	win_options = {
		winhighlight = "Normal:Normal",
	},
}

-- Create new note
local function obsidian_prompt_new_note()
	local input = Input(popup_options, {
		prompt = "> ",
		default_value = "",
		-- on_close = function()
		--   print("Input closed!")
		-- end,
		on_submit = function(value)
			vim.cmd(":ObsidianNew " .. value)
		end,
		-- on_change = function(value)
		--   print("Value changed: ", value)
		-- end,
	})
	-- mount/open the component
	input:mount()

	-- unmount component when cursor leaves buffer
	input:on(event.BufLeave, function()
		input:unmount()
	end)
end

-- Weekly note
local function obsidian_weekly_note()
	local today = os.time()
	-- Sunday = 1
	local week_days = os.date("*t").wday - 2
	if week_days == -1 then
		week_days = 6
	end
	local day = today - week_days * 24 * 60 * 60
	local date = os.date("%d-%m-%Y", day)
	local subdir = client.dir / client.opts.notes_subdir / "weekly"
	-- if vim.fn.isdirectory(subdir) == 0 then
	--   vim.fn.mkdir(subdir, '')
	-- end

	local title, id, path = client:parse_title_id_path(date, date, subdir)

	if vim.fn.filereadable(path.filename) == 0 then
		local note = client:new_note(date, date, subdir)
		vim.api.nvim_command("e " .. tostring(note.path))
	end

	-- local note = client:new_note(date, date, subdir)
	vim.api.nvim_command("e " .. tostring(path.filename))
end

vim.api.nvim_create_user_command("ObsidianWeekly", obsidian_weekly_note, { nargs = 0 })
--

local function obsidian_previous_weekly_note()
	local today = os.time()
	-- Sunday = 1
	local week_days = os.date("*t").wday - 2
	if week_days == -1 then
		week_days = 6
	end
	local day = today - (week_days + 7) * 24 * 60 * 60
	local date = os.date("%d-%m-%Y", day)
	local subdir = client.dir / client.opts.notes_subdir / "weekly"
	-- if vim.fn.isdirectory(subdir) == 0 then
	--   vim.fn.mkdir(subdir, '')
	-- end
	local note = client:new_note(date, date, subdir)
	vim.api.nvim_command("vs " .. tostring(note.path))
end

vim.keymap.set("n", "<leader>npw", obsidian_previous_weekly_note)
vim.keymap.set("n", "<leader>nd", "<cmd>ObsidianToday<CR>")
vim.keymap.set("n", "<leader>ny", "<cmd>ObsidianYesterday<CR>")
vim.keymap.set("n", "<leader>ng", "<cmd>ObsidianSearch<CR>")
vim.keymap.set("n", "<leader>ns", "<cmd>ObsidianQuickSwitch<CR>")
vim.keymap.set("n", "<leader>nl", "<cmd>ObsidianLink<CR>")
-- vim.keymap.set("n", "<leader>nt", '<cmd>ObsidianTemplate<CR>')
vim.keymap.set("n", "<leader>no", "<cmd>ObsidianLinkNew<CR>")
vim.keymap.set("n", "<leader>nw", obsidian_weekly_note)
vim.keymap.set("n", "<leader>nc", obsidian_prompt_new_note)
vim.keymap.set("n", "gf", obsidian_follow_link, { noremap = false, expr = true })
