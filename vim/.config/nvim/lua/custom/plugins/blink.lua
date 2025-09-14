-- return {
-- 	"hrsh7th/nvim-cmp",
-- 	dependencies = {
-- 		"hrsh7th/cmp-nvim-lsp",
-- 		"L3MON4D3/LuaSnip",
-- 		"saadparwaiz1/cmp_luasnip",
-- 		"hrsh7th/cmp-buffer",
-- 		"hrsh7th/cmp-path",
-- 		"folke/lazydev.nvim",
-- 		"github/copilot.vim",
-- 	},
-- 	config = function()
-- 		require("pjgaetan.cmp")
-- 	end,
-- }
return {
	"saghen/blink.cmp",
	-- optional: provides snippets for the snippet source
	-- dependencies = { 'rafamadriz/friendly-snippets' },
	-- dependencies = { "fang2hou/blink-copilot" },

	version = "1.*",

	opts = {
		-- 'default' (recommended) for mappings similar to built-in completions (C-y to accept)
		--
		-- All presets have the following mappings:
		-- C-space: Open menu or open docs if already open
		-- C-n/C-p or Up/Down: Select next/previous item
		-- C-e: Hide menu
		-- C-k: Toggle signature help (if signature.enabled = true)
		--
		-- See :h blink-cmp-config-keymap for defining your own keymap
		keymap = { preset = "default" },
		completion = {
			documentation = { auto_show = true },
			menu = {

				draw = {
					columns = {
						-- { "source_name" },
						{ "kind_icon" },
						{ "label", "label_description" },
					},
				},
			},
		},
		enabled = function()
			-- Disable completion in markdown files
			if vim.bo.filetype == "org-roam-select" then
				return false
			end
			if vim.bo.filetype == "ledger" then
				return false
			end
			-- Enable for all other filetypes
			return true
		end,

		sources = {
			default = { "lsp", "path", "snippets", "buffer" },
			providers = {
				-- defaults to `{ 'buffer' }`
				lsp = { fallbacks = {} },
				orgmode = {
					name = "Orgmode",
					module = "orgmode.org.autocompletion.blink",
					fallbacks = {},
				},
			},
			per_filetype = {
				org = { "orgmode" },
			},
		},
	},
	opts_extend = { "sources.default" },
}
