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
        json = { "prettier" },
        lua = { "stylua" },
        python = { "black", "ruff_organize_imports" },
        go = { "golines", "gofumpt" },
        sh = { "shfmt" },
        toml = { "taplo" },
        terraform = { "terraform_fmt" },
        hcl = { "terragrunt_hclfmt" },
        -- hcl = { "terraform_fmt" },
        ---- flattens array of arrays https://github.com/google/yamlfmt/issues/167
        -- yaml = { "yamlfmt" },
        ----
        ---- markdownfmt tested
        ---- For some reason replaces spaces with tabs
        ---- also splitting list items and list identifier with 4 spaces or tab
        ---- I.e list item `- item` becomes `-    item`
        ---- .editorconfig had influence on this, tab becomes 2 or 4 spaces
        ---- but .editorconfig is was not able to make markdownfmt to use spaces instead of tabs
        ----
        ---- prettier works better and also uses .editorconfig in addition to .prettierrc and similar
        markdown = { "prettier" },
      },

      formatters = {
        gofumpt = {
          -- https://github.com/stevearc/conform.nvim/issues/387
          args = { "$FILENAME" },
        },
        black = {
          prepend_args = { "--line-length", "99" },
        },
        shfmt = {
          prepend_args = { "--indent", "2" }, -- 2 spaces instead of tab
        },
        stylua = {
          prepend_args = { "--indent-type", "Spaces", "--indent-width", "2" }, -- 2 spaces instead of tab
        },
        -- prettier = {
        --  prepend_args = { "--use-tabs", "false" },
        -- },
        ---- Yamlfmt is buggy
        ---- flattens array of arrays https://github.com/google/yamlfmt/issues/167
        -- yamlfmt = {
        --   prepend_args = {
        --     "-formatter",
        --     "indent=2,indentless_arrays=true,include_document_start=false,retain_line_breaks_single=true,eof_newline=true",
        --   },
        -- },
      },
    })

    vim.keymap.set({ "n", "v" }, "<leader>xf", function()
      conform.format({
        lsp_format = "fallback",
        async = false,
        timeout_ms = 1000,
      })
    end, { desc = "Format file or range (in normal and visual modes)" })
  end,
}
