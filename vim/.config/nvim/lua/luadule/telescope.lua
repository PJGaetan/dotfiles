local actions = require('telescope.actions')

-- telescope dev docs https://github.com/nvim-telescope/telescope.nvim/blob/master/developers.md

require('telescope').setup{
  defaults = {
    prompt_position = "top",
    selection_strategy = "reset",
    sorting_strategy = "ascending",
    layout_strategy = "horizontal",
    file_sorter =  require'telescope.sorters'.get_fuzzy_file,
    generic_sorter =  require'telescope.sorters'.get_fzy_sorter,
    file_ignore_patterns = {"zsh/plugin/*", "zsh/custom/*", "zsh/lib/*", "zsh/themes/*", "zsh/tools/*", ".DS_Store", "/zsh/cache/*"},
    layout_defaults = {
      horizontal = {
        mirror = false,
      },
      vertical = {
        mirror = true,
      },
    },
    mappings = {
      i = {
        -- to find differents actions https://github.com/nvim-telescope/telescope.nvim/blob/master/lua/telescope/actions/init.lua
        ["<C-j>"] = actions.move_selection_next,
        ["<C-k>"] = actions.move_selection_previous,
      },
    },
    set_env = { ['COLORTERM'] = 'truecolor' }, -- default = nil,

  }
}
local M = {}


return M
