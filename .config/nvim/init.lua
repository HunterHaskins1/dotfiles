require("configs.remaps")
require("configs.plugins")
require('tokyonight').load()

vim.api.nvim_create_autocmd("TextYankPost", {
  desc = "Highlight text when yanking",
  callback = function()
    vim.highlight.on_yank({ higroup = "IncSearch", timeout = 200 })
  end,
})
