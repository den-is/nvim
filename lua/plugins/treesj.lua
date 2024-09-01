-- https://github.com/Wansmer/treesj
-- Neovim plugin for splitting/joining blocks of code like arrays, hashes,
-- statements, objects, dictionaries, etc. Using Tree-Sitter.
return {
  {
    "Wansmer/treesj",
    keys = {
      { "<leader>mS", "", desc = "TreeSJ" },
      { "<leader>mSt", "<cmd>TSJToggle<cr>", desc = "Toggle" },
      { "<leader>mSj", "<cmd>TSJJoin<cr>", desc = "Join" },
      { "<leader>mSs", "<cmd>TSJSplit<cr>", desc = "Split" },
    },
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    opts = {
      use_default_keymaps = false,
    },
    config = true,
  },
}
