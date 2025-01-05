-- https://github.com/folke/trouble.nvim
return {
  "folke/trouble.nvim",
  cmd = "Trouble",
  keys = {
    { "<leader>xx", "<CMD>Trouble diagnostics toggle<CR>", desc = "Diagnostics (Trouble)" },
    { "<leader>xX", "<CMD>Trouble diagnostics toggle filter.buf=0<CR>", desc = "Buffer Diagnostics (Trouble)" },
    { "<leader>cs", "<CMD>Trouble symbols toggle focus=false<CR>", desc = "Symbols (Trouble)" },
    {
      "<leader>cl",
      "<CMD>Trouble lsp toggle focus=false win.position=right<CR>",
      desc = "LSP Definitions / references / ... (Trouble)",
    },
    { "<leader>xL", "<CMD>Trouble loclist toggle<CR>", desc = "Location List (Trouble)" },
    { "<leader>xQ", "<CMD>Trouble qflist toggle<CR>", desc = "Quickfix List (Trouble)" },
    { "<leader>xt", "<CMD>TodoTrouble<CR>", desc = "Open TODOs (Trouble)" },
  },
  opts = {},
}
