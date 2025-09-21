-- https://github.com/nvim-telescope/telescope.nvim
-- https://github.com/nvim-telescope/telescope-fzf-native.nvim
return {
  "nvim-telescope/telescope.nvim",
  -- branch "0.1.x" is deprecated https://github.com/nvim-telescope/telescope.nvim/issues/3487
  branch = "master",
  version = false,
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-telescope/telescope-ui-select.nvim",
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
        path_display = { truncate = 5 },
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
      extensions = {
        ["ui-select"] = {
          require("telescope.themes").get_dropdown({}),
        },
      },
      pickers = {
        -- diagnostics = {
        --   passed in key map
        --   bufnr = 0,
        -- },
        buffers = {
          show_all_buffers = true,
          sort_mru = true,
          -- Delete open buffers from telescope list using Ctrl-d
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
        oldfiles = {
          prompt_title = "Recent Files",
          theme = "dropdown",
          previewer = false,
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
            "--glob",
            "!**/node_modules/*",
            "--glob",
            "!**/.venv/*",
            "--glob",
            "!**/.direnv/*",
            "--color",
            "never",
          },
        },
        live_grep = {
          glob_pattern = {
            "!**/.git/*",
            "!**/node_modules/*",
            "!**/.venv/*",
            "!**/.direnv/*",
          },
          additional_args = { "--hidden", "--no-ignore-vcs" },
        },
      },
    })

    telescope.load_extension("fzf")
    telescope.load_extension("ui-select")

    local builtin = require("telescope.builtin")
    local map = vim.keymap
    -- stylua: ignore start
    map.set("n", "<C-p>", builtin.find_files, { desc = "Fuzzy find files in CWD" })
    map.set("n", "<leader>ff", "<CMD>Telescope find_files<CR>", { desc = "Fuzzy find files in CWD" })
    map.set("n", "<leader>fr", "<CMD>Telescope oldfiles<CR>", { desc = "Fuzzy find recent files" })
    map.set("n", "<leader>fs", "<CMD>Telescope live_grep<CR>", { desc = "Find string in CWD" })
    map.set("n", "<leader>fc", "<CMD>Telescope grep_string<CR>", { desc = "Find string under cursor in CWD" })
    map.set("n", "<leader>fb", builtin.buffers, { desc = "Fuzzy list buffers" })
    map.set("n", "<leader>fm", builtin.marks, { desc = "Fuzzy list marks" })
    map.set("n", "<leader>fk", builtin.keymaps, { desc = "Fuzzy list keymaps" })
    map.set("n", "<leader>fh", builtin.help_tags, { desc = "Fuzzy find help tags" })
    map.set("n", "<leader>fD", builtin.diagnostics, { desc = "Diagnostics from all open buffers" })
    -- map.set("n", "<leader>fx", builtin.treesitter, { desc = "Fuzzy list Treesitter objects" })
    map.set("n", "<leader>fx", function()
      -- builtin.lsp_document_symbols()
      builtin.lsp_document_symbols({
        symbols = {
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
          "Property",
        },
      })
    end, { desc = "Fuzzy list Document Symbols" })
    map.set("n", "<leader>fd", function() builtin.diagnostics({ bufnr = 0 }) end, { desc = "Diagnostics for the current buffer" })
    map.set("n", "<leader>ft", "<CMD>TodoTelescope<CR>", { desc = "Find TODOs" })
    map.set("n", "<leader>fS", builtin.spell_suggest, { desc = "Lists spelling suggestions for word under cursor" })
    -- stylua: ignore end
  end,
}
