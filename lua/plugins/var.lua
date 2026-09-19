return {
  -- https://github.com/catgoose/nvim-colorizer.lua
  {
    "catgoose/nvim-colorizer.lua",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      require("colorizer").setup()
    end,
  },
}
