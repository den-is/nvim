-- https://github.com/folke/snacks.nvim

-- highly depends on `rg` ripgrep beind installed

-- default Pickers keymaps https://github.com/folke/snacks.nvim/blob/f33aa2017/docs/picker.md?plain=1#L216-L266

-- list all styles for windows https://github.com/folke/snacks.nvim/blob/main/docs/styles.md
-- :lua Snacks.picker.picker_layouts() list all layouts
-- :lua Snacks.picker.pickers() list all pickers

return {
  "folke/snacks.nvim",
  enabled = true,
  priority = 1000,
  lazy = false,
  dependencies = {
    "nvim-tree/nvim-web-devicons",
    "nvim-lua/plenary.nvim",
  },
  keys = {
    -- stylua: ignore start
    -- Files
    { "<leader>ff", function() Snacks.picker.files({
      filter = {cwd = true},
      layout = {preset = "vscode"},
      -- defaul commands args https://github.com/folke/snacks.nvim/blob/f33aa2017a2671fb4a0e71316f385c8010c8b81b/lua/snacks/picker/source/files.lua#L13
      cmd = "rg",
      hidden = true,
      ignored = true,
      exclude = {
        -- ".git", -- excluded by default
        "node_modules",
        ".venv",
        ".direnv",
        "__pycache__",
      },
    }) end, desc = "Find files in CWD" },
    { "<leader>fr", function() Snacks.picker.recent({ filter = {cwd = true}, layout = {preset = "vscode"} }) end, desc = "Recent files in CWD" },
    { "<leader>fz", function() Snacks.picker.zoxide() end, desc = "Open project from Zoxide" },

    -- Grep
    { "<leader>fl", function() Snacks.picker.lines() end, desc = "Find line in Buffer" },
    { "<leader>fs", function() Snacks.picker.grep({
      hidden = true,
      ignored = true,
      exclude = {
        -- ".git", -- excluded by default
        "node_modules",
        ".venv",
        ".direnv",
        "__pycache__",
      },
    }) end, desc = "Grep" },
    { "<leader>fw", function() Snacks.picker.grep_word({
      hidden = true,
      ignored = true,
      exclude = {
        "node_modules",
        ".venv",
        ".direnv",
        "__pycache__",
      },
    }) end, desc = "Grep word or visual selection, in CWD", mode = { "n", "x" } },

    -- Buffers
    { "<leader>fb", function() Snacks.picker.buffers({layout = {preset = "vscode"}}) end, desc = "Buffers list (C-x - :bd)" },
    { "<leader>bd", function() Snacks.bufdelete() end, desc = "Delete Buffer" },
    { "<leader>ut", function() Snacks.picker.undo() end, desc = "Undo Tree" },
    { "<leader>fR", function() Snacks.rename.rename_file() end, desc = "Rename File" },

    -- LSP
    -- Default keys since neovim 0.11 https://neovim.io/doc/user/news-0.11.html#_defaults
    { "<leader>ls", function() Snacks.picker.lsp_symbols({
      tree = true,
      filter = {
        markdown = true,
        help = true,
        default = {
          "Variable",
          "Array",
          "Class",
          "Function",
          "Method",
          "Constructor",
          "Interface",
          "Module",
          "Struct",
          "Field",
          "Enum",
          "Namespace",
          "Property",
          "Trait",
          -- "Package", -- remove package since luals uses it for control flow structures. Use per filetype filter
        }
      }
    }) end, desc = "LSP - Document symbols" },
    { "<leader>lS", function() Snacks.picker.lsp_workspace_symbols() end, desc = "LSP - Workspace Symbols" },
    { "<leader>lr", function() Snacks.picker.lsp_references() end, nowait = true, desc = "LSP - References" }, -- grr - default qflist
    { "<leader>ld", function() Snacks.picker.lsp_definitions() end, desc = "LSP - Definition" }, -- grt
    { "<leader>lI", function() Snacks.picker.lsp_implementations() end, desc = "LSP - Implementation" }, -- gri
    { "<leader>lt", function() Snacks.picker.lsp_type_definitions() end, desc = "LSP - Type Definition" }, -- grt
    { "<leader>fd", function() Snacks.picker.diagnostics() end, desc = "Diagnostics" },
    { "<leader>fD", function() Snacks.picker.diagnostics_buffer() end, desc = "Buffer Diagnostics" },

    -- Git
    { "<leader>go", mode = {"n", "v"}, function() Snacks.gitbrowse() end, desc = "Open git link" },
    { "<leader>gc", mode = {"n", "v"}, function() Snacks.gitbrowse({ open = function(url) vim.fn.setreg("+", url) end, notify = false })end, desc = "Copy git link" },

    -- Var
    { "<leader>fS", function() Snacks.picker.spelling() end, desc = "Spelling" },
    { "<leader>fk", function() Snacks.picker.keymaps({layout = {preset = "ivy", hidden = {"preview"},}}) end, desc = "Keymaps" },
    { "<leader>fh", function() Snacks.picker.help() end, desc = "Find help tags" },
    { "<leader>fm", function() Snacks.picker.marks() end, desc = "Marks" },
    { "<leader>un", function() Snacks.picker.notifications({
      layout = {preset = "ivy", hidden = {"preview"},},
      win = {
        preview = {
          wo = {
            wrap = true,
            linebreak = true,
            breakindent = true, -- optional
          },
        },
      },
    }) end, desc = "Notifications" },
    { "<leader>sR", function() Snacks.picker.resume() end, desc = "Snacks Resume picker" },
    -- { "<c-n>",      function() Snacks.terminal() end, desc = "Toggle Terminal" },
    -- stylua: ignore end
  },
  ---@type snacks.Config
  opts = {
    bigfile = {
      enabled = true,
      notify = true,
      size = 1 * 1024 * 1024, -- 1 MB
      line_length = 1000,
      -- setup = function(ctx)
      --   -- ...
      --   -- tresitter already not starting for `bigfile` filetype
      --   -- vim.treesitter.stop(ctx.buf)
      --   -- ...
      -- end,
    },
    quickfile = { enabled = true },
    dim = { enabled = false }, -- <leader>ud toggle
    image = {}, -- for kitty, wezterm and ghostty
    input = { enabled = true },
    statuscolumn = { enabled = true },
    words = { enabled = true },
    indent = {
      enabled = true,
      indent = { only_scope = true }, -- only show indent where cursor is
      chunk = { enabled = true }, -- indents are rendered as chunks
      animate = { enabled = false },
    },
    notifier = {
      enabled = true,
      timeout = 2000,
    },
    styles = {
      notification = {
        wo = {
          wrap = true,
          linebreak = true,
          breakindent = true, -- optional, nicer for stacktraces
        },
      },
    },
    dashboard = {
      enabled = true,
      preset = {
        ---@type snacks.dashboard.Item[]
        pick = nil, -- for now using Telescope
        keys = {
          -- stylua: ignore start
          -- for now using Telescope instead of Snacks.picker
          -- { icon = " ", key = "f", desc = "Find File", action = ":lua Snacks.picker.smart({filter = {cwd = true}, layout = 'default'})" },
          -- { icon = " ", key = "s", desc = "Find Text", action = ":lua Snacks.picker.grep({layout = 'default'})" },
          -- { icon = " ", key = "f", desc = "Find File", action = ":lua Snacks.dashboard.pick('files')" },
          -- { icon = " ", key = "g", desc = "Find Text", action = ":lua Snacks.dashboard.pick('live_grep')" },
          { icon = " ", key = "n", desc = "New File", action = ":ene | startinsert" },
          {
            icon = " ",
            key = "f",
            desc = "Find File in CWD",
            action = function()
              Snacks.picker.files({
                filter = {cwd = true},
                layout = {preset = "vscode"},
                cmd = "rg",
                hidden = true,
                ignored = true,
                exclude = {
                  -- ".git", -- excluded by default
                  "node_modules",
                  ".venv",
                  ".direnv",
                  "__pycache__",
                },
              })
            end
          },
          {
            icon = " ",
            key = "g",
            desc = "Find Text in CWD",
            action = function()
              Snacks.picker.grep({
                hidden = true,
                ignored = true,
                exclude = {
                  -- ".git", -- excluded by default
                  "node_modules",
                  ".venv",
                  ".direnv",
                  "__pycache__",
                },
              })
            end
          },
          { icon = " ", key = "b", desc = "File browser", action = function() require("yazi").yazi(nil, vim.fn.getcwd()) end},
          { icon = "󰒲 ", key = "l", desc = "Lazy", action = ":Lazy check", enabled = package.loaded.lazy },
          { icon = " ", key = "q", desc = "Quit", action = ":qa" },
          -- stylua: ignore end
        },
      },
      sections = {
        { section = "header" },
        { section = "keys", padding = { 1, 0 } },
        { title = "Recent Files", section = "recent_files", limit = 8, cwd = true, padding = 1 },
        { section = "startup" },
      },
    },
    ---@class snacks.picker.Config
    picker = {
      enabled = true,
      ui_select = true,
    },
  },
  init = function()
    vim.api.nvim_create_autocmd("User", {
      pattern = "VeryLazy",
      callback = function()
        -- stylua: ignore start
        Snacks.toggle.option("wrap", { name = "Line Wrap" }):map("<leader>uw")
        Snacks.toggle.option("spell", { name = "Spell Check" }):map("<leader>us")
        Snacks.toggle.option("cursorcolumn", { name = "Cursor Column" }):map("<leader>uc")
        Snacks.toggle.inlay_hints():map("<leader>uh")
        Snacks.toggle.dim():map("<leader>ud")
        -- stylua: ignore end
      end,
    })
  end,
}
