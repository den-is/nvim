-- https://github.com/nvim-treesitter/nvim-treesitter
-- https://github.com/RRethy/nvim-treesitter-endwise
-- https://github.com/nvim-treesitter/nvim-treesitter-context
-- https://github.com/windwp/nvim-ts-autotag
-- https://github.com/nvim-treesitter/nvim-treesitter-textobjects
-- use playground to test treesitter queries:
-- https://tree-sitter.github.io/tree-sitter/playground
return {
  {
    "nvim-treesitter/nvim-treesitter",
    event = { "BufReadPost", "BufNewFile" },
    -- lazy = false,
    branch = "main",
    version = false,
    build = ":TSUpdate",
    dependencies = { "RRethy/nvim-treesitter-endwise" },
    config = function()
      ---@diagnostic disable-next-line: missing-fields
      require("nvim-treesitter").setup({

        indent = { enable = true }, -- Indentation based on treesitter for the = operator. NOTE: This is an experimental feature.
        highlight = { enable = true },
        folds = { enable = true },

        -- A list of parser names, or "all" (the listed parsers MUST always be installed)
        ensure_installed = {
          "bash",
          "cmake",
          "css",
          "comment",
          "dockerfile",
          "go",
          "gomod",
          "gosum",
          "gotmpl",
          "gowork",
          "html",
          "typescript",
          "javascript",
          "json5", -- https://json5.org
          --"json",
          --"jsonnet",
          "jsonc",
          "jsdoc",
          "jsonc",
          "just",
          "lua",
          "luadoc",
          "diff",
          "gitcommit",
          "gitignore",
          "git_rebase",
          "git_config",
          "markdown",
          "markdown_inline",
          "python",
          "printf",
          "query",
          "regex",
          "ruby",
          "sql",
          "hcl",
          "terraform",
          "toml",
          "vim",
          "vimdoc",
          "xml",
          "yaml",
          "tmux",
          "rust",
          "zig",
        },
      })
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    branch = "main",
    event = "VeryLazy",
    opts = {},
    config = function()
      require("nvim-treesitter-textobjects").setup({
        select = {
          lookahead = true,
          include_surrounding_whitespace = false,
        },
        move = {
          set_jumps = true,
        },
      })

      local ts_move = require("nvim-treesitter-textobjects.move")
      local ts_select = require("nvim-treesitter-textobjects.select")

      -- TODO refactor with function
      -- probably something like this: https://github.com/LazyVim/LazyVim/blob/b4606f9df3395a261bb6a09acc837993da5d8bfc/lua/lazyvim/plugins/treesitter.lua#L117
      ---- MOVE ---------------------------------------------------------------
      --------- got_next_start
      vim.keymap.set({ "n", "x", "o" }, "]f", function()
        ts_move.goto_next_start("@function.outer", "textobjects")
      end, { desc = "Next function start", silent = true })
      vim.keymap.set({ "n", "x", "o" }, "]c", function()
        ts_move.goto_next_start("@class.outer", "textobjects")
      end, { desc = "Next class start", silent = true })
      vim.keymap.set({ "n", "x", "o" }, "]a", function()
        ts_move.goto_next_start("@parameter.inner", "textobjects")
      end, { desc = "Next parameter start", silent = true })
      vim.keymap.set({ "n", "x", "o" }, "]b", function()
        ts_move.goto_next_start("@block.outer", "textobjects")
      end, { desc = "Next block start", silent = true })
      vim.keymap.set({ "n", "x", "o" }, "]k", function()
        ts_move.goto_next_start("@comment.outer", "textobjects")
      end, { desc = "Next comment", silent = true })

      --------- goto_next_end
      vim.keymap.set({ "n", "x", "o" }, "]F", function()
        ts_move.goto_next_end("@function.outer", "textobjects")
      end, { desc = "Next function end", silent = true })
      vim.keymap.set({ "n", "x", "o" }, "]C", function()
        ts_move.goto_next_end("@class.outer", "textobjects")
      end, { desc = "Next class end", silent = true })
      vim.keymap.set({ "n", "x", "o" }, "]A", function()
        ts_move.goto_next_end("@parameter.inner", "textobjects")
      end, { desc = "Next parameter end", silent = true })

      --------- goto_previous_start
      vim.keymap.set({ "n", "x", "o" }, "[f", function()
        ts_move.goto_previous_start("@function.outer", "textobjects")
      end, { desc = "Previous function start", silent = true })
      vim.keymap.set({ "n", "x", "o" }, "[c", function()
        ts_move.goto_previous_start("@class.outer", "textobjects")
      end, { desc = "Previous class start", silent = true })
      vim.keymap.set({ "n", "x", "o" }, "[a", function()
        ts_move.goto_previous_start("@parameter.inner", "textobjects")
      end, { desc = "Previous parameter start", silent = true })
      vim.keymap.set({ "n", "x", "o" }, "[b", function()
        ts_move.goto_previous_start("@block.outer", "textobjects")
      end, { desc = "Previous block start", silent = true })
      vim.keymap.set({ "n", "x", "o" }, "[k", function()
        ts_move.goto_previous_start("@comment.outer", "textobjects")
      end, { desc = "Previous comment", silent = true })

      --------- goto_previous_end
      vim.keymap.set({ "n", "x", "o" }, "[F", function()
        ts_move.goto_previous_end("@function.outer", "textobjects")
      end, { desc = "Previous function end", silent = true })
      vim.keymap.set({ "n", "x", "o" }, "[C", function()
        ts_move.goto_previous_end("@class.outer", "textobjects")
      end, { desc = "Previous class end", silent = true })
      vim.keymap.set({ "n", "x", "o" }, "[A", function()
        ts_move.goto_previous_end("@parameter.inner", "textobjects")
      end, { desc = "Previous parameter end", silent = true })

      -- Go to either the start or the end, whichever is closer.
      -- Use if you want more granular movements
      vim.keymap.set({ "n", "x", "o" }, "]d", function()
        ts_move.goto_next("@conditional.outer", "textobjects")
      end, { desc = "Next conditional", silent = true })
      vim.keymap.set({ "n", "x", "o" }, "[d", function()
        ts_move.goto_previous("@conditional.outer", "textobjects")
      end, { desc = "Previous conditional", silent = true })

      ---- SELECT -------------------------------------------------------------
      vim.keymap.set({ "x", "o" }, "af", function()
        ts_select.select_textobject("@function.outer", "textobjects")
      end, { desc = "Select around function", silent = true })
      vim.keymap.set({ "x", "o" }, "if", function()
        ts_select.select_textobject("@function.inner", "textobjects")
      end, { desc = "Select inside function", silent = true })
      vim.keymap.set({ "x", "o" }, "aC", function()
        ts_select.select_textobject("@class.outer", "textobjects")
      end, { desc = "Select around class", silent = true })
      vim.keymap.set({ "x", "o" }, "iC", function()
        ts_select.select_textobject("@class.inner", "textobjects")
      end, { desc = "Select inside class", silent = true })
      vim.keymap.set({ "x", "o" }, "ac", function()
        ts_select.select_textobject("@conditional.outer", "textobjects")
      end, { desc = "Select around conditional", silent = true })
      vim.keymap.set({ "x", "o" }, "ic", function()
        ts_select.select_textobject("@conditional.inner", "textobjects")
      end, { desc = "Select inside conditional", silent = true })
      vim.keymap.set({ "x", "o" }, "al", function()
        ts_select.select_textobject("@loop.outer", "textobjects")
      end, { desc = "Select around loop", silent = true })
      vim.keymap.set({ "x", "o" }, "il", function()
        ts_select.select_textobject("@loop.inner", "textobjects")
      end, { desc = "Select inside loop", silent = true })
      vim.keymap.set({ "x", "o" }, "ad", function()
        ts_select.select_textobject("@comment.outer", "textobjects")
      end, { desc = "Select around comment", silent = true })
      vim.keymap.set({ "x", "o" }, "as", function()
        ts_select.select_textobject("@statement.outer", "textobjects")
      end, { desc = "Select around statement", silent = true })
      vim.keymap.set({ "x", "o" }, "ab", function()
        ts_select.select_textobject("@block.outer", "textobjects")
      end, { desc = "Select around block", silent = true })
      vim.keymap.set({ "x", "o" }, "ib", function()
        ts_select.select_textobject("@block.inner", "textobjects")
      end, { desc = "Select inside block", silent = true })
      -- You can also use captures from other query groups like `locals.scm`
      -- NOTE not working for me https://github.com/nvim-treesitter/nvim-treesitter/blob/main/runtime/queries/d/locals.scm
      -- vim.keymap.set({ "x", "o" }, "as", function()
      --   ts_select.select_textobject("@local.scope", "locals")
      -- end)
    end,
  },
  {
    "windwp/nvim-ts-autotag",
    event = { "BufReadPost", "BufWritePost", "BufNewFile" },
    opts = {},
  },
  {
    "nvim-treesitter/nvim-treesitter-context",
    event = { "BufReadPost", "BufWritePost", "BufNewFile" },
    opts = {
      max_lines = 0,
      multiline_threshold = 2,
    },
  },
}
