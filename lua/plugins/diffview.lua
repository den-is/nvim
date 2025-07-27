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
    { ",d", "<CMD>DiffviewOpen<CR>", mode = { "n" }, desc = "Repo Diffview", nowait = true },
    { ",hh", "<CMD>DiffviewFileHistory<CR>", mode = { "n" }, desc = "Repo history" },
    { ",hf", "<CMD>DiffviewFileHistory --follow %<CR>", mode = { "n" }, desc = "File history" },
    { ",hm", "<CMD>DiffviewOpen master<CR>", mode = { "n" }, desc = "Diff with master" },
    {
      ",hl",
      mode = { "n" },
      desc = "Line history",
      function()
        local current_line = vim.fn.line(".")
        local file = vim.fn.expand("%")
        -- DiffviewFileHistory --follow -L{current_line},{current_line}:{file}
        local cmd = string.format("DiffviewFileHistory --follow -L%s,%s:%s", current_line, current_line, file)
        vim.cmd(cmd)
      end,
    },
    {
      ",hl",
      mode = { "v" },
      desc = "Range history",
      function()
        local v = require("utils.functions").get_visual_selection_info()
        local file = vim.fn.expand("%")
        -- DiffviewFileHistory --follow -L{range_start},{range_end}:{file}
        local cmd = string.format("DiffviewFileHistory --follow -L%s,%s:%s", v.start_row + 1, v.end_row + 1, file)
        vim.cmd(cmd)
      end,
    },
  },
}
