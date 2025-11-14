-- https://github.com/folke/todo-comments.nvim
-- integrates with:
-- - trouble.nvim `<leader>xt`
-- - Snacks picker `<leader>ft`
-- VSCode alternatives:
-- - https://marketplace.visualstudio.com/items?itemName=Gruntfuggly.todo-tree
-- - https://marketplace.visualstudio.com/items?itemName=EdwinHuiSH.better-comments-next

return {
  "folke/todo-comments.nvim",
  enabled = true,
  events = { "BufReadPre", "BufNewFile" },
  dependencies = {
    "nvim-lua/plenary.nvim",
    "folke/snacks.nvim",
  },
  lazy = false,
  keys = {
    -- stylua: ignore start
    { "]t", function() require("todo-comments").jump_next() end, desc = "Next TODO comment" },
    { "[t", function() require("todo-comments").jump_prev() end, desc = "Previous TODO comment" },
    { "<leader>ft", function() Snacks.picker.todo_comments({layout = {preset = "ivy", hidden = {"preview"},}}) end, desc = "TODO List" },
    { "<leader>fT", function() Snacks.picker.todo_comments({ keywords = { "TODO", "FIX", "FIXME" } }) end, desc = "TODO/FIX/FIXME List only" },
    -- stylua: ignore end
  },
  opts = {
    keywords = {
      FIX = { icon = " ", color = "error", alt = { "FIXME", "BUG", "FIXIT", "ISSUE" } },
      TODO = { icon = " ", color = "info" },
      HACK = { icon = " ", color = "warning" },
      WARN = { icon = " ", color = "warning", alt = { "WARNING" } },
      PERF = { icon = " ", alt = { "OPTIM", "OPTIMIZE" } },
      NOTE = { icon = " ", color = "hint", alt = { "INFO" } },
      TEST = { icon = "⏲ ", color = "test", alt = { "TESTING", "PASSED", "FAILED" } },
    },
    colors = {
      error = { "DiagnosticError", "ErrorMsg", "#DC2626" },
      warning = { "DiagnosticWarn", "WarningMsg", "#FBBF24" },
      info = { "DiagnosticInfo", "#2563EB" },
      hint = { "DiagnosticHint", "#10B981" },
      default = { "Identifier", "#7C3AED" },
      test = { "Identifier", "#FF00FF" },
    },
    search = {
      command = "rg",
      args = {
        "--color=never",
        "--no-heading",
        "--with-filename",
        "--line-number",
        "--column",
      },
      -- by default matching required `:` after keyword for a match
      -- Issues:
      -- - https://github.com/folke/todo-comments.nvim/issues/371
      -- pattern = [[\b(KEYWORDS)\b]],
      pattern = [[(?:--|//|/\*|#|;):? \b(KEYWORDS)\b]],
    },
    highlight = {
      pattern = [[.*<(KEYWORDS)\s*:?]],
      keyword = "bg",
    },
  },
}
