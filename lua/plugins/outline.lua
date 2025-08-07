-- https://github.com/hedyhli/outline.nvim
-- alternative :Lspsaga outline
-- alternative https://github.com/stevearc/aerial.nvim
return {
  "hedyhli/outline.nvim",
  enabled = false,
  lazy = true,
  cmd = { "Outline", "OutlineOpen" },
  keys = {
    { "<leader>o", "<cmd>Outline<CR>", desc = "Toggle outline" },
  },
  opts = {},
}
