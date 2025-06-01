-- Set completeopt to have a better completion experience
vim.o.completeopt = "menu,menuone,noselect"

-- <C-X><C-U> to display emoji helper
vim.o.completefunc = "emoji#complete"

-- nvim-cmp setup
local cmp = require("cmp")
local luasnip = require("luasnip")

-- map a key to call copilot
-- call :Copilot panel
vim.api.nvim_set_keymap("i", "<C-b>", "<cmd>Copilot panel<CR>", { silent = true, expr = true })

vim.keymap.set("i", "<C-y>", 'copilot#Accept("")', {
	expr = true,
	replace_keycodes = false,
})
vim.g.copilot_no_tab_map = true

cmp.setup({
	-- ctlr-x + ctrl-f to autocomplete path in insert mode in vim
	mapping = cmp.mapping.preset.insert({
		["<C-n>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
		["<C-p>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
		["<C-Space>"] = cmp.mapping.complete(),
		["<C-e>"] = cmp.mapping.abort(),
		["<C-y"] = cmp.mapping(
			cmp.mapping.confirm({
				behavior = cmp.ConfirmBehavior.Insert,
				select = true,
			}),
			{ "i", "c" }
		),
		["<C-b>"] = cmp.mapping.scroll_docs(-4),
		["<C-f>"] = cmp.mapping.scroll_docs(4),
	}),
	sources = {
		-- Copilot Source
		{ name = "nvim_lsp" },
		{ name = "path" },
		{ name = "buffer" },
		{ name = "luasnip" },
		{
			name = "lazydev",
			group_index = 0, -- set group index to 0 to skip loading LuaLS completions
		},
		-- { name = "codeium" },
	},
	snippet = {
		expand = function(args)
			luasnip.lsp_expand(args.body)
		end,
	},
	--
	-- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
	cmp.setup.cmdline({ "/", "?" }, {
		mapping = cmp.mapping.preset.cmdline(),
		sources = {
			{ name = "buffer" },
		},
	}),
})

cmp.setup.filetype({ "sql", "mysql", "dbt" }, {
	sources = {
		{ name = "vim-dadbod-completion" },
		{ name = "buffer" },
	},
})

luasnip.config.set_config({
	history = true,
	updateevents = "TextChanged,TextChangedI",
})

for _, filetype in ipairs(vim.api.nvim_get_runtime_file("lua/custom/snippets/*.lua", true)) do
	loadfile(filetype)()
end

vim.keymap.set({ "i", "s" }, "<C-k>", function()
	if luasnip.expand_or_jumpable() then
		luasnip.expand_or_jump()
	end
end)

vim.keymap.set({ "i", "s" }, "<C-j>", function()
	if luasnip.jumpable(-1) then
		luasnip.jump(-1)
	end
end)
