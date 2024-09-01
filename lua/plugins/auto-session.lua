-- https://github.com/rmagatti/auto-session
return {
  "rmagatti/auto-session",
  lazy = false,
  dependencies = {
    "nvim-telescope/telescope.nvim", -- Only needed if you want to use session lens
  },

  config = function()
    local auto_session = require("auto-session")
    auto_session.setup({
      enabled = false,
      auto_restore_last_session = false,
      suppressed_dirs = { "~/", "~/Downloads", "~/Desktop", "~/Documents" },
      bypass_save_filetypes = { "alpha", "dashboard" },
      -- root_dir = vim.fn.stdpath "data" .. "/sessions/",
      -- log_level = 'debug',
    })

    vim.keymap.set("n", "<leader>wr", "<cmd>SessionRestore<CR>", { desc = "Restore session for cwd" })
    vim.keymap.set("n", "<leader>ws", "<cmd>SessionSave<CR>", { desc = "Save session to auto-sessions data dir" })
    vim.keymap.set("n", "<leader>wf", "<cmd>SessionSearch<CR>", { desc = "Session search" })
    vim.keymap.set("n", "<leader>wa", "<cmd>SessionToggleAutoSave<CR>", { desc = "Toggle session autosave" })
  end,
}
