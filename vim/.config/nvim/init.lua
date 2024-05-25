-- Install lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)
--
-- [[ Basic Keymaps ]]
-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are required (otherwise wrong leader will be used)
-- Make sure to set `mapleader` before lazy so your mappings are correct
vim.g.mapleader = " "
vim.g.maplocalleader = " "

require("lazy").setup({
	"stevearc/dressing.nvim",
	--
	-- Useful status updates for LSP
	"nvim-lualine/lualine.nvim",
	{
		"j-hui/fidget.nvim",
		version = "legacy",
		config = function()
			-- Turn on lsp status information
			require("fidget").setup({})
		end,
	},

	-- install without yarn or npm
	-- mardown open in split browser

	"itchyny/calendar.vim",
	"MunifTanjim/nui.nvim",

	-- vim save sessions
	"tpope/vim-obsession",

	-- consider switching to this : https://github.com/binhtran432k/dracula.nvim?tab=readme-ov-file
	-- borderless telescope
	{ "Mofiqul/dracula.nvim", lazy = false },
	{ "cocopon/iceberg.vim", lazy = false },
	-- Add indentation guides even on blank lines
	"lukas-reineke/indent-blankline.nvim",
	-- Detect tabstop and shiftwidth automatically
	"tpope/vim-sleuth",
	"tpope/vim-unimpaired",

	-- vim git workfile
	{ "airblade/vim-rooter" },

	-- <leader>z for full screen
	{ "troydm/zoomwintab.vim" },

	-- I have to install rust plugin to get formatting
	{ "rust-lang/rust.vim" },

	-- allow number when wnidws not in focus
	-- { "jeffkreeftmeijer/vim-numbertoggle" },
	{ import = "custom/plugins" },
}, {
	-- dev = {
	--   ---@type string | fun(plugin: LazyPlugin): string directory where you store your local plugin projects
	--   path = "~/.config/nvim/lua/custom/plugins.lua",
	-- },
	install = {
		-- try to load one of these colorschemes when starting an installation during startup
		colorscheme = { "dracula" },
	},
	ui = {
		icons = {
			cmd = "⌘",
			config = "🛠",
			event = "📅",
			ft = "📂",
			init = "⚙",
			keys = "🗝",
			plugin = "🔌",
			runtime = "💻",
			require = "🌙",
			source = "📄",
			start = "🚀",
			task = "📌",
			lazy = "💤 ",
		},
	},
})

-- Set highlight on search
vim.o.hlsearch = true
vim.o.redrawtime = 10000
-- Remove highlight after search by pressing Esc
vim.keymap.set({ "n" }, "<Esc>", "<Esc>:nohlsearch<CR>", { silent = true })

-- Make line numbers default
vim.wo.number = true
vim.wo.relativenumber = true

-- Enable mouse mode
vim.o.mouse = "a"

-- Enable break indent
vim.o.breakindent = true

-- Save undo history
vim.o.undofile = true

-- Case insensitive searching UNLESS /C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true

-- Decrease update time
vim.o.updatetime = 250
vim.wo.signcolumn = "yes"

-- Set colorscheme
vim.o.termguicolors = true
vim.cmd([[colorscheme dracula]])

-- config rust auto fmt
vim.g.rustfmt_autosave = 1

-- Keymaps for better default experience
-- See `:help vim.keymap.set()`
vim.keymap.set({ "n", "v" }, "<Space>", "<Nop>", { silent = true })

-- Remap for dealing with word wrap
vim.keymap.set("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- open browser CMD
vim.api.nvim_create_user_command("Browse", function(opts)
	vim.fn.system({ "open", opts.fargs[1] })
end, { nargs = 1 })

-- calendar config
vim.g.calendar_google_calendar = 1
vim.g.calendar_google_task = 1
vim.cmd("source ~/.cache/calendar.vim/credentials.vim")
vim.keymap.set(
	"n",
	"<leader>cl",
	'<cmd>Calendar -first_day=monday -view=week -date_endian=big -date_separator="-"<CR> '
)

-- Only cd current buffer instead of the whole editor
vim.g.rooter_cd_cmd = "lcd"

vim.keymap.set("n", "<leader>z", "<cmd>ZoomWinTabToggle<CR>")

-- [[ Highlight on yank ]]
-- See `:help vim.highlight.on_yank()`
local highlight_group = vim.api.nvim_create_augroup("YankHighlight", { clear = true })
vim.api.nvim_create_autocmd("TextYankPost", {
	callback = function()
		vim.highlight.on_yank()
	end,
	group = highlight_group,
	pattern = "*",
})

local function codeium_status_line()
	return vim.fn["codeium#GetStatusString"]()
end

-- Enable `lukas-reineke/indent-blankline.nvim`
-- See `:help indent_blankline.txt`
require("ibl").setup({
	indent = {
		char = "┊",
	},
})
--

-- Set lualine as statusline
-- See `:help lualine.txt`
require("lualine").setup({
	extensions = {},
	options = {
		icons_enabled = false,
		theme = "dracula-nvim",
		component_separators = "|",
		section_separators = "",
	},
	sections = {
		lualine_b = { "grapple", "diff", "diagnostics" },
		lualine_c = {
			{
				"filename",
				file_status = true,
				newfile_status = false,
				path = 4, -- 4: Filename and parent dir, with tilde as the home directory
				shorting_target = 40,

				symbols = {
					readonly = "[-]",
					unnamed = "[No Name]",
					newfile = "[New]",
				},
			},
		},
		lualine_y = { codeium_status_line, "overseer", "selectioncount", "searchcount" },
	},
	inactive_sections = {
		lualine_c = {
			{
				"filename",
				path = 1, -- 1: Relative path
				shorting_target = 40,
			},
		},
	},
})

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
