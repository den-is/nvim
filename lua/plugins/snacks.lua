-- https://github.com/folke/snacks.nvim
-- alternative logos:
--   local logo1 = {
--     [[ _______             ____   ____.__         ]],
--     [[ \      \   ____  ___\   \ /   /|__| _____  ]],
--     [[ /   |   \_/ __ \/  _ \   Y   / |  |/     \ ]],
--     [[/    |    \  ___(  <_> )     /  |  |  Y Y  \]],
--     [[\____|__  /\___  >____/ \___/   |__|__|_|  /]],
--     [[        \/     \/                        \/ ]],
--   }
--
--   local logo2 = {
--     "                                                     ",
--     "  ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗ ",
--     "  ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║ ",
--     "  ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║ ",
--     "  ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║ ",
--     "  ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║ ",
--     "  ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝ ",
--     "                                                     ",
--   }
--   -- works with "FiraCode Nerd Font Mono"
--   local logo3 = {
--     [[                                                                       ]],
--     [[                                                                       ]],
--     [[                                                                       ]],
--     [[                                                                       ]],
--     [[                                                                     ]],
--     [[       ████ ██████           █████      ██                     ]],
--     [[      ███████████             █████                             ]],
--     [[      █████████ ███████████████████ ███   ███████████   ]],
--     [[     █████████  ███    █████████████ █████ ██████████████   ]],
--     [[    █████████ ██████████ █████████ █████ █████ ████ █████   ]],
--     [[  ███████████ ███    ███ █████████ █████ █████ ████ █████  ]],
--     [[ ██████  █████████████████████ ████ █████ █████ ████ ██████ ]],
--     [[                                                                       ]],
--     [[                                                                       ]],
--     [[                                                                       ]],
--   }
return {
  "folke/snacks.nvim",
  enabled = true,
  priority = 1000,
  lazy = false,
  keys = {
    -- stylua: ignore start
    { "<leader>ut", function() Snacks.picker.undo() end, desc = "Undo Tree" },
    -- { "<leader>sk", function() Snacks.picker.keymaps({ layout = 'select', plugs = true, }) end, desc = "Keymaps" }, -- Telescope without config feels much better
    -- stylua: ignore end
  },
  ---@type snacks.Config
  opts = {
    bigfile = { enabled = true },
    quickfile = { enabled = true },
    dim = { enabled = false }, -- not working for me?
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
          { icon = " ", key = "f", desc = "Find File", action = ":lua Snacks.dashboard.pick('files')" },
          { icon = " ", key = "n", desc = "New File", action = ":ene | startinsert" },
          { icon = " ", key = "g", desc = "Find Text", action = ":lua Snacks.dashboard.pick('live_grep')" },
          { icon = " ", key = "b", desc = "File browser", action = function()  require("yazi").yazi(nil, vim.fn.getcwd()) end},
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
  },
  init = function()
    vim.api.nvim_create_autocmd("User", {
      pattern = "VeryLazy",
      callback = function()
        -- stylua: ignore start
        Snacks.toggle.option("wrap", { name = "Line Wrap" }):map("<leader>tw")
        Snacks.toggle.option("spell", { name = "Spell Check" }):map("<leader>ts")
        Snacks.toggle.inlay_hints():map("<leader>uh")
        Snacks.toggle.dim():map("<leader>ud")
        -- stylua: ignore end
      end,
    })
  end,
}
