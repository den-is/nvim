-- https://github.com/gbprod/substitute.nvim
-- overrides default `s`, `S` keymaps. To review and play again later.
return {
  "gbprod/substitute.nvim",
  event = { "BufReadPre", "BufNewFile" },
  enabled = false,
  config = function()
    local substitute = require("substitute")
    substitute.setup()
    vim.keymap.set("n", "s", substitute.operator, { noremap = true, desc = "Substitute with motion" })
    vim.keymap.set("n", "ss", substitute.line, { noremap = true, desc = "Substitute line" })
    vim.keymap.set("n", "S", substitute.eol, { noremap = true, desc = "Substitute to end of line" })
    vim.keymap.set("x", "s", substitute.visual, { noremap = true, desc = "Substitute in visual mode" })
  end,
}
