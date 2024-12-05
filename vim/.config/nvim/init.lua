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

	-- "itchyny/calendar.vim",
	"MunifTanjim/nui.nvim",

	-- lookmlw
	{ "chrismaher/vim-lookml" },

	--django
	{ "tweekmonster/django-plus.vim" },

	-- quickfix
	{
		"stevearc/quicker.nvim",
		event = "FileType qf",
		---@module "quicker"
		---@type quicker.SetupOptions
		opts = {},
		config = function(_, opts)
			require("quicker").setup(opts)
		end,
	},

	-- startuptime
	{ "dstein64/vim-startuptime" },

	-- vim save sessions
	"tpope/vim-obsession",
	{
		"folke/lazydev.nvim",
		ft = "lua",
		lazy = true,
		opts = {
			library = {
				-- See the configuration section for more details
				-- Load luvit types when the `vim.uv` word is found
				{ path = "luvit-meta/library", words = { "vim%.uv" } },
			},
		},
	},
	{ "Bilal2453/luvit-meta", lazy = true }, -- optional `vim.uv` typings

	-- consider switching to this : https://github.com/binhtran432k/dracula.nvim?tab=readme-ov-file
	-- borderless telescope
	-- { "Mofiqul/dracula.nvim", lazy = false },
	{ "binhtran432k/dracula.nvim", lazy = false },
	-- { "cocopon/iceberg.vim", lazy = false },
	-- Add indentation guides even on blank lines
	"lukas-reineke/indent-blankline.nvim",
	-- Detect tabstop and shiftwidth automatically
	"tpope/vim-sleuth",
	"tpope/vim-unimpaired",

	-- vim git workfile
	-- { "airblade/vim-rooter" },

	-- <leader>z for full screen
	{ "troydm/zoomwintab.vim" },

	-- I have to install rust plugin to get formatting
	{ "rust-lang/rust.vim" },
	{ "norcalli/nvim-colorizer.lua" },

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
		-- colorscheme = { "dracula" },
	},
	change_detection = {
		notify = false,
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

local toggle_relative_number = function()
	vim.wo.relativenumber = not vim.wo.relativenumber
end

vim.keymap.set("n", "<leader>rl", toggle_relative_number)

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

-- vim.o.conceallevel = 1

-- Set colorscheme
vim.o.termguicolors = true

local dracula = require("dracula")
dracula.setup({
	style = "default",
	transparent = true,
	styles = {
		comments = { italic = false },
		keywords = { italic = false },
		sidebars = "dark",
		floats = "dark",
	},
	sidebars = { "qf", "help" },
	on_colors = function() end,
	on_highlights = function() end,
	use_background = true,

	-- Way to mess with Telescope

	-- local colors = require("catppuccin.palettes").get_palette()
	-- local TelescopeColor = {
	--   TelescopeMatching = { fg = colors.flamingo },
	--   TelescopeSelection = { fg = colors.text, bg = colors.surface0, bold = true },
	--
	--   TelescopePromptPrefix = { bg = colors.surface0 },
	--   TelescopePromptNormal = { bg = colors.surface0 },
	--   TelescopeResultsNormal = { bg = colors.mantle },
	--   TelescopePreviewNormal = { bg = colors.mantle },
	--   TelescopePromptBorder = { bg = colors.surface0, fg = colors.surface0 },
	--   TelescopeResultsBorder = { bg = colors.mantle, fg = colors.mantle },
	--   TelescopePreviewBorder = { bg = colors.mantle, fg = colors.mantle },
	--   TelescopePromptTitle = { bg = colors.pink, fg = colors.mantle },
	--   TelescopeResultsTitle = { fg = colors.mantle },
	--   TelescopePreviewTitle = { bg = colors.green, fg = colors.mantle },
	-- }
	--
	-- for hl, col in pairs(TelescopeColor) do
	--   vim.api.nvim_set_hl(0, hl, col)
	-- end
	-- on_highlights = function(hl, c)
	--   local prompt = c.darker_bg
	--   hl.TelescopeNormal = {
	--     bg = c.dark_bg,
	--     fg = c.dark_fg,
	--   }
	--   hl.TelescopeBorder = {
	--     bg = c.dark_bg,
	--     fg = c.dark_bg,
	--   }
	--   hl.TelescopePromptNormal = {
	--     bg = prompt,
	--   }
	--   hl.TelescopePromptBorder = {
	--     bg = prompt,
	--     fg = prompt,
	--   }
	--   hl.TelescopePromptTitle = {
	--     bg = prompt,
	--     fg = prompt,
	--   }
	--   hl.TelescopePreviewTitle = {
	--     bg = c.dark_bg,
	--     fg = c.dark_bg,
	--   }
	--   hl.TelescopeResultsTitle = {
	--     bg = c.dark_bg,
	--     fg = c.dark_bg,
	--   }
	-- end,
})

vim.cmd([[colorscheme dracula]])

-- folding
vim.g.lookml_foldlevel = 0

-- vim.o.foldmethod = "indent"
-- config rust auto fmt
vim.g.rustfmt_autosave = 1

-- Keymaps for better default experience
-- See `:help vim.keymap.set()`
vim.keymap.set({ "n", "v" }, "<Space>", "<Nop>", { silent = true })

-- Remap for dealing with word wrap
vim.keymap.set("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- remap for copy to clipboard
vim.keymap.set({ "n", "v" }, "<leader>y", '"+y')
vim.keymap.set("n", "<leader>Y", '"+Y')

-- open browser CMD
vim.api.nvim_create_user_command("Browse", function(opts)
	vim.fn.system({ "open", opts.fargs[1] })
end, { nargs = 1 })

-- calendar config
-- vim.g.calendar_google_calendar = 1
-- vim.g.calendar_google_task = 1
-- vim.cmd("source ~/.cache/calendar.vim/credentials.vim")
-- vim.keymap.set(
--   "n",
--   "<leader>cl",
--   '<cmd>Calendar -first_day=monday -view=week -date_endian=big -date_separator="-"<CR> '
-- )
--
-- Only cd current buffer instead of the whole editor
-- vim.g.rooter_cd_cmd = "lcd"

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

local function llm_status_line()
	return vim.fn["copilot#status"]()
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
		-- theme = "dracula-nvim",
		theme = "dracula",
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
		lualine_y = { llm_status_line, "overseer", "selectioncount", "searchcount" },
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

require("colorizer").setup()

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
