-- https://github.com/neovim/nvim-lspconfig
-- https://github.com/antosha417/nvim-lsp-file-operations
-- https://github.com/hrsh7th/cmp-nvim-lsp
--
-- https://neovim.io/doc/user/lsp.html
-- https://neovim.io/doc/user/diagnostic.html
--
-- :LspInfo - view configured LSP for current buffer
-- :h lspconfig-all
return {
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "hrsh7th/cmp-nvim-lsp", -- add source in nvim-cmp.lua
      { "antosha417/nvim-lsp-file-operations", config = true },
      "folke/lazydev.nvim",
    },

    config = function()
      local lspconfig = require("lspconfig")

      local keymap = vim.keymap

      -- register keymaps only on LspAttach event
      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("UserLspConfig", {}),
        callback = function(args)
          vim.diagnostic.config({
            -- Disabling virtual_text diagnostic line side-by-side with the code line
            -- Often does not fit on the screen. Floating window with diagnostics works better
            virtual_text = false,
            signs = {
              text = {
                -- '', '', '', '' -- alternative icons
                [vim.diagnostic.severity.ERROR] = " ",
                [vim.diagnostic.severity.WARN] = " ",
                [vim.diagnostic.severity.INFO] = " ",
                [vim.diagnostic.severity.HINT] = "󰠠 ",
              },
              linehl = {
                [vim.diagnostic.severity.ERROR] = "ErrorMsg",
                [vim.diagnostic.severity.WARN] = "WarningMsg",
              },
              -- numhl = {
              --   [vim.diagnostic.severity.ERROR] = "ErrorMsg",
              --   [vim.diagnostic.severity.WARN] = "WarningMsg",
              -- },
            },
            underline = true,
            update_in_insert = true,
            severity_sort = false,
          })

          -- create autocmd to show floating diagnostic message on hover
          vim.api.nvim_create_autocmd("CursorHold", {
            buffer = args.buf,
            callback = function()
              local opts = {
                focusable = false,
                close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
                border = "rounded",
                source = "always",
                prefix = " ",
                -- scope = "cursor",
                scope = "line", -- pop-up diagnostic message on line instead of exact cursor position
              }
              vim.diagnostic.open_float(nil, opts)
            end,
          })

          -- Buffer local mappings.
          -- See `:help vim.lsp.*` for docs on any of the below functions
          local opts = { buffer = args.buf, silent = true }

          -- set keybinds
          opts.desc = "Go to declaration"
          keymap.set("n", "gD", vim.lsp.buf.declaration, opts)

          opts.desc = "Go to defintion"
          keymap.set("n", "<leader>gd", vim.lsp.buf.definition, opts)

          opts.desc = "Format code"
          keymap.set({ "n", "x" }, "<leader>gf", vim.lsp.buf.format, opts)

          opts.desc = "Show LSP references"
          keymap.set("n", "gR", "<CMD>Telescope lsp_references<CR>", opts)

          opts.desc = "Show LSP definitions"
          keymap.set("n", "gd", "<CMD>Telescope lsp_definitions<CR>", opts)

          opts.desc = "Show LSP implementations"
          keymap.set("n", "gi", "<CMD>Telescope lsp_implementations<CR>", opts)

          opts.desc = "Show LSP type definitions"
          keymap.set("n", "gt", "<CMD>Telescope lsp_type_definitions<CR>", opts)

          opts.desc = "See available code actions"
          keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts)

          opts.desc = "Smart rename"
          keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)

          opts.desc = "Show line diagnostics"
          keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts)

          opts.desc = "Go to previous diagnostic"
          keymap.set("n", "[d", function()
            vim.diagnostic.jump({ count = -1, float = true })
          end, opts)

          opts.desc = "Go to next diagnostic"
          keymap.set("n", "[d", function()
            vim.diagnostic.jump({ count = 1, float = true })
          end, opts)

          opts.desc = "Show documentation for what is under cursor"
          keymap.set("n", "K", vim.lsp.buf.hover, opts)

          opts.desc = "Restart LSP"
          keymap.set("n", "<leader>rs", "<CMD>LspRestart<CR>", opts)

          ---- Inlay Hints are provided by Language Servers and should be enabled there
          opts.desc = "Enable Inlay hints"
          keymap.set("n", "<leader>i", function()
            local status = vim.lsp.inlay_hint.is_enabled() and "OFF" or "ON"
            vim.api.nvim_echo({ { "Toggling inlay hints " .. status, "Normal" } }, true, {})
            vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
          end, opts)
        end,
      })

      local servers = {
        bashls = {},
        dockerls = {},
        templ = {},
        tflint = {},
        helm_ls = {},
        vimls = {},
        html = {},
        ansiblels = {},
        docker_compose_language_service = {},

        -- https://github.com/neovim/nvim-lspconfig/blob/master/lua/lspconfig/configs/terraformls.lua
        terraformls = {},
        gopls = {
          settings = {
            gofumpt = true,
            codelenses = {
              gc_details = false,
              generate = true,
              regenerate_cgo = true,
              run_govulncheck = true,
              test = true,
              tidy = true,
              upgrade_dependency = true,
              vendor = true,
            },
            hints = {
              assignVariableTypes = true,
              compositeLiteralFields = true,
              compositeLiteralTypes = true,
              constantValues = true,
              functionTypeParameters = true,
              parameterNames = true,
              rangeVariableTypes = true,
            },
            analyses = {
              fieldalignment = true,
              nilness = true,
              unusedparams = true,
              unusedwrite = true,
              useany = true,
            },
            usePlaceholders = true,
            completeUnimported = true,
            staticcheck = true,
            directoryFilters = { "-.git", "-.vscode", "-.idea", "-.vscode-test", "-node_modules" },
            semanticTokens = true,
          },
        },
        -- https://github.com/neovim/nvim-lspconfig/blob/master/lua/lspconfig/configs/pyright.lua
        pyright = {
          -- Pyright configuration
          -- you need to provide pyrightconfig.json in your projects/workspaces root directories for pyright to work with virtualenvs
          -- https://microsoft.github.io/pyright/#/getting-started?id=_1-initial-type-checking
          -- https://microsoft.github.io/pyright/#/configuration
          -- https://stackoverflow.com/questions/65847159/how-to-set-python-interpreter-in-neovim-for-python-language-server-depending-on/66559305#66559305
          --
          -- Example minimal pyrightconfig.json that worked for me:
          -- {
          --   "include": [
          --     "./",
          --   ]
          -- }
          settings = {
            python = {
              analysis = {
                autoSearchPaths = true,
                useLibraryCodeForTypes = true,
                diagnosticMode = "openFilesOnly",
              },
            },
          },
        },
        lua_ls = {
          settings = {
            diagnostics = {
              -- make the language server recognize "vim" global
              globals = { "vim" },
              -- disable warnings for LuaLS globally
              -- or use annotations `---@diagnostic disable-next-line: missing-fields` or `---@diagnostic disable: missing-fields`
              --
              -- disable = { "missing-parameters", "missing-fields" },
            },
            telemetry = { enable = false },
            hint = { enable = true },
            Lua = {
              workspace = {
                checkThirdParty = false,
              },
              codeLens = {
                enable = true,
              },
              doc = {
                privateName = { "^_" },
              },
              hint = {
                enable = true,
                setType = false,
                paramType = true,
                paramName = "Disable",
                semicolon = "Disable",
                arrayIndex = "Disable",
              },
              completion = {
                callSnippet = "Replace",
              },
              -- You can toggle below to ignore Lua_LS's noisy `missing-fields` warnings
              -- diagnostics = { disable = { 'missing-fields' } },
            },
          },
        },
        yamlls = {
          settings = {
            redhat = { telemetry = { enabled = false } },
            yaml = {
              -- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#yamlls
              -- mainly got this configs from:
              -- https://github.com/Allaman/nvim/blob/main/lua/core/plugins/lsp/lsp.lua
              -- https://github.com/Allaman/nvim/blob/main/lua/core/plugins/lsp/settings/yaml.lua
              -- if we do not disable this we get error while trying to create/edit kubernetes manifest:
              --   "Matches multiple schemas when only one must validate. yaml-schema: https://raw.githubusercontent.com/yannh/kubernetes-json-schema/master/v1.22.4-standalone-strict/all.json"
              format = { enabled = false },
              validate = false,
              -- completion = true,
              hover = true,
              schemaStore = {
                enable = true,
                url = "https://www.schemastore.org/api/json/catalog.json",
              },
              schemas = {
                kubernetes = "*.{yml,yaml}",
                ["http://json.schemastore.org/github-workflow"] = ".github/workflows/*",
                ["http://json.schemastore.org/github-action"] = ".github/action.{yml,yaml}",
                ["https://raw.githubusercontent.com/microsoft/azure-pipelines-vscode/master/service-schema.json"] = "azure-pipelines*.{yml,yaml}",
                ["https://raw.githubusercontent.com/ansible/ansible-lint/main/src/ansiblelint/schemas/ansible.json#/$defs/tasks"] = "roles/tasks/*.{yml,yaml}",
                ["https://raw.githubusercontent.com/ansible/ansible-lint/main/src/ansiblelint/schemas/ansible.json#/$defs/playbook"] = "*play*.{yml,yaml}",
                ["http://json.schemastore.org/prettierrc"] = ".prettierrc.{yml,yaml}",
                ["http://json.schemastore.org/kustomization"] = "kustomization.{yml,yaml}",
                ["http://json.schemastore.org/chart"] = "Chart.{yml,yaml}",
                ["https://json.schemastore.org/dependabot-v2"] = ".github/dependabot.{yml,yaml}",
                ["https://gitlab.com/gitlab-org/gitlab/-/raw/master/app/assets/javascripts/editor/schema/ci.json"] = "*gitlab-ci*.{yml,yaml}",
                ["https://raw.githubusercontent.com/OAI/OpenAPI-Specification/main/schemas/v3.1/schema.json"] = "*api*.{yml,yaml}",
                ["https://raw.githubusercontent.com/compose-spec/compose-spec/master/schema/compose-spec.json"] = "*docker-compose*.{yml,yaml}",
                ["https://raw.githubusercontent.com/argoproj/argo-workflows/master/api/jsonschema/schema.json"] = "*flow*.{yml,yaml}",
              },
            },
          },
        },
      }

      -- local mason_lspconfig = require("mason-lspconfig")
      -- ensure_installed mason and mason_lspconfig are configured in mason.lua
      -- local ensure_installed = vim.tbl_keys(servers or {})
      -- require('mason-lspconfig').setup({
      --   ensure_installed = ensure_installed
      -- })

      -- used to enable autocompletion (assigned to every lsp server's config)
      local capabilities = require("cmp_nvim_lsp").default_capabilities()
      -- add folding capabilities (managed by nvim-ufo)
      capabilities.textDocument.foldingRange = {
        dynamicRegistration = false,
        lineFoldingOnly = true,
      }

      for server, server_opts in pairs(servers) do
        server_opts.capabilities = vim.tbl_deep_extend("force", {}, capabilities, server_opts.capabilities or {})
        vim.lsp.config(server, server_opts)
        vim.lsp.enable(server)
      end
    end,
  },
  -- https://github.com/nvimdev/lspsaga.nvim
  {
    "nvimdev/lspsaga.nvim",
    after = "nvim-lspconfig",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-tree/nvim-web-devicons",
    },
    config = function()
      require("lspsaga").setup({})
    end,
  },
}
