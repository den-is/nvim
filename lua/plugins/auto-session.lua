-- https://github.com/rmagatti/auto-session
return {
  "rmagatti/auto-session",
  cmd = "AutoSession",
  keys = {
    { "<leader>wr", "<cmd>AutoSession restore<CR>", desc = "Restore session for cwd" },
    { "<leader>ws", "<cmd>AutoSession save<CR>", desc = "Save session to auto-sessions data dir" },
    { "<leader>wf", "<cmd>AutoSession search<CR>", desc = "Session search" },
    { "<leader>wa", "<cmd>AutoSession toggle<CR>", desc = "Toggle session autosave" },
  },

  config = function()
    local auto_session = require("auto-session")
    auto_session.setup({
      enabled = true,
      auto_save = false,
      auto_restore = false,
      suppressed_dirs = { "~/", "~/Downloads", "~/Desktop", "~/Documents" },
      bypass_save_filetypes = { "dashboard", "snacks_dashboard" },
      legacy_cmds = false,
      session_lens = {
        picker = "snacks",
      },
      -- root_dir = vim.fn.stdpath "data" .. "/sessions/",
      -- log_level = 'debug',
    })
  end,
}
