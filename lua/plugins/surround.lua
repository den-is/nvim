-- https://github.com/kylechui/nvim-surround
-- :h nvim-surround.usage
-- :h nvim-surround.configuration
return {
  "kylechui/nvim-surround",
  version = "*",
  -- event = "VeryLazy",
  event = { "BufReadPre", "BufNewFile" },
  opts = {},
}
