-- tailwind-tools.lua
return {
	"luckasRanarison/tailwind-tools.nvim",
	dependencies = { "nvim-treesitter/nvim-treesitter" },
	build = ":UpdateRemotePlugins",
	opts = {}, -- your configuration
	ft = { "html", "typescriptreact", "javascriptreact", "vue", "css", "scss", "svelte", "astro", "php" },
}
