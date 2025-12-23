-- https://github.com/zbirenbaum/copilot.lua
-- https://github.com/zbirenbaum/copilot-cmp -- show suggestions in CMP
--                                              or get suggestions with ghost-text in-line
-- shortcuts alternative https://github.com/orgs/community/discussions/45434
--
-- alternative to review https://github.com/yetone/avante.nvim
return {
  {
    "zbirenbaum/copilot.lua",
    enabled = vim.g.ai_enabled,
    cmd = "Copilot",
    event = "InsertEnter",
    build = ":Copilot auth",
    config = function()
      require("copilot").setup({
        panel = {
          enabled = true,
          auto_refresh = false,
          keymap = {
            jump_prev = "[[",
            jump_next = "]]",
            accept = "<CR>",
            refresh = "gr",
            open = "<M-CR>",
          },
          layout = {
            position = "bottom", -- | top | left | right | bottom |
            ratio = 0.4,
          },
        },
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
        filetypes = {
          conf = true,
          dosini = true,
          gitcommit = true,
          go = true,
          hcl = true,
          javascript = true,
          lua = true,
          make = true,
          markdown = true,
          python = true,
          sh = true,
          terraform = true,
          typescript = true,
          yaml = true,
          gitrebase = false,
          help = false,
          ["."] = false,
        },
        server_opts_overrides = {
          settings = {
            telemetry = {
              telemetryLevel = "off",
            },
          },
        },
      })
    end,
  },
  {
    -- https://github.com/CopilotC-Nvim/CopilotChat.nvim
    "CopilotC-Nvim/CopilotChat.nvim",
    enabled = vim.g.ai_enabled,
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
    keys = {
      {
        "<leader>cc",
        mode = { "n" },
        desc = "Copilot Chat Toggle",
        function()
          require("CopilotChat").toggle()
        end,
      },
    },
    opts = {
      debug = false,
      log_level = "info",
      model = "gpt-4.1",
      resources = {
        "buffer",
        "selection",
      },
      window = {
        -- layout = "float",
        -- border = "rounded",
        layout = "vertical",
        width = 0.3,
      },
      headers = {
        user = " You: ",
        assistant = "󱙺 Copilot: ",
        tool = " Tool: ",
      },
      separator = "━━",
    },
  },
}
