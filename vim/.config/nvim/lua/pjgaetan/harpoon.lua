local harpoon = require("harpoon")

-- REQUIRED
harpoon:setup({
	-- Setting up custom behavior for a list named "cmd"
	cmd = {
		-- When you call list:append() this function is called and the return
		-- value will be put in the list at the end.
		--
		-- which means same behavior for prepend except where in the list the
		-- return value is added
		--
		-- @param possible_value string only passed in when you alter the ui manual
		add = function(possible_value)
			-- get the current line idx
			local idx = vim.fn.line(".")

			-- read the current line
			local cmd = vim.api.nvim_buf_get_lines(0, idx - 1, idx, false)[1]
			if cmd == nil then
				return nil
			end

			return {
				value = cmd,
				context = {},
			}
		end,

		--- This function gets invoked with the options being passed in from
		--- list:select(index, <...options...>)
		--- @param list_item {value: any, context: any}
		--- @param list { ... }
		--- @param option any
		select = function(list_item, list, option)
			-- WOAH, IS THIS HTMX LEVEL XSS ATTACK??
			vim.cmd('call VimuxRunCommand("' .. list_item.value .. '")')
		end,
	},
})
-- REQUIRED

vim.keymap.set("n", "<leader>ha", function()
	harpoon:list():append()
end)
vim.keymap.set("n", "<leader>hl", function()
	harpoon.ui:toggle_quick_menu(harpoon:list())
end)

vim.keymap.set("n", "<leader>1", function()
	harpoon:list():select(1)
end)
vim.keymap.set("n", "<leader>2", function()
	harpoon:list():select(2)
end)
vim.keymap.set("n", "<leader>3", function()
	harpoon:list():select(3)
end)
vim.keymap.set("n", "<leader>4", function()
	harpoon:list():select(4)
end)

vim.keymap.set("n", "<leader>ac", function()
	harpoon:list("cmd"):append()
end)

-- harpoon cmd
vim.keymap.set("n", "<leader>vc", function()
	harpoon.ui:toggle_quick_menu(harpoon:list("cmd"))
end)
vim.keymap.set("n", "<leader>c1", function()
	harpoon:list("cmd"):select(1)
end)
vim.keymap.set("n", "<leader>c2", function()
	harpoon:list("cmd"):select(2)
end)
vim.keymap.set("n", "<leader>c3", function()
	harpoon:list("cmd"):select(3)
end)
