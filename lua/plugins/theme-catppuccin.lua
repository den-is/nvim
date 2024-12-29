-- https://github.com/catppuccin/nvim
return {
  "catppuccin/nvim",
  enabled = true,
  priority = 1000,
  config = function()
    require("catppuccin").setup({
      -- automatically set colorscheme based on GUI/Terminal background color
      flavour = "auto",
      background = {
        light = "latte",
        dark = "macchiato",
      },
      default_integrations = false,
      integrations = {
        alpha = true,
        cmp = true,
        gitsigns = true,
        nvimtree = true,
        treesitter = true,
        indent_blankline = { enabled = true },
        markdown = true,
        mason = true,
        mini = true,
        telescope = true,
        which_key = true,
      },
    })

    vim.cmd.colorscheme("catppuccin")
  end,
}
