return {
	"stevearc/oil.nvim",
	dependencies = {
		{
			"MagicDuck/grug-far.nvim",
			ft = { "oil" },
		},
	},
	config = function()
		local oil = require("oil")
		oil.setup({
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
			keymaps = {
				["<C-h>"] = false,
				-- create a new mapping, gs, to search and replace in the current directory
				gs = {
					callback = function()
						-- get the current directory
						local prefills = { paths = oil.get_current_dir() }

						local grug_far = require("grug-far")
						-- instance check
						if not grug_far.has_instance("explorer") then
							grug_far.open({
								instanceName = "explorer",
								prefills = prefills,
								staticTitle = "Find and Replace from Explorer",
							})
						else
							grug_far.open_instance("explorer")
							-- updating the prefills without clearing the search and other fields
							grug_far.update_instance_prefills("explorer", prefills, false)
						end
					end,
					desc = "oil: Search in directory",
				},
			},
		})

		vim.keymap.set("n", "<leader>fe", require("oil").toggle_float)
		vim.keymap.set("n", "-", "<cmd>Oil<CR>", { desc = "Open parent directory" })
	end,
}
