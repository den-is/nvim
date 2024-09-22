-- https://github.com/nvim-treesitter/nvim-treesitter
-- https://github.com/RRethy/nvim-treesitter-endwise
-- https://github.com/windwp/nvim-ts-autotag
-- https://github.com/nvim-treesitter/nvim-treesitter-textobjects
return {
  "nvim-treesitter/nvim-treesitter",
  event = { "BufReadPost", "BufNewFile" },
  dependencies = {
    "RRethy/nvim-treesitter-endwise",
    "nvim-treesitter/nvim-treesitter-context",
    "nvim-treesitter/nvim-treesitter-textobjects",
    "windwp/nvim-ts-autotag",
  },
  build = ":TSUpdate",
  config = function()
    ---@diagnostic disable-next-line: missing-fields
    require("nvim-treesitter.configs").setup({
      sync_install = false,
      highlight = { enable = true },
      indent = { enable = true },
      endwise = { enable = true },
      autopairs = { enable = true },
      -- A list of parser names, or "all" (the listed parsers MUST always be installed)
      ensure_installed = {
        "bash",
        "cmake",
        "css",
        "dockerfile",
        "go",
        "gomod",
        "gosum",
        "gotmpl",
        "gowork",
        "hcl",
        "html",
        "javascript",
        "json",
        "jsonc",
        "lua",
        "diff",
        "gitcommit",
        "gitignore",
        "git_rebase",
        "git_config",
        "markdown",
        "markdown_inline",
        "python",
        "query",
        "regex",
        "ruby",
        "sql",
        "terraform",
        "toml",
        "vim",
        "yaml",
      },
    })

    require("nvim-ts-autotag").setup()
    require("treesitter-context").setup()
  end,
}
