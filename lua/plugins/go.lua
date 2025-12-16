-- https://github.com/ray-x/go.nvim
-- using friendly-snippets from VSCode for LuaSnip
--   https://github.com/rafamadriz/friendly-snippets/blob/main/snippets/go.json
-- ray-x/go.nvim snippets: https://github.com/ray-x/go.nvim/blob/master/lua/snips/go.lua
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
        dap_debug = false,
        -- we use nvim-lspconfig for completion and LSP configuration
        lsp_cfg = false,
        -- nvim-cmd + luasnip + friendly-snippets for snippets
        luasnip = false,
        -- dignostics using native nvim and lspconfig
        diagnostic = false,
        lsp_inlay_hints = {
          -- configured in `neovim/nvim-lspconfig` (lsp.lua)
          -- <leader>i to toggle hints
          enable = false,
        },
      })
    end,
  },
  {
    -- https://github.com/fredrikaverpil/godoc.nvim
    "fredrikaverpil/godoc.nvim",
    cmd = { "GoDoc" },
    opts = {},
  },
}
