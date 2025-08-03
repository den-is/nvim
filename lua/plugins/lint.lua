-- https://github.com/mfussenegger/nvim-lint
-- alternative https://github.com/nvimtools/none-ls.nvim -- wraps linters and formatters and creates LSP out of them, so can be used with nvim-lsp and cmp
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
      go = { "golangcilint" },
      -- ansible = { "ansible_lint" },
    }

    -- at the moment of writing golangci-lint is v2.2.2
    -- nvim-lint still supports only v2.0
    -- https://github.com/mfussenegger/nvim-lint/issues/829
    lint.linters.golangcilint.args = {
      "run",
      "--issues-exit-code=0",
      "--show-stats=false",
      "--output.json.path=stdout",
      -- Get absolute path of the linted file
      "--path-mode=abs",
      -- extras
      "--output.text.print-issued-lines=false",
      "--output.text.print-linter-name=false",
      -- Overwrite values possibly set in .golangci.yml
      "--output.text.path=",
      "--output.tab.path=",
      "--output.html.path=",
      "--output.checkstyle.path=",
      "--output.code-climate.path=",
      "--output.junit-xml.path=",
      "--output.teamcity.path=",
      "--output.sarif.path=",
      function()
        return vim.fn.fnamemodify(vim.api.nvim_buf_get_name(0), ":h")
      end,
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

    vim.keymap.set("n", "<leader>xl", function()
      lint.try_lint()
    end, { desc = "Trigger linting for current file" })
  end,
}
