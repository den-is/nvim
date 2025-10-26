-- https://github.com/catppuccin/nvim
return {
  "catppuccin/nvim",
  lazy = false,
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
        cmp = true,
        gitsigns = true,
        nvimtree = true,
        -- treesitter = true,
        treesitter_context = true,
        render_markdown = true,
        mason = true,
        which_key = true,
        indent_blankline = {
          enabled = true,
          scope_color = "flamingo", -- catppuccin color (eg. `lavender`)
          colored_indent_levels = false,
        },
        mini = {
          enabled = true,
          indentscope_color = "flamingo", -- catppuccin color (eg. `lavender`)
        },
        snacks = {
          enabled = false,
          indent_scope_color = "flamingo", -- catppuccin color (eg. `lavender`)
        },
        -- disabled stuff
        alpha = false,
        telescope = {
          enabled = false,
        },
      },
    })

    vim.cmd.colorscheme("catppuccin")
  end,
}
