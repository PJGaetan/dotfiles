return {
	{
		"tpope/vim-fugitive",
		cmd = {
			"Git",
			"G",
			"GBrowse",
			"Gdiffsplit",
			"Gclog",
		},
		config = function()
			-- git remap
			vim.keymap.set("n", "<leader>gs", "<cmd>Git<CR>")
			vim.keymap.set("n", "<leader>gd", "<cmd>0Gclog<CR>")
			vim.keymap.set("n", "go", "<cmd>GBrowse<CR>")
		end,
	},
	"tpope/vim-rhubarb",
	"shumphrey/fugitive-gitlab.vim",

	{
		"lewis6991/gitsigns.nvim",
		config = function()
			-- Gitsigns
			-- See `:help gitsigns.txt`
			require("gitsigns").setup({
				signs = {
					add = { text = "+" },
					change = { text = "~" },
					delete = { text = "_" },
					topdelete = { text = "‾" },
					changedelete = { text = "~" },
				},
			})

			vim.keymap.set("v", "<leader>ga", function()
				require("gitsigns").stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
			end)
			vim.keymap.set("v", "<leader>gr", function()
				require("gitsigns").reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
			end)

			vim.keymap.set("n", "<leader>gp", require("gitsigns").preview_hunk_inline)
			vim.keymap.set("n", "<leader>ga", require("gitsigns").stage_hunk)
			vim.keymap.set("n", "<leader>gr", require("gitsigns").reset_hunk)
		end,
	},
	{
		"ThePrimeagen/git-worktree.nvim",
		config = function()
			require("git-worktree").setup()
			require("telescope").load_extension("git_worktree")
			-- git worktree
			vim.keymap.set("n", "<leader>gw", require("telescope").extensions.git_worktree.git_worktrees)
			vim.keymap.set("n", "<leader>gcw",
				require("telescope").extensions.git_worktree.create_git_worktree)
		end,
		dependencies = { "nvim-telescope/telescope.nvim" },
	},
	"Kachyz/vim-gitmoji",
	{
		"harrisoncramer/gitlab.nvim",
		dependencies = {
			"MunifTanjim/nui.nvim",
			"nvim-lua/plenary.nvim",
			"sindrets/diffview.nvim",
			"stevearc/dressing.nvim", -- Recommended but not required. Better UI for pickers.
			"nvim-tree/nvim-web-devicons", -- Recommended but not required. Icons in discussion tree.
		},
		enabled = true,
		build = function()
			require("gitlab.server").build(true)
		end, -- Builds the Go binary
		config = function()
			require("gitlab").setup({
				config_path = vim.fn.expand("~/.env/"),
			})
		end,
	},
}
