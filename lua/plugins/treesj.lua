-- https://github.com/Wansmer/treesj
-- Neovim plugin for splitting/joining blocks of code like arrays, hashes,
-- statements, objects, dictionaries, etc. Using Tree-Sitter.
return {
  {
    "Wansmer/treesj",
    keys = {
      { "<leader>mS", "", desc = "TreeSJ" },
      { "<leader>mSt", "<CMD>TSJToggle<CR>", desc = "Toggle" },
      { "<leader>mSj", "<CMD>TSJJoin<CR>", desc = "Join" },
      { "<leader>mSs", "<CMD>TSJSplit<CR>", desc = "Split" },
    },
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    opts = {
      use_default_keymaps = false,
    },
    config = true,
  },
}
