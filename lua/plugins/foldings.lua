-- https://github.com/kevinhwang91/nvim-ufo
-- https://neovim.io/doc/user/fold.html
-- za - toggle fold
-- zc - close fold
-- zo - open fold
-- zR - open all folds
-- zM - close all folds
return {
  "kevinhwang91/nvim-ufo",
  event = "UIEnter", -- needed for folds to load in time and comments closed
  dependencies = {
    "kevinhwang91/promise-async",
  },
  init = function()
    -- INFO fold commands usually change the foldlevel, which fixes folds, e.g.
    -- auto-closing them after leaving insert mode, however ufo does not seem to
    -- have equivalents for zr and zm because there is no saved fold level.
    -- Consequently, the vim-internal fold levels need to be disabled by setting
    -- them to 99.
    vim.opt.foldlevel = 99
    vim.opt.foldlevelstart = 99
    vim.opt.foldenable = true
  end,
  config = function()
    local ufo = require("ufo")

    -- vim.o.foldcolumn = "0" -- enabled disable fold column
    -- vim.o.foldenable = true

    vim.keymap.set("n", "zR", ufo.openAllFolds, { desc = "Open All Folds" })
    vim.keymap.set("n", "zM", ufo.closeAllFolds, { desc = "Close All Folds" })

    require("ufo").setup()
  end,
}
