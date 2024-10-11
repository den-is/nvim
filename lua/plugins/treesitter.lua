-- https://github.com/nvim-treesitter/nvim-treesitter
-- https://github.com/RRethy/nvim-treesitter-endwise
-- https://github.com/nvim-treesitter/nvim-treesitter-context
-- https://github.com/windwp/nvim-ts-autotag
-- https://github.com/nvim-treesitter/nvim-treesitter-textobjects
return {
  "nvim-treesitter/nvim-treesitter",
  event = { "BufReadPost", "BufNewFile" },
  dependencies = {
    "RRethy/nvim-treesitter-endwise",
    "nvim-treesitter/nvim-treesitter-context",
    "nvim-treesitter/nvim-treesitter-textobjects",
    "windwp/nvim-ts-autotag",
  },
  build = ":TSUpdate",
  config = function()
    ---@diagnostic disable-next-line: missing-fields
    require("nvim-treesitter.configs").setup({
      sync_install = false,
      highlight = { enable = true },
      indent = { enable = true }, -- Indentation based on treesitter for the = operator. NOTE: This is an experimental feature.
      endwise = { enable = true },
      autopairs = { enable = true },
      -- A list of parser names, or "all" (the listed parsers MUST always be installed)
      ensure_installed = {
        "bash",
        "cmake",
        "css",
        "dockerfile",
        "go",
        "gomod",
        "gosum",
        "gotmpl",
        "gowork",
        "hcl",
        "html",
        "javascript",
        "json5", -- https://json5.org
        --"json",
        --"jsonnet",
        "jsonc",
        "lua",
        "diff",
        "gitcommit",
        "gitignore",
        "git_rebase",
        "git_config",
        "markdown",
        "markdown_inline",
        "python",
        "query",
        "regex",
        "ruby",
        "sql",
        "terraform",
        "toml",
        "vim",
        "yaml",
      },

      incremental_selection = {
        enable = true,
        keymaps = {
          -- mappings for incremental selection (visual mappings)
          -- set to `false` to disable one of the mappings
          init_selection = "gnn", -- maps in normal mode to init the node/scope selection
          node_incremental = "grn", -- increment to the upper named parent
          scope_incremental = "grc", -- increment to the upper scope (as defined in locals.scm)
          node_decremental = "grm", -- decrement to the previous node
        },
      },

      textobjects = {

        -- peek_definition_code:
        -- show textobject surrounding definition as determined using Neovim's built-in LSP in a floating window.
        -- Press the shortcut twice to enter the floating window.
        lsp_interop = {
          enable = true,
          border = "none",
          floating_preview_opts = {},
          peek_definition_code = {
            ["<leader>df"] = "@function.outer",
            ["<leader>dF"] = "@class.outer",
          },
        },

        keymaps = {
          ["iL"] = {
            -- you can define your own textobjects directly here
            go = "(function_definition) @function",
          },
          -- or you use the queries from supported languages with textobjects.scm
          ["af"] = "@function.outer",
          ["if"] = "@function.inner",
          ["aC"] = "@class.outer",
          ["iC"] = "@class.inner",
          ["ac"] = "@conditional.outer",
          ["ic"] = "@conditional.inner",
          ["ae"] = "@block.outer",
          ["ie"] = "@block.inner",
          ["al"] = "@loop.outer",
          ["il"] = "@loop.inner",
          ["is"] = "@statement.inner",
          ["as"] = "@statement.outer",
          ["ad"] = "@comment.outer",
          ["am"] = "@call.outer",
          ["im"] = "@call.inner",
        },

        select = {
          enable = true,
          -- Automatically jump forward to textobj, similar to targets.vim
          lookahead = true,
          -- If you set this to `true` (default is `false`) then any textobject is
          -- extended to include preceding or succeeding whitespace. Succeeding
          -- whitespace has priority in order to act similarly to eg the built-in `ap`.
          include_surrounding_whitespace = true,
          keymaps = {
            -- You can use the capture groups defined in textobjects.scm
            ["af"] = "@function.outer",
            ["if"] = "@function.inner",
            ["ac"] = "@class.outer",
            ["ic"] = "@class.inner",
          },
        },

        move = {
          enable = true,
          set_jumps = true, -- whether to set jumps in the jumplist
          goto_next_start = {
            ["]m"] = "@function.outer",
            ["]]"] = { query = "@class.outer", desc = "Next class start" },
          },
          goto_next_end = {
            ["]M"] = "@function.outer",
            ["]["] = "@class.outer",
          },
          goto_previous_start = {
            ["[m"] = "@function.outer",
            ["[["] = "@class.outer",
          },
          goto_previous_end = {
            ["[M"] = "@function.outer",
            ["[]"] = "@class.outer",
          },
        },

        -- swap for example funtion args or params
        -- default keymap conflicts with Harpoon2 "append" action
        -- swap = {
        --   enable = true,
        --   swap_next = {
        --     ["<leader>a"] = "@parameter.inner",
        --   },
        --   swap_previous = {
        --     ["<leader>A"] = "@parameter.inner",
        --   },
        -- },
      },
    })

    require("nvim-ts-autotag").setup()
    require("treesitter-context").setup()
  end,
}
