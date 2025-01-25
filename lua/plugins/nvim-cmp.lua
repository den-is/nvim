-- https://github.com/hrsh7th/nvim-cmp
--    https://github.com/hrsh7th/cmp-buffer
--    https://github.com/hrsh7th/cmp-path
--    https://github.com/hrsh7th/cmp-cmdline
--    https://github.com/hrsh7th/cmp-calc
--    https://github.com/saadparwaiz1/cmp_luasnip
-- https://github.com/L3MON4D3/LuaSnip
--    https://github.com/rafamadriz/friendly-snippets
-- https://github.com/onsails/lspkind.nvim - vscode-like pictograms
-- https://www.reddit.com/r/neovim/comments/1bojtr0/please_share_your_nvimcmp_config/
-- 'hrsh7th/cmp-nvim-lsp', -- added as a dependency in lsp.lua
--
-- alternative: https://github.com/Saghen/blink.cmp
--              https://cmp.saghen.dev/#compared-to-nvim-cmp
--
-- :CmpStatus - check status
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
    "hrsh7th/cmp-nvim-lua",
    "ray-x/cmp-treesitter",
    "rafamadriz/friendly-snippets", -- usefull snippets VSCode like
    "onsails/lspkind.nvim", -- vscode-like pictograms for neovim lsp completion items
  },

  config = function()
    local cmp = require("cmp")
    local luasnip = require("luasnip")
    local lspkind = require("lspkind")
    local auto_select = false

    require("luasnip.loaders.from_vscode").lazy_load()

    cmp.setup({

      completion = {
        -- https://neovim.io/doc/user/options.html#'completeopt'
        -- completeopt = "menu,menuone,preview,noselect",
        completeopt = "menu,menuone,preview" .. (auto_select and "" or ",noselect"),
      },

      -- cmp always pops up and even if you don't want to select item, it will insert first item
      -- preselect = cmp.PreselectMode.Item,
      preselect = auto_select and cmp.PreselectMode.Item or cmp.PreselectMode.None,

      snippet = {
        expand = function(args)
          luasnip.lsp_expand(args.body)
        end,
      },

      window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
      },
      -- view = {
      --   entries = {
      --     name = "custom",
      --     selection_order = "near_cursor",
      --     follow_cursor = true,
      --   },
      -- },

      mapping = cmp.mapping.preset.insert({

        -- show completion suggestions
        -- On MacOS <C-Space> is used by the system to change the input language. Should use different keybinding
        -- ["<C-Space>"] = cmp.mapping.complete(),
        ["<C-S-x>"] = cmp.mapping.complete(),

        ["<CR>"] = cmp.mapping.confirm({ select = auto_select, behavior = cmp.ConfirmBehavior.Insert }),
        ["<C-e>"] = cmp.mapping.abort(), -- close completion window
        -- ["<C-j>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
        -- ["<C-k>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
        ["<Tab>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
        ["<S-Tab>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
        ["<C-b>"] = cmp.mapping.scroll_docs(-4),
        ["<C-f>"] = cmp.mapping.scroll_docs(4),
      }),

      sources = cmp.config.sources({
        {
          name = "luasnip",
          group_index = 1,
          option = { use_show_condition = true },
        },
        {
          -- dependency added in lsp.lua
          name = "nvim_lsp",
          group_index = 2,
        },
        {
          name = "treesitter",
          keyword_length = 2,
          group_index = 3,
        },
        {
          name = "path",
          group_index = 4,
          option = {
            label_trailing_slash = true, -- Specify if directory names in the completion menu should include a trailing slash.
            trailing_slash = true, -- Specify if completed directory names should include a trailing slash.
          },
        },
        {
          name = "buffer",
          group_index = 2,
          option = {
            get_bufnrs = function()
              --- to get only visible buffers
              -- local bufs = {}
              -- for _, win in ipairs(vim.api.nvim_list_wins()) do
              --   bufs[vim.api.nvim_win_get_buf(win)] = true
              -- end
              -- return vim.tbl_keys(bufs)
              --
              --- to get all buffers
              return vim.api.nvim_list_bufs()
            end,
          },
        },
        {
          name = "lazydev",
          group_index = 0,
        },
        {
          name = "nvim_lua",
          group_index = 4,
        },
        { name = "calc" },
      }),
      ---@diagnostic disable-next-line: missing-fields
      formatting = {
        -- fields = {},
        -- expandable_indicator = true,
        format = lspkind.cmp_format({
          maxwidth = {
            menu = 50,
            abbr = 50,
          },
          -- ellipsis_char = "…",
          ellipsis_char = "...",
          menu = {
            nvim_lsp = "[lsp]",
            nvim_lua = "[lua]",
            lazydev = "[lua]",
            luasnip = "[snip]",
            buffer = "[buf]",
            path = "[path]",
            calc = "[calc]",
            treesitter = "[tree]",
          },
        }),
      },
    })

    -- Use buffer source for  searches using `/` and `?` (will not work if `native_menu` is enabled)
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
