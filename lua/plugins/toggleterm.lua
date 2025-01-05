-- https://github.com/akinsho/toggleterm.nvim
-- https://github.com/Allaman/nvim/blob/main/lua/core/plugins/toggleterm.lua
return {
  "akinsho/toggleterm.nvim",
  version = "*",
  cmd = "ToggleTerm",
  keys = "<C-n>",
  config = function()
    local toggleterm = require("toggleterm")
    toggleterm.setup({
      open_mapping = "<C-n>",
      autochdir = true,
      start_in_insert = true,
      direction = "horizontal", -- 'vertical' | 'horizontal' | 'tab' | 'float',
      shade_terminals = true,
      shading_factor = "-10", -- the percentage by which to lighten dark terminal background, default: -30
      persist_size = true,
      -- size can be a number or function which is passed the current terminal
      size = function(term)
        if term.direction == "horizontal" then
          return 15
        elseif term.direction == "vertical" then
          return vim.o.columns * 0.4
        end
      end,
    })

    -- Better navigation to and from terminal
    local buf_map = vim.api.nvim_buf_set_keymap
    local map_opts = { noremap = true }
    local set_terminal_keymaps = function()
      buf_map(0, "t", "<esc>", [[<C-\><C-n>]], map_opts)
      buf_map(0, "t", "jj", [[<C-\><C-n>]], map_opts)
      buf_map(0, "t", "<C-h>", [[<C-\><C-n><C-W>h]], map_opts)
      buf_map(0, "t", "<C-j>", [[<C-\><C-n><C-W>j]], map_opts)
      buf_map(0, "t", "<C-k>", [[<C-\><C-n><C-W>k]], map_opts)
      buf_map(0, "t", "<C-l>", [[<C-\><C-n><C-W>l]], map_opts)
    end
    -- if you only want these mappings for toggle term use term://*toggleterm#* instead
    vim.api.nvim_create_autocmd("TermOpen", {
      pattern = "term://*",
      callback = function()
        set_terminal_keymaps()
        vim.cmd([[setlocal nospell]])
      end,
      desc = "Mappings for navigation with a terminal",
    })

    -- Example Custom Neovim Commands - shortcuts to run predefined commands in the terminal
    vim.api.nvim_create_user_command("Exec", function(opts)
      require("toggleterm").exec(opts.args)
    end, { desc = "Run TermExec with the given command", nargs = "*" })

    vim.api.nvim_create_user_command("Tldr", function(opts)
      require("toggleterm").exec("tldr " .. opts.args)
    end, { desc = "Run tldr with the given argument", nargs = 1 })
  end,
}
