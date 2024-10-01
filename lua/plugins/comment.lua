-- https://github.com/numToStr/Comment.nvim
-- "comment on a new line" continuation is disabled in config/autocmds.lua
-- https://neovim.io/doc/user/various.html#_3.-commenting
-- Basic shortcuts:
-- gcc - line comment
-- gbc - block commant
return {
  "numToStr/Comment.nvim",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    "JoosepAlviste/nvim-ts-context-commentstring",
  },
  config = function()
    local comment = require("Comment")
    local ts_context_commentstring = require("ts_context_commentstring.integrations.comment_nvim")
    comment.setup({
      pre_hook = ts_context_commentstring.create_pre_hook(),
    })
  end,
}
