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
		lazy = true,
		config = function()
			-- git remap
			vim.keymap.set("n", "<leader>gs", "<cmd>Git<CR>")
			vim.keymap.set("n", "<leader>gd", "<cmd>0Gclog<CR>")
			vim.keymap.set("n", "<leader>gb", "<cmd>GBrowse<CR>")
			vim.keymap.set("n", "<leader>gbl", "<cmd>GBrowse!<CR>")
			vim.keymap.set("v", "<leader>gbl", ":GBrowse!<CR>")
		end,
	},
	"tpope/vim-rhubarb",
	"shumphrey/fugitive-gitlab.vim",
	{
		"akinsho/git-conflict.nvim",
		version = "1.3.0",
		dependencies = {
			"binhtran432k/dracula.nvim",
			{ "tpope/vim-fugitive", lazy = true },
		},
		config = function()
			require("git-conflict").setup({
				default_mappings = false, -- disable buffer local mapping created by this plugin
				default_commands = true, -- disable commands created by this plugin
				disable_diagnostics = false, -- This will disable the diagnostics in a buffer whilst it is conflicted
				list_opener = "copen", -- command or function to open the conflicts list
				highlights = { -- They must have background color, otherwise the default color will be used
					incoming = "diffChange",
					current = "diffAdd",
				},
			})
			vim.keymap.set("n", "co", "<Plug>(git-conflict-ours)")
			vim.keymap.set("n", "ct", "<Plug>(git-conflict-theirs)")
			vim.keymap.set("n", "cb", "<Plug>(git-conflict-both)")
			vim.keymap.set("n", "c0", "<Plug>(git-conflict-none)")
			vim.keymap.set("n", "<leader>cl", "<cmd>Git mergetool<CR>")
		end,
	},

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
		lazy = true,
		keymap = {
			["<leader>gw"] = "<cmd>lua require('telescope').extensions.git_worktree.git_worktrees()<cr>",
			["<leader>gcw"] = "<cmd>lua require('telescope').extensions.git_worktree.create_git_worktree()<cr>",
		},
		config = function()
			require("git-worktree").setup()
			require("telescope").load_extension("git_worktree")
			-- git worktree
			-- vim.keymap.set("n", "<leader>gw", require("telescope").extensions.git_worktree.git_worktrees)
			-- vim.keymap.set("n", "<leader>gcw", require("telescope").extensions.git_worktree.create_git_worktree)
		end,
		dependencies = { "nvim-telescope/telescope.nvim", lazy = true },
	},
	"Kachyz/vim-gitmoji",
	{
		"harrisoncramer/gitlab.nvim",
		lazy = true,
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
