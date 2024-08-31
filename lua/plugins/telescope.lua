-- https://github.com/nvim-telescope/telescope.nvim
-- https://github.com/nvim-telescope/telescope-fzf-native.nvim
return {
  "nvim-telescope/telescope.nvim",
  branch = "0.1.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    "nvim-tree/nvim-web-devicons",
    "folke/todo-comments.nvim",
  },
  config = function()
    local telescope = require("telescope")
    local actions = require("telescope.actions")

    telescope.setup({
      defaults = {
        path_display = { "smart" },
        preview = {
          filesize_limit = 0.1, -- MB
        },
        mappings = {
          i = {
            ["<C-k>"] = actions.move_selection_previous,
            ["<C-j>"] = actions.move_selection_next,
            ["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
            ["<C-d>"] = actions.delete_buffer,
          },
        },
      },
      pickers = {
        find_files = {
          -- theme = "dropdown",
          -- fd --hidden --no-ignore --exclude '\.git' --type f --color never
          find_command = {
            "rg",
            "--files",
            "--hidden",
            "--no-ignore-vcs",
            "--glob",
            "!**/.git/*",
            "--color",
            "never",
          },
        },
      },
    })

    telescope.load_extension("fzf")

    local builtin = require("telescope.builtin")
    local map = vim.keymap
    map.set("n", "<C-p>", "<cmd>Telescope find_files<cr>", { desc = "Fuzzy find files in cwd" })
    map.set("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "Fuzzy find files in cwd" })
    map.set("n", "<leader>fr", "<cmd>Telescope oldfiles<cr>", { desc = "Fuzzy find recent files" })
    map.set("n", "<leader>fs", "<cmd>Telescope live_grep<cr>", { desc = "Find string in cwd" })
    map.set("n", "<leader>fc", "<cmd>Telescope grep_string<cr>", { desc = "Find string under cursor in cwd" })
    map.set("n", "<leader>fb", builtin.buffers, { desc = "Fuzzy find buffers" })
    map.set("n", "<leader>fh", builtin.help_tags, { desc = "Fuzzy find help tags" })
    map.set("n", "<leader>ft", "<cmd>TodoTelescope<cr>", { desc = "Find todos" })
  end,
}
