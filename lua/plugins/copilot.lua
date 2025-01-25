-- https://github.com/zbirenbaum/copilot.lua
-- https://github.com/zbirenbaum/copilot-cmp -- show suggestions in CMP
--                                              or get suggestions with ghost-text in-line
-- https://github.com/CopilotC-Nvim/CopilotChat.nvim
-- shortcuts alternative https://github.com/orgs/community/discussions/45434
--
-- alternative to review https://github.com/yetone/avante.nvim
return {
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "InsertEnter",
    build = ":Copilot auth",
    config = function()
      require("copilot").setup({
        suggestion = {
          auto_trigger = true,
          keymap = {
            accept = "<M-l>",
            accept_word = false,
            accept_line = false,
            next = "<M-]>",
            prev = "<M-[>",
            dismiss = "<C-]>",
          },
        },
        panel = { enabled = false },
        filetypes = {
          yaml = true,
          markdown = true,
          help = false,
          gitcommit = true,
          gitrebase = false,
          hgcommit = false,
          svn = false,
          cvs = false,
          ["."] = false,
        },
      })
    end,
  },
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    enabled = true,
    branch = "main",
    lazy = true,
    event = "VeryLazy",
    -- cmd = {
    --   "CopilotChat",
    --   "CopilotChatOpen",
    --   "CopilotChatToggle",
    -- },
    dependencies = {
      { "zbirenbaum/copilot.lua" },
      { "nvim-lua/plenary.nvim" },
    },
    build = "make tiktoken", -- Only on MacOS or Linux
    opts = {
      debug = false,
      window = {
        layout = "float",
        border = "rounded",
      },
    },
  },
}
