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
    local action_state = require("telescope.actions.state")

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
          },
        },
      },
      pickers = {
        -- diagnostics = {
        --   passed in key map
        --   bufnr = 0,
        -- },
        buffers = {
          -- Delete open buffers from telescope list sing Ctrl-d
          -- Select multiple buffers using Tab
          attach_mappings = function(prompt_bufnr, map)
            map({ "n", "i" }, "<C-d>", function()
              local current_picker = action_state.get_current_picker(prompt_bufnr)
              local selections = current_picker:get_multi_selection()

              -- If no buffers are selected, delete the currently selected buffer
              if vim.tbl_isempty(selections) then
                local selection = action_state.get_selected_entry()
                vim.api.nvim_buf_delete(selection.bufnr, { force = true })
              else
                -- Delete all selected buffers
                for _, selection in ipairs(selections) do
                  vim.api.nvim_buf_delete(selection.bufnr, { force = true })
                end
              end

              actions.close(prompt_bufnr)
            end)
            return true
          end,
          previewer = false, -- Disable the previewer since C-d is used to scroll preview
        },
        find_files = {
          theme = "dropdown",
          previewer = false,
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
    map.set("n", "<leader>fd", function()
      builtin.diagnostics({ bufnr = 0 })
    end, { desc = "Diagnostics for the current buffer" })
    map.set("n", "<leader>fD", builtin.diagnostics, { desc = "Diagnostics from all open buffers" })
    map.set("n", "<leader>ft", "<cmd>TodoTelescope<cr>", { desc = "Find todos" })
  end,
}
