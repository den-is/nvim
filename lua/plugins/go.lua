-- https://github.com/ray-x/go.nvim
return {
  {
    "ray-x/go.nvim",
    dependencies = {
      "ray-x/guihua.lua",
      "neovim/nvim-lspconfig",
      "nvim-treesitter/nvim-treesitter",
    },
    ft = { "go", "gomod" },
    event = { "CmdlineEnter" },
    build = ':lua require("go.install").update_all_sync()', -- if you need to install/update all binaries
    config = function()
      require("go").setup({
        lsp_cfg = false,
        null_ls = false,
        luasnip = false,
        diagnostic = false,
        lsp_inlay_hints = {
          -- configured in `neovim/nvim-lspconfig` (lsp.lua)
          -- <leader>i to toggle hints
          enable = false,
        },
      })
    end,
  },
  -- https://github.com/olexsmir/gopher.nvim
  {
    "olexsmir/gopher.nvim",
    enabled = false,
    ft = "go",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    opts = {},
  },
}
