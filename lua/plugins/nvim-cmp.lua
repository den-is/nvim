-- https://github.com/hrsh7th/nvim-cmp
--    https://github.com/hrsh7th/cmp-buffer
--    https://github.com/hrsh7th/cmp-path
--    https://github.com/hrsh7th/cmp-cmdline
--    https://github.com/hrsh7th/cmp-calc
--    https://github.com/saadparwaiz1/cmp_luasnip
-- https://github.com/L3MON4D3/LuaSnip
--    https://github.com/rafamadriz/friendly-snippets
-- https://github.com/onsails/lspkind.nvim
-- 'hrsh7th/cmp-nvim-lsp', -- added as a dependency in lsp.lua
return {
  "hrsh7th/nvim-cmp",
  event = { "InsertEnter", "CmdlineEnter" },

  dependencies = {
    "hrsh7th/cmp-buffer", -- source for text in buffer
    "hrsh7th/cmp-path", -- source for file system paths
    "hrsh7th/cmp-cmdline", -- source for vim's cmdline
    "hrsh7th/cmp-calc", -- source for math calculation
    -- "lukas-reineke/cmp-rg", -- like cmp-buffer but searches whole project TODO: to test
    {
      "L3MON4D3/LuaSnip",
      version = "v2.*",
      -- todo skip if there is no `make` for example on Windows
      build = "make install_jsregexp",
    },
    "saadparwaiz1/cmp_luasnip",
    "rafamadriz/friendly-snippets", -- usefull snippets VSCode like
    "onsails/lspkind.nvim", -- vscode-like pictograms for neovim lsp completion items
  },

  config = function()
    local cmp = require("cmp")
    local luasnip = require("luasnip")
    local lspkind = require("lspkind")

    require("luasnip.loaders.from_vscode").lazy_load()

    cmp.setup({

      completion = {
        completeopt = "menu,menuone,preview,noselect",
      },

      snippet = {
        expand = function(args)
          luasnip.lsp_expand(args.body)
        end,
      },

      window = {
        -- completion    = cmp.config.window.bordered(),
        -- documentation = cmp.config.window.bordered(),
      },

      mapping = cmp.mapping.preset.insert({
        ["<C-k>"] = cmp.mapping.select_prev_item(), -- previous suggestion
        ["<C-j>"] = cmp.mapping.select_next_item(), -- next suggestion
        ["<C-b>"] = cmp.mapping.scroll_docs(-4),
        ["<C-f>"] = cmp.mapping.scroll_docs(4),
        -- ["<C-Space>"] = cmp.mapping.complete(), -- show completion suggestions TODO: what to do with mac using Ctrl-Space to change languages, i don't want to get rid of it. need some other shortcut
        ["<C-S-x>"] = cmp.mapping.complete(), -- show completion suggestions
        ["<C-e>"] = cmp.mapping.abort(), -- close completion window
        ["<CR>"] = cmp.mapping.confirm({ select = false }),
      }),

      sources = cmp.config.sources({
        {
          name = "path",
          option = {
            label_trailing_slash = true, -- Specify if directory names in the completion menu should include a trailing slash.
            trailing_slash = true, -- Specify if completed directory names should include a trailing slash.
          },
        },
        { name = "nvim_lsp" }, -- dependency added in lsp.lua
        { name = "luasnip" },
        { name = "calc" },
        {
          name = "buffer",
          option = {
            get_bufnrs = function()
              --- to get only visible buffers
              -- local bufs = {}
              -- for _, win in ipairs(vim.api.nvim_list_wins()) do
              --   bufs[vim.api.nvim_win_get_buf(win)] = true
              -- end
              -- return vim.tbl_keys(bufs)
              --- to get all buffers
              return vim.api.nvim_list_bufs()
            end,
          },
        },
      }),

      ---@diagnostic disable-next-line: missing-fields
      formatting = {
        -- fields = {},
        -- expandable_indicator = true,
        format = lspkind.cmp_format({
          maxwidth = 50,
          ellipsis_char = "…",
        }),
      },
    })

    -- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore)
    -- Native-menu https://github.com/hrsh7th/nvim-cmp/discussions/1071
    -- by default nvim-cmp is using `custom` native-menu
    cmp.setup.cmdline({ "/", "?" }, {
      mapping = cmp.mapping.preset.cmdline(),
      sources = {
        { name = "buffer" },
      },
    })

    -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
    -- also do not enable vim-native wildmenu
    cmp.setup.cmdline(":", {
      mapping = cmp.mapping.preset.cmdline(),
      ---@diagnostic disable-next-line: missing-fields
      matching = { disallow_symbol_nonprefix_matching = false },
      sources = cmp.config.sources({
        {
          name = "path",
          option = {
            label_trailing_slash = true, -- Specify if directory names in the completion menu should include a trailing slash.
            trailing_slash = true, -- Specify if completed directory names should include a trailing slash.
          },
        },
        { name = "cmdline" },
      }),
    })
  end,
}
