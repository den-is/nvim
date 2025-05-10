-- https://github.com/hedyhli/outline.nvim
-- alternative for :Lspsaga outline
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
