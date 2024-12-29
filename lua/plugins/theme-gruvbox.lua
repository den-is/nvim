-- https://github.com/ellisonleao/gruvbox.nvim
return {
  "ellisonleao/gruvbox.nvim",
  enabled = false,
  priority = 1000,
  init = function()
    vim.cmd.colorscheme("gruvbox")
  end,
  config = function()
    require("gruvbox").setup({
      italic = {
        strings = false,
        emphasis = true,
        comments = true,
        operators = false,
        folds = true,
      },
    })
  end,
}
