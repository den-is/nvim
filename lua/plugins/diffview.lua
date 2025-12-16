-- https://github.com/sindrets/diffview.nvim
-- NVIM as a merge tool https://gist.github.com/Pagliacii/8fcb4dc64937305c19df9bb3137e4cad
-- https://www.reddit.com/r/neovim/comments/1f7jj15/how_do_you_work_without_diffviewnvim/
-- https://www.naseraleisa.com/posts/diff
return {
  "sindrets/diffview.nvim",
  lazy = false,
  enabled = false,
  dependencies = {
    "nvim-lua/plenary.nvim",
    "lewis6991/gitsigns.nvim",
  },
  config = true,
  keys = {
    { "<leader>hq", "<CMD>DiffviewClose<CR>", mode = { "n" }, desc = "Diffview - Close" },
    { "<leader>hd", "<CMD>DiffviewOpen<CR>", mode = { "n" }, desc = "Diffview - Repo Diffview", nowait = true },
    { "<leader>hh", "<CMD>DiffviewFileHistory<CR>", mode = { "n" }, desc = "Diffview - Repo history" },
    { "<leader>hf", "<CMD>DiffviewFileHistory --follow %<CR>", mode = { "n" }, desc = "Diffview - File history" },
    {
      "<leader>hm",
      desc = "Diffview - Diff with main branch (whatever main branch is)",
      function()
        -- get repo root
        local git_root = vim.fn.system("git rev-parse --show-toplevel 2>/dev/null"):gsub("\n", "")
        if git_root == "" then
          vim.notify("Not inside a Git repository", vim.log.levels.WARN)
          return
        end

        -- get the default branch name
        local origin_head =
          vim.fn.system({ "git", "-C", git_root, "symbolic-ref", "--short", "refs/remotes/origin/HEAD" }):gsub("\n", "")
        local branch = origin_head:match("origin/(.+)")
        if not branch then
          vim.notify("Unable to detect default origin branch", vim.log.levels.WARN)
          return
        end

        -- diffview against main branch
        vim.cmd("DiffviewOpen origin/" .. branch)
      end,
    },
    {
      "<leader>hl",
      mode = { "n" },
      desc = "Diffview - Line history",
      function()
        local current_line = vim.fn.line(".")
        local file = vim.fn.expand("%")
        -- DiffviewFileHistory --follow -L{current_line},{current_line}:{file}
        local cmd = string.format("DiffviewFileHistory --follow -L%s,%s:%s", current_line, current_line, file)
        vim.cmd(cmd)
      end,
    },
    {
      "<leader>hl",
      mode = { "v" },
      desc = "Diffview - Range history",
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
