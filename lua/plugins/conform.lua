-- https://github.com/stevearc/conform.nvim
-- https://github.com/Allaman/nvim/blob/main/lua/config/defaults/conform.lua
-- alternative https://github.com/nvimtools/none-ls.nvim -- wraps linters and formatters and creates LSP out of them
return {
  "stevearc/conform.nvim",
  event = { "BufReadPre", "BufNewFile", "InsertLeave" },
  config = function()
    local conform = require("conform")
    conform.setup({

      -- Use `:ConformInfo` to see the location of the log file.
      -- log_level = vim.log.levels.TRACE,

      format_on_save = {
        -- These options will be passed to conform.format()
        lsp_format = "fallback",
        async = false,
        timeout_ms = 1000,
      },

      formatters_by_ft = {
        javascript = { "prettier" },
        typescript = { "prettier" },
        javascriptreact = { "prettier" },
        typescriptreact = { "prettier" },
        svelte = { "prettier" },
        css = { "prettier" },
        html = { "prettier" },
        lua = { "stylua" },
        markdown = { "prettier" },
        json = { "prettier" },
        yaml = { "yamlfmt" },
        python = { "black", "ruff_organize_imports" },
        go = { "goimports" },
        sh = { "shfmt" },
        terraform = { "terraform_fmt" },
      },

      formatters = {
        shfmt = {
          prepend_args = { "-i", "2" }, -- 2 spaces instead of tab
        },
        stylua = {
          prepend_args = { "--indent-type", "Spaces", "--indent-width", "2" }, -- 2 spaces instead of tab
        },
        yamlfmt = {
          prepend_args = {
            "-formatter",
            "indent=2,indentless_arrays=true,include_document_start=false,retain_line_breaks_single=true,eof_newline=true",
          },
        },
      },
    })

    vim.keymap.set({ "n", "v" }, "<leader>mp", function()
      conform.format({
        lsp_format = "fallback",
        async = false,
        timeout_ms = 1000,
      })
    end, { desc = "Format file or range (in visual mode)" })
  end,
}
