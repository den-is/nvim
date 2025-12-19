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
      local ts = require("nvim-treesitter")
      local ts_cfg = require("nvim-treesitter.config")
      local parsers = require("nvim-treesitter.parsers")

      local ensure_installed = {
        "bash",
        "c",
        "cmake",
        "comment",
        "css",
        "diff",
        "dockerfile",
        "git_config",
        "git_rebase",
        "gitcommit",
        "gitignore",
        "go",
        "gomod",
        "gosum",
        "gotmpl",
        "gowork",
        "groovy",
        "hcl",
        "html",
        "javascript",
        "jsdoc",
        "json",
        -- "jsonnet",
        -- "json5", -- https://json5.org
        "just",
        "lua",
        "luadoc",
        "markdown",
        "markdown_inline",
        "printf",
        "python",
        "query",
        "regex",
        "ruby",
        "rust",
        "sql",
        "terraform",
        "tmux",
        "toml",
        "typescript",
        "vim",
        "vimdoc",
        "xml",
        "yaml",
        "zig",
        "zsh",
      }
      local installed = ts_cfg.get_installed()
      local to_install = vim
        .iter(ensure_installed)
        :filter(function(parser)
          return not vim.tbl_contains(installed, parser)
        end)
        :totable()

      if #to_install > 0 then
        ts.install(to_install)
      end

      local ignore_filetype = {
        "checkhealth",
        "lazy",
        "mason",
        "snacks_dashboard",
        "snacks_notif",
        "snacks_win",
        "snacks_input",
        "snacks_picker_input",
        "TelescopePrompt",
        "alpha",
        "dashboard",
        "spectre_panel",
        "NvimTree",
        "undotree",
        "Outline",
        "sagaoutline",
        "copilot-chat",
        "vscode-diff-explorer",
      }

      local group = vim.api.nvim_create_augroup("TreesitterSetup", { clear = true })

      vim.api.nvim_create_autocmd("FileType", {
        group = group,
        desc = "Enable TreeSitter highlighting and indentation",
        callback = function(ev)
          local ft = ev.match

          if vim.tbl_contains(ignore_filetype, ft) then
            return
          end

          local lang = vim.treesitter.language.get_lang(ft) or ft
          local buf = ev.buf
          pcall(vim.treesitter.start, buf, lang)

          vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
          vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
        end,
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
      -- vim.keymap.set({ "n", "x", "o" }, "]a", function()
      --   ts_move.goto_next_start("@parameter.inner", "textobjects")
      -- end, { desc = "Next parameter start", silent = true })
      -- ]b is Nvim default https://neovim.io/doc/user/news-0.11.html#_defaults
      vim.keymap.set({ "n", "x", "o" }, "]w", function()
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
      -- vim.keymap.set({ "n", "x", "o" }, "]A", function()
      --   ts_move.goto_next_end("@parameter.inner", "textobjects")
      -- end, { desc = "Next parameter end", silent = true })

      --------- goto_previous_start
      vim.keymap.set({ "n", "x", "o" }, "[f", function()
        ts_move.goto_previous_start("@function.outer", "textobjects")
      end, { desc = "Previous function start", silent = true })
      vim.keymap.set({ "n", "x", "o" }, "[c", function()
        ts_move.goto_previous_start("@class.outer", "textobjects")
      end, { desc = "Previous class start", silent = true })
      -- vim.keymap.set({ "n", "x", "o" }, "[a", function()
      --   ts_move.goto_previous_start("@parameter.inner", "textobjects")
      -- end, { desc = "Previous parameter start", silent = true })
      -- [b is Nvim default https://neovim.io/doc/user/news-0.11.html#_defaults
      vim.keymap.set({ "n", "x", "o" }, "[w", function()
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
      -- vim.keymap.set({ "n", "x", "o" }, "[A", function()
      --   ts_move.goto_previous_end("@parameter.inner", "textobjects")
      -- end, { desc = "Previous parameter end", silent = true })

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
      vim.keymap.set({ "x", "o" }, "ak", function()
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
  -- https://github.com/Wansmer/treesj
  -- Neovim plugin for splitting/joining blocks of code like arrays, hashes,
  -- statements, objects, dictionaries, etc
  {
    {
      "Wansmer/treesj",
      keys = {
        { "<leader>mS", "", desc = "TreeSJ" },
        { "<leader>mSt", "<CMD>TSJToggle<CR>", desc = "Toggle" },
        { "<leader>mSj", "<CMD>TSJJoin<CR>", desc = "Join" },
        { "<leader>mSs", "<CMD>TSJSplit<CR>", desc = "Split" },
      },
      dependencies = { "nvim-treesitter/nvim-treesitter" },
      opts = {
        use_default_keymaps = false,
      },
      config = true,
    },
  },
}
