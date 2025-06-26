local builtin = require('telescope.builtin')
vim.keymap.set('n', '<C-p>', builtin.find_files, {})
vim.keymap.set('n', '<leader>g', builtin.live_grep, {})

require('telescope').setup{
    defaults = {
        mappings = {
            i = {
                [ "<C-j>" ] = "move_selection_next",
                [ "<C-k>" ] = "move_selection_previous",
            }
        }
    }
}
require('cmp')
