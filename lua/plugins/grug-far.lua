-- https://github.com/MagicDuck/grug-far.nvim
return {
  "MagicDuck/grug-far.nvim",
  event = "VeryLazy",
  config = function()
    require("grug-far").setup({
      engine = "ripgrep",
    })
  end,
}
