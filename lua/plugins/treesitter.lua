-- https://github.com/nvim-treesitter/nvim-treesitter
-- https://github.com/RRethy/nvim-treesitter-endwise
-- https://github.com/windwp/nvim-ts-autotag
return {
  "nvim-treesitter/nvim-treesitter",
  event = { "BufReadPost", "BufNewFile" },
  dependencies = {
    "RRethy/nvim-treesitter-endwise",
    "windwp/nvim-ts-autotag",
  },
  build = ":TSUpdate",
  config = function()
    require("nvim-treesitter.configs").setup({
      -- A list of parser names, or "all" (the listed parsers MUST always be installed)
      ensure_installed = {
        "bash",
        "cmake",
        "css",
        "dockerfile",
        "go",
        "hcl",
        "html",
        "javascript",
        "json",
        "jsonc",
        "lua",
        "markdown",
        "markdown_inline",
        "query",
        "python",
        "regex",
        "terraform",
        "toml",
        "vim",
        "yaml",
        "ruby",
      },
      sync_install = false,
      highlight = { enable = true },
      indent = { enable = true },
      endwise = { enable = true },
      autopairs = { enable = true },
    })

    require("nvim-ts-autotag").setup()
  end,
}
