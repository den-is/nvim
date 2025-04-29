-- https://github.com/williamboman/mason.nvim
return {
  "williamboman/mason.nvim",
  -- event = "VeryLazy", -- vim fails to load LSPs if Mason is not loaded early enough
  dependencies = {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
  },
  config = function()
    local mason = require("mason")
    local mason_tool_installer = require("mason-tool-installer")

    mason.setup({
      ui = {
        icons = {
          package_installed = "✓",
          package_pending = "➜",
          package_uninstalled = "✗",
        },
      },
    })

    mason_tool_installer.setup({
      -- check which linters are already available on system
      ensure_installed = {
        ---- Formatters
        "prettier",
        "stylua",
        -- I already have most of these tools installed on my system
        -- "shfmt",         -- system
        ---- Linters
        -- "eslint_d",      -- system
        -- "shellcheck",    -- system
        -- "tflint",        -- system
        -- "yamllint",      -- system
        -- "ruff",          -- system
        -- "black",         -- system
        -- "taplo",         -- system
        ---- Go
        -- "golines",       -- system
        -- "gofumpt",       -- system
        -- "goimports",     -- system
        -- "gomodifytags",  -- system
        -- "golangci-lint", -- system
        -- "gotests",       -- system
        -- "iferr",         -- system
        -- "impl",          -- system
      },
    })
  end,
}
