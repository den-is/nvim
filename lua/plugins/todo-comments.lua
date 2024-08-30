-- https://github.com/folke/todo-comments.nvim
-- integrates with https://github.com/folke/trouble.nvim `<leader>xt`
-- and Telescope (<leader>ft)

return {
  "folke/todo-comments.nvim",
  events = { "BufReadPre", "BufNewFile" },
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  config = function()
    local todo_comments = require("todo-comments")

    todo_comments.setup()

    vim.keymap.set("n", "]t", function()
      todo_comments.jump_next()
    end, { desc = "Next todo comment" })

    vim.keymap.set("n", "[t", function()
      todo_comments.jump_prev()
    end, { desc = "Previous todo comment" })
  end,
}
