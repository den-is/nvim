-- https://github.com/mfussenegger/nvim-lint
-- alternative https://github.com/nvimtools/none-ls.nvim -- wraps linters and formatters and creates LSP out of them, so can be used with nvim-lsp and cmp
return {
  "mfussenegger/nvim-lint",
  event = { "BufReadPre", "BufNewFile" },
  keys = {
    -- stylua: ignore start
    { "<leader>xl", function() require("lint").try_lint() end, desc = "Lint current buffer", mode = { "n" } },
    -- stylua: ignore end
  },

  config = function()
    local lint = require("lint")
    lint.linters_by_ft = {
      javascript = { "eslint_d" },
      typescript = { "eslint_d" },
      javascriptreact = { "eslint_d" },
      typescriptreact = { "eslint_d" },
      svelte = { "eslint_d" },
      python = { "ruff" },
      yaml = { "yamllint" },
      terraform = { "tflint" },
      bash = { "shellcheck" },
      -- Disabled in favor of native Gopls LSP diagnostics
      -- -- with golangci-lint + gopls enabled i was getting same Diagnostic messages doubled
      -- go = { "golangcilint" },
      -- ansible = { "ansible_lint" },
    }

    -- setting `-d` blocks config file (.yamllint) lookup
    -- lint.linters.yamllint.args = { "-d", "relaxed", "--format", "parsable", "-" }
    lint.linters.yamllint.args = { "--format", "parsable", "-" }

    -- Auto lint on save
    local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })
    vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
      group = lint_augroup,
      callback = function()
        lint.try_lint()
      end,
    })
  end,
}
