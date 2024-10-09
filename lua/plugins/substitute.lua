-- https://github.com/gbprod/substitute.nvim
-- overrides default `s`, `S` keymaps. To review and play again later.
-- Default keymaps:
--  ["x]c{motion} - delete the text that {motion} moves over and start insert
--  ["x]cc - Delete [count] lines [into register x] and start insert linewise.
--  ["x]C - Delete from the cursor position to the end of the line and [count]-1 more lines [into register x], and start insert.
--  ["x]s - cl - Delete [count] characters [into register x] and start insert (s stands for Substitute).
--  ["x]S - cc - Delete [count] lines [into register x] and start insert.

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
