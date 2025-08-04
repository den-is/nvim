-- https://github.com/windwp/nvim-autopairs
-- enabled treesitter integration
-- alternative https://github.com/echasnovski/mini.pairs
return {
  "windwp/nvim-autopairs",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    "hrsh7th/nvim-cmp",
  },
  config = function()
    local autopairs = require("nvim-autopairs")
    autopairs.setup({
      disable_filetype = { "TelescopePrompt", "alpha", "dashboard", "spectre_panel", "snacks_picker_input" },
      -- enable_check_bracket_line = false, -- Don't add pairs if it already has a close pair in the same line
      -- ignored_next_char = "[%w%.]", -- will ignore alphanumeric and `.` symbol
      check_ts = true, -- use treesitter to check for a pair.
      ts_config = {
        lua = { "string" }, -- it will not add pair on that treesitter node
        javascript = { "template_string" },
        java = false, -- don't check treesitter on java
      },
    })

    -- If you want insert `(` after select function or method item
    local cmp_autopairs = require("nvim-autopairs.completion.cmp")
    require("cmp").event:on("confirm_done", cmp_autopairs.on_confirm_done())
  end,
}
