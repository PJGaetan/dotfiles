return {
	{
		"github/copilot.vim",
		-- cmd = "Copilot",
		-- event = "BufWinEnter",
		lazy = false,
		-- init = function()
		-- 	vim.g.copilot_no_maps = true
		-- end,
		config = function()
			-- deactivate copilot in certain filetypes
			vim.g.copilot_filetypes = {
				-- disable rust
				rust = false,
			}
			vim.api.nvim_create_autocmd("User", {
				pattern = "BlinkCmpMenuOpen",
				callback = function()
					vim.b.copilot_suggestion_hidden = true
				end,
			})

			vim.api.nvim_create_autocmd("User", {
				pattern = "BlinkCmpMenuClose",
				callback = function()
					vim.b.copilot_suggestion_hidden = false
				end,
			})
		end,
	},
	-- {
	-- 	"CopilotC-Nvim/CopilotChat.nvim",
	-- 	dependencies = {
	-- 		{
	-- 			"github/copilot.vim",
	-- 			config = function()
	-- 				vim.keymap.set("i", "<C-y>", 'copilot#Accept("")', {
	-- 					expr = true,
	-- 					replace_keycodes = false,
	-- 				})
	-- 				vim.g.copilot_no_tab_map = true
	-- 			end,
	-- 			lazy = false,
	-- 		},
	-- 		{ "nvim-lua/plenary.nvim" },
	-- 	},
	-- 	build = "make tiktoken",
	-- 	opts = {
	-- 		-- See Configuration section for options
	-- 	},
	-- 	-- See Commands section for default commands if you want to lazy load on them
	-- 	keys = {
	-- 		{ "<leader>cc", "<cmd>CopilotChatToggle<cr>", desc = "Copilot Chat" },
	-- 	},
	-- 	config = {
	-- 		mappings = {
	-- 			reset = {
	-- 				normal = "<C-x>",
	-- 			},
	-- 		},
	-- 	},
	-- },
}
