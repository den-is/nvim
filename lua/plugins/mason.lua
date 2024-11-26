-- https://github.com/williamboman/mason.nvim
-- https://github.com/williamboman/mason-lspconfig.nvim
return {
  "williamboman/mason.nvim",
  event = "VeryLazy",
  dependencies = {
    "williamboman/mason-lspconfig.nvim",
    "WhoIsSethDaniel/mason-tool-installer.nvim",
  },
  config = function()
    local mason = require("mason")
    local mason_lspconfig = require("mason-lspconfig")
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

    mason_lspconfig.setup({
      ensure_installed = {
        "html",
        "lua_ls",
        "pyright",
        "ansiblels",
        "bashls",
        "docker_compose_language_service",
        "dockerls",
        "gopls",
        "jqls",
        "jsonls",
        "helm_ls",
        "terraformls",
        "yamlls",
        "pyright",
        "vimls",
      },
    })

    mason_tool_installer.setup({
      -- check which linters are already available on system
      ensure_installed = {
        ---- Formatters
        "prettier",
        "stylua",
        -- I already have most of these install on my system, outside NVIM:
        -- "shfmt",         -- system
        ---- Linters
        -- "eslint_d",      -- system
        -- "shellcheck",    -- system
        -- "tflint",        -- system
        -- "yamllint",      -- system
        -- "ruff",          -- system
        -- "black",         -- system
        ---- Go
        -- "gofumpt",       -- system
        -- "goimports",     -- system
        -- "gomodifytags",  -- system
        -- "golangci-lint", -- system
        -- "gotests", i     -- system
        -- "iferr",         -- system
        -- "impl",          -- system
      },
    })
  end,
}
