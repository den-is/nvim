-- https://github.com/sindrets/diffview.nvim
return {
  "sindrets/diffview.nvim",
  lazy = false,
  dependencies = {
    "nvim-lua/plenary.nvim",
    "lewis6991/gitsigns.nvim",
  },
  config = true,
  keys = {
    { ",d", "<cmd>DiffviewOpen<cr>", mode = { "n" }, desc = "Repo Diffview", nowait = true },
    { ",hh", "<cmd>DiffviewFileHistory<cr>", mode = { "n" }, desc = "Repo history" },
    { ",hf", "<cmd>DiffviewFileHistory --follow %<cr>", mode = { "n" }, desc = "File history" },
    { ",hm", "<cmd>DiffviewOpen master<cr>", mode = { "n" }, desc = "Diff with master" },
    {
      ",hl",
      function()
        local current_line = vim.fn.line(".")
        local file = vim.fn.expand("%")
        -- DiffviewFileHistory --follow -L{current_line},{current_line}:{file}
        local cmd = string.format("DiffviewFileHistory --follow -L%s,%s:%s", current_line, current_line, file)
        vim.cmd(cmd)
      end,
      desc = "Line history",
    },
    {
      ",hl",
      function()
        local v = require("utils.functions").get_visual_selection_info()
        local file = vim.fn.expand("%")
        -- DiffviewFileHistory --follow -L{range_start},{range_end}:{file}
        local cmd = string.format("DiffviewFileHistory --follow -L%s,%s:%s", v.start_row + 1, v.end_row + 1, file)
        vim.cmd(cmd)
      end,
      mode = { "v" },
      desc = "Range history",
    },
  },
}
