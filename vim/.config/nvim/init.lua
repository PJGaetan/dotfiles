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
	-- Package manager
	"wbthomason/packer.nvim",
	--
	-- Useful status updates for LSP
	{ "j-hui/fidget.nvim", version = "legacy" },

	{
		-- LSP Configuration & Plugins
		"neovim/nvim-lspconfig",
		dependencies = {
			-- Automatically install LSPs to stdpath for neovim
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",

			-- Additional lua configuration, makes nvim stuff amazing
			"folke/neodev.nvim",
		},
	},

	{
		-- Autocompletion
		"hrsh7th/nvim-cmp",
		dependencies = { "hrsh7th/cmp-nvim-lsp", "L3MON4D3/LuaSnip", "saadparwaiz1/cmp_luasnip" },
	},

	{
		-- Highlight, edit, and navigate code
		"nvim-treesitter/nvim-treesitter",
		dependencies = {
			"nvim-treesitter/nvim-treesitter-textobjects",
		},
		build = ":TSUpdate",
	},
	"vrischmann/tree-sitter-templ",

	{
		-- Additional text objects via treesitter
		"nvim-treesitter/nvim-treesitter-textobjects",
		after = "nvim-treesitter",
	},

	"dhruvasagar/vim-table-mode",

	-- code prediction a la copilote
	{ "Exafunction/codeium.vim" },

	-- null-ls for formatting
	{ "nvimtools/none-ls.nvim" },

	-- send cmd from vim to tmux
	{ "preservim/vimux" },

	-- install without yarn or npm
	-- mardown open in split browser
	{
		"iamcco/markdown-preview.nvim",
		run = function()
			vim.fn["mkdp#util#install"]()
		end,
	},

	"itchyny/calendar.vim",
	"epwalsh/obsidian.nvim",
	"MunifTanjim/nui.nvim",

	-- dap nvim
	"mfussenegger/nvim-dap",
	"leoluz/nvim-dap-go",
	"rcarriga/nvim-dap-ui",

	-- Git related plugins
	"tpope/vim-fugitive",
	"tpope/vim-rhubarb",
	"lewis6991/gitsigns.nvim",

	-- vim save sessions
	"tpope/vim-obsession",

	{ "Mofiqul/dracula.nvim", lazy = false },
	"nvim-lualine/lualine.nvim",
	-- Add indentation guides even on blank lines
	"lukas-reineke/indent-blankline.nvim",
	-- "gc" to comment visual regions/lines
	"numToStr/Comment.nvim",
	-- Detect tabstop and shiftwidth automatically
	"tpope/vim-sleuth",
	"tpope/vim-unimpaired",

	-- Fuzzy Finder (files, lsp, etc)
	{ "nvim-telescope/telescope.nvim", branch = "0.1.x", dependencies = { "nvim-lua/plenary.nvim" } },

	-- Fuzzy Finder Algorithm which dependencies local dependencies to be built. Only load if `make` is available
	{ "nvim-telescope/telescope-fzf-native.nvim", build = "make", cond = vim.fn.executable("make") == 1 },

	-- Icone in file browser
	"nvim-tree/nvim-web-devicons",
	"stevearc/oil.nvim",

	-- dbt nvim
	{
		"PedramNavid/dbtpal",
		dependencies = { { "nvim-lua/plenary.nvim" }, { "nvim-telescope/telescope.nvim" } },
	},

	-- vim tmux
	-- use { 'alexghergh/nvim-tmux-navigation' }
	{ "mrjones2014/smart-splits.nvim" },

	-- vim git workfile
	{ "cljoly/telescope-repo.nvim" },
	{ "airblade/vim-rooter" },
	{ "ThePrimeagen/git-worktree.nvim" },

	-- harpoon
	{
		"ThePrimeagen/harpoon",
		branch = "harpoon2",
		dependencies = { { "nvim-lua/plenary.nvim" } },
	},

	-- vim wiki
	{ "lervag/wiki.vim" },
	{ "lervag/wiki-ft.vim" },
	{ "opdavies/toggle-checkbox.nvim" },
	{ "startup-nvim/startup.nvim", dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" } },

	-- gitmoji
	{ "olacin/telescope-gitmoji.nvim" },
	"Kachyz/vim-gitmoji",

	{ "princejoogie/dir-telescope.nvim" },
	{ "https://codeberg.org/esensar/nvim-dev-container" },

	-- context above functions
	{ "nvim-treesitter/nvim-treesitter-context" },

	-- <leader>z for full screen
	{ "troydm/zoomwintab.vim" },

	-- allow number when wnidws not in focus
	{ "jeffkreeftmeijer/vim-numbertoggle" },
}, {
	dev = {
		---@type string | fun(plugin: LazyPlugin): string directory where you store your local plugin projects
		path = "~/.config/nvim/lua/custom/plugins.lua",
	},
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

-- Set completeopt to have a better completion experience
vim.o.completeopt = "menuone,noselect"

-- <C-X><C-U> to display emoji helper
vim.o.completefunc = "emoji#complete"

-- Keymaps for better default experience
-- See `:help vim.keymap.set()`
vim.keymap.set({ "n", "v" }, "<Space>", "<Nop>", { silent = true })

-- Remap for dealing with word wrap
vim.keymap.set("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- [[ startup.nvim config ]]
-- require("startup").setup { theme = "startify" }
-- vim.g.startup_bookmarks = {
--   ["C"] = '~/dotfiles/vim/.config/nvim/init.lua',
-- }

require("pjgaetan.layout")

-- calendar config
vim.g.calendar_google_calendar = 1
vim.g.calendar_google_task = 1
vim.cmd("source ~/.cache/calendar.vim/credentials.vim")
vim.keymap.set(
	"n",
	"<leader>cl",
	'<cmd>Calendar -first_day=monday -view=week -date_endian=big -date_separator="-"<CR> '
)

require("pjgaetan.dbt")
--
-- Only cd current buffer instead of the whole editor
vim.g.rooter_cd_cmd = "lcd"

-- using oil instead
-- vim.keymap.set("n", "<leader>da", "<cmd>Lexplore<CR>")

require("pjgaetan.tmux-vim")

vim.keymap.set("n", "<leader>z", "<cmd>ZoomWinTabToggle<CR>")

-- codeium configuration
vim.g.codeium_manual = false
vim.keymap.set("i", "\t", function()
	return vim.fn["codeium#Accept"]()
end, { expr = true })

vim.keymap.set("n", "<leader>tc", function()
	return vim.fn["codeium#CodeiumToggle"]()
end)

vim.g.codeium_filetypes = {
	lua = true,
	markdown = false,
	json = false,
	rust = false,
	python = true,
	javascript = true,
}

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
		lualine_b = { "diff", "diagnostics" },
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
		lualine_y = { codeium_status_line, "selectioncount", "searchcount" },
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

-- Enable Comment.nvim
require("Comment").setup()
local ft = require("Comment.ft")
ft
	-- Or set both line and block commentstring
	.set("sql", { "--%s", "--%s" })
	.set("templ", { "<!-- %s -->", "<!-- %s -->" })

-- Vim wiki setup
vim.g.wiki_root = "~/wiki"
vim.cmd([[
let g:wiki_filetypes = ['md', 'wiki']
]])

-- Toggle checkbox
vim.keymap.set("n", "<leader><leader>t", require("toggle-checkbox").toggle)

-- Enable `lukas-reineke/indent-blankline.nvim`
-- See `:help indent_blankline.txt`
require("ibl").setup({
	indent = {
		char = "┊",
	},
})

require("nvim-web-devicons").setup({})
require("oil").setup({
	columns = {
		-- "icon",
		-- "type",
		-- "permissions",
		-- "size",
		-- "mtime",
	},
	view_options = {
		-- Show files and directories that start with "."
		show_hidden = true,
	},
})

vim.keymap.set("n", "<leader>fe", require("oil").toggle_float)

require("treesitter-context").setup({
	multiline_threshold = 3, -- Maximum number of lines to show for a single context
})

require("pjgaetan.obsidian")
require("pjgaetan.git")
require("pjgaetan.telescope")
require("pjgaetan.treesitter")
require("pjgaetan.harpoon")

require("devcontainer").setup({})

-- Setup neovim lua configuration
require("neodev").setup()
--
require("pjgaetan.lsp")

require("pjgaetan.format")
require("pjgaetan.dap")

-- Turn on lsp status information
require("fidget").setup()

require("pjgaetan.cmp")
-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
