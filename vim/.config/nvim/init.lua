-- Install packer
local install_path = vim.fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
local is_bootstrap = false
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
	is_bootstrap = true
	vim.fn.system({ "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path })
	vim.cmd([[packadd packer.nvim]])
end

require("packer").startup(function(use)
	-- Package manager
	use("wbthomason/packer.nvim")
	--
	-- Useful status updates for LSP
	use({ "j-hui/fidget.nvim", tag = "legacy" })

	use({
		-- LSP Configuration & Plugins
		"neovim/nvim-lspconfig",
		requires = {
			-- Automatically install LSPs to stdpath for neovim
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",

			-- Additional lua configuration, makes nvim stuff amazing
			"folke/neodev.nvim",
		},
	})

	use({
		-- Autocompletion
		"hrsh7th/nvim-cmp",
		requires = { "hrsh7th/cmp-nvim-lsp", "L3MON4D3/LuaSnip", "saadparwaiz1/cmp_luasnip" },
	})

	use({
		-- Highlight, edit, and navigate code
		"nvim-treesitter/nvim-treesitter",
		run = function()
			pcall(require("nvim-treesitter.install").update({ with_sync = true }))
		end,
	})
	use("vrischmann/tree-sitter-templ")

	use({
		-- Additional text objects via treesitter
		"nvim-treesitter/nvim-treesitter-textobjects",
		after = "nvim-treesitter",
	})

	use("dhruvasagar/vim-table-mode")

	-- code prediction a la copilote
	use({ "Exafunction/codeium.vim" })

	-- null-ls for formatting
	use({ "nvimtools/none-ls.nvim" })

	-- send cmd from vim to tmux
	use({ "preservim/vimux" })

	-- install without yarn or npm
	-- mardown open in split browser
	use({
		"iamcco/markdown-preview.nvim",
		run = function()
			vim.fn["mkdp#util#install"]()
		end,
	})

	use("itchyny/calendar.vim")
	use("epwalsh/obsidian.nvim")
	use("MunifTanjim/nui.nvim")

	-- dap nvim
	use("mfussenegger/nvim-dap")
	use("leoluz/nvim-dap-go")
	use("rcarriga/nvim-dap-ui")

	-- Git related plugins
	use("tpope/vim-fugitive")
	use("tpope/vim-rhubarb")
	use("lewis6991/gitsigns.nvim")

	-- vim save sessions
	use("tpope/vim-obsession")

	use("Mofiqul/dracula.nvim") -- Draculq theme
	use("nvim-lualine/lualine.nvim") -- Fancier statusline
	use("lukas-reineke/indent-blankline.nvim") -- Add indentation guides even on blank lines
	use("numToStr/Comment.nvim") -- "gc" to comment visual regions/lines
	use("tpope/vim-sleuth") -- Detect tabstop and shiftwidth automatically
	use("tpope/vim-unimpaired") -- Detect tabstop and shiftwidth automatically

	-- Fuzzy Finder (files, lsp, etc)
	use({ "nvim-telescope/telescope.nvim", branch = "0.1.x", requires = { "nvim-lua/plenary.nvim" } })

	-- Fuzzy Finder Algorithm which requires local dependencies to be built. Only load if `make` is available
	use({ "nvim-telescope/telescope-fzf-native.nvim", run = "make", cond = vim.fn.executable("make") == 1 })

	-- Icone in file browser
	use("nvim-tree/nvim-web-devicons")
	use("stevearc/oil.nvim")

	-- dbt nvim
	use({ "PedramNavid/dbtpal", requires = { { "nvim-lua/plenary.nvim" }, { "nvim-telescope/telescope.nvim" } } })

	-- vim tmux
	-- use { 'alexghergh/nvim-tmux-navigation' }
	use({ "mrjones2014/smart-splits.nvim" })

	-- vim git workfile
	use({ "cljoly/telescope-repo.nvim" })
	use({ "airblade/vim-rooter" })
	use({ "ThePrimeagen/git-worktree.nvim" })

	-- harpoon
	use({
		"ThePrimeagen/harpoon",
		branch = "harpoon2",
		requires = { { "nvim-lua/plenary.nvim" } },
	})

	-- vim wiki
	use({ "lervag/wiki.vim" })
	use({ "lervag/wiki-ft.vim" })
	use({ "opdavies/toggle-checkbox.nvim" })

	use({ "startup-nvim/startup.nvim", requires = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" } })

	-- gitmoji
	use({ "olacin/telescope-gitmoji.nvim" })
	use("Kachyz/vim-gitmoji")

	use({ "princejoogie/dir-telescope.nvim" })
	use({ "https://codeberg.org/esensar/nvim-dev-container" })

	-- context above functions
	use({ "nvim-treesitter/nvim-treesitter-context" })

	-- <leader>z for full screen
	use({ "troydm/zoomwintab.vim" })

	-- allow number when wnidws not in focus
	use({ "jeffkreeftmeijer/vim-numbertoggle" })

	-- Add custom plugins to packer from ~/.config/nvim/lua/custom/plugins.lua
	local has_plugins, plugins = pcall(require, "custom.plugins")
	if has_plugins then
		plugins(use)
	end

	if is_bootstrap then
		require("packer").sync()
	end
end)

-- When we are bootstrapping a configuration, it doesn't
-- make sense to execute the rest of the init.lua.
--
-- You'll need to restart nvim, and then it will work.
if is_bootstrap then
	print("==================================")
	print("    Plugins are being installed")
	print("    Wait until Packer completes,")
	print("       then restart nvim")
	print("==================================")
	return
end

-- Automatically source and re-compile packer whenever you save this init.lua
local packer_group = vim.api.nvim_create_augroup("Packer", { clear = true })
vim.api.nvim_create_autocmd("BufWritePost", {
	command = "source <afile> | silent! LspStop | silent! LspStart | PackerCompile",
	group = packer_group,
	pattern = vim.fn.expand("$MYVIMRC"),
})

-- [[ Setting options ]]
-- See `:help vim.o`

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

-- [[ Basic Keymaps ]]
-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are required (otherwise wrong leader will be used)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

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

vim.g.codeium_filetypes = {
	markdown = false,
	json = false,
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
