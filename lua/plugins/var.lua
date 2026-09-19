return {
  -- https://github.com/norcalli/nvim-colorizer.lua
  {
    "norcalli/nvim-colorizer.lua",
    lazy = true,
    config = function()
      require("colorizer").setup()
    end,
  },
}
