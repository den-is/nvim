-- https://github.com/numToStr/Comment.nvim
-- https://github.com/JoosepAlviste/nvim-ts-context-commentstring
-- "comment on a new line" continuation is disabled in config/autocmds.lua
-- https://neovim.io/doc/user/various.html#_3.-commenting
-- Basic shortcuts:
-- gcc - line comment
-- gbc - block comment
return {
  "numToStr/Comment.nvim",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    "JoosepAlviste/nvim-ts-context-commentstring",
  },
  config = function()
    local comment = require("Comment")
    local ft = require("Comment.ft")

    -- Comment.nvim-specific fallback.
    -- No space here; Comment.nvim adds padding itself.
    ft.set("pgpass", "#%s")

    local ts_context_commentstring = require("ts_context_commentstring.integrations.comment_nvim")

    local ts_pre_hook = ts_context_commentstring.create_pre_hook()

    ---@diagnostic disable-next-line: missing-fields
    comment.setup({
      pre_hook = function(ctx)
        if vim.bo.filetype == "pgpass" then
          return "# %s"
        end

        return ts_pre_hook(ctx)
      end,
    })
  end,
}
