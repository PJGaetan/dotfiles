return {
	{
		"CopilotC-Nvim/CopilotChat.nvim",
		dependencies = {
			{ "github/copilot.vim" },
			{ "nvim-lua/plenary.nvim" },
		},
		build = "make tiktoken",
		opts = {
			-- See Configuration section for options
		},
		-- See Commands section for default commands if you want to lazy load on them
		keys = {
			{ "<leader>cc", "<cmd>CopilotChatToggle<cr>", desc = "Copilot Chat" },
		},
		config = {
			mappings = {
				reset = {
					normal = "<C-x>",
				},
			},
		},
	},
}
