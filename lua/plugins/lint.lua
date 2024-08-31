-- https://github.com/mfussenegger/nvim-lint
-- alternative https://github.com/nvimtools/none-ls.nvim -- wraps linters and formatters and creates LSP out of them
return {
  "mfussenegger/nvim-lint",
  event = { "BufReadPre", "BufNewFile" },
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
      -- ansible = { "ansible_lint" },
    }

    lint.linters.yamllint.args = { "-d", "relaxed", "--format", "parsable", "-" }

    -- Auto lint on save
    local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })
    vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
      group = lint_augroup,
      callback = function()
        lint.try_lint()
      end,
    })

    vim.keymap.set("n", "<leader>l", function()
      lint.try_lint()
    end, { desc = "Trigger linting for current file" })
  end,
}