-- https://github.com/goolord/alpha-nvim
return {
  "goolord/alpha-nvim",
  event = "VimEnter",
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  config = function()
    local startify = require("alpha.themes.startify")
    startify.file_icons.provider = "devicons"
    -- startify.section.header.val = {
    --   "                                                     ",
    --   "  ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗ ",
    --   "  ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║ ",
    --   "  ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║ ",
    --   "  ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║ ",
    --   "  ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║ ",
    --   "  ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝ ",
    --   "                                                     ",
    -- }
    startify.section.header.val = {
      [[ _______             ____   ____.__         ]],
      [[ \      \   ____  ___\   \ /   /|__| _____  ]],
      [[ /   |   \_/ __ \/  _ \   Y   / |  |/     \ ]],
      [[/    |    \  ___(  <_> )     /  |  |  Y Y  \]],
      [[\____|__  /\___  >____/ \___/   |__|__|_|  /]],
      [[        \/     \/                        \/ ]],
    }

    startify.section.top_buttons.val = {
      startify.button("e", "New file", "<CMD>ene <CR>"),
      startify.button("q", "Quit Neovim", "<CMD>qa<CR>"),
      startify.button("SPC e", "Open file-explorer sidebar", "<CMD>NvimTreeToggle<CR>"),
      startify.button("SPC ff", "File fuzzy-find in cwd", "<CMD>Telescope find_files<CR>"),
      startify.button("SPC fs", "Word search in cwd", "<CMD>Telescope live_grep<CR>"),
      startify.button("SPC wr", "Restore session for cwd", "<CMD>SessionRestore<CR>"),
    }

    local alpha = require("alpha")
    alpha.setup(startify.config)
  end,
}
