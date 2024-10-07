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

    local logo1 = {
      [[ _______             ____   ____.__         ]],
      [[ \      \   ____  ___\   \ /   /|__| _____  ]],
      [[ /   |   \_/ __ \/  _ \   Y   / |  |/     \ ]],
      [[/    |    \  ___(  <_> )     /  |  |  Y Y  \]],
      [[\____|__  /\___  >____/ \___/   |__|__|_|  /]],
      [[        \/     \/                        \/ ]],
    }

    local logo2 = {
      "                                                     ",
      "  ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗ ",
      "  ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║ ",
      "  ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║ ",
      "  ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║ ",
      "  ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║ ",
      "  ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝ ",
      "                                                     ",
    }
    -- works with "FiraCode Nerd Font Mono"
    local logo3 = {
      [[                                                                       ]],
      [[                                                                       ]],
      [[                                                                       ]],
      [[                                                                       ]],
      [[                                                                     ]],
      [[       ████ ██████           █████      ██                     ]],
      [[      ███████████             █████                             ]],
      [[      █████████ ███████████████████ ███   ███████████   ]],
      [[     █████████  ███    █████████████ █████ ██████████████   ]],
      [[    █████████ ██████████ █████████ █████ █████ ████ █████   ]],
      [[  ███████████ ███    ███ █████████ █████ █████ ████ █████  ]],
      [[ ██████  █████████████████████ ████ █████ █████ ████ ██████ ]],
      [[                                                                       ]],
      [[                                                                       ]],
      [[                                                                       ]],
    }

    startify.section.header.val = logo1

    startify.section.top_buttons.val = {
      startify.button("e", "New file", "<CMD>ene <CR>"),
      startify.button("q", "Quit Neovim", "<CMD>qa<CR>"),
      startify.button("SPC e", "Open file-explorer sidebar", "<CMD>NvimTreeToggle<CR>"),
      startify.button("SPC ff", "File fuzzy-find in CWD", "<CMD>Telescope find_files<CR>"),
      startify.button("SPC fs", "Word search in CWD", "<CMD>Telescope live_grep<CR>"),
      startify.button("SPC wr", "Restore session for CWD", "<CMD>SessionRestore<CR>"),
    }

    local alpha = require("alpha")
    alpha.setup(startify.config)
  end,
}
