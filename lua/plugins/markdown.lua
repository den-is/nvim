-- https://github.com/MeanderingProgrammer/render-markdown.nvim
return {
  {
    "MeanderingProgrammer/render-markdown.nvim",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-tree/nvim-web-devicons",
    },
    ft = "markdown",
    opts = {},
  },
  {
    -- https://github.com/iamcco/markdown-preview.nvim
    -- configuration not finished, preview not starting, missing lib
    "iamcco/markdown-preview.nvim",
    enabled = false,
    cmd = {
      "MarkdownPreviewToggle",
      "MarkdownPreview",
      "MarkdownPreviewStop",
    },
    ft = { "markdown" },
    build = function()
      vim.cmd([[Lazy load markdown-preview.nvim]])
      vim.fn["mkdp#util#install"]()
    end,
  },
}
