-- https://github.com/lewis6991/gitsigns.nvim
-- Adds git related signs to the gutter, as well as utilities for managing changes
return {
  "lewis6991/gitsigns.nvim",
  event = { "BufReadPre", "BufNewFile" },
  opts = {},
  config = function()
    require("gitsigns").setup({

      -- register keymappings
      on_attach = function(bufnr)
        local gitsigns = require("gitsigns")

        local function map(mode, l, r, opts)
          opts = opts or {}
          opts.buffer = bufnr
          vim.keymap.set(mode, l, r, opts)
        end

        -- Navigation
        map("n", "]h", function()
          if vim.wo.diff then
            vim.cmd.normal({ "]c", bang = true })
          else
            gitsigns.nav_hunk("next")
          end
        end, { desc = "Next hunk" })

        map("n", "[h", function()
          if vim.wo.diff then
            vim.cmd.normal({ "[c", bang = true })
          else
            gitsigns.nav_hunk("prev")
          end
        end, { desc = "Prev hunk" })

        -- Actions
        map("n", "<leader>hs", gitsigns.stage_hunk, { desc = "Git - Stage hunk" })
        map("n", "<leader>hr", gitsigns.reset_hunk, { desc = "Git - Reset hunk" })
        map("v", "<leader>hs", function()
          gitsigns.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
        end, { desc = "Git - Stage hunk" })
        map("v", "<leader>hr", function()
          gitsigns.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
        end, { desc = "Git - Reset hunk" })

        map("n", "<leader>hS", gitsigns.stage_buffer, { desc = "Git - Stage buffer" })
        map("n", "<leader>hR", gitsigns.reset_buffer, { desc = "Git - Reset buffer" })

        map("n", "<leader>hu", gitsigns.undo_stage_hunk, { desc = "Git - Undo stage hunk" })
        map("n", "<leader>hp", gitsigns.preview_hunk, { desc = "Git - Preview hunk" })

        map("n", "<leader>hb", function()
          gitsigns.blame_line({ full = true })
        end, { desc = "Blame line" })
        map("n", "<leader>hB", gitsigns.toggle_current_line_blame, { desc = "Git - Toggle line blame" })
        map("n", "<leader>hd", gitsigns.diffthis, { desc = "Git - Diff this" })
        map("n", "<leader>hD", function()
          gitsigns.diffthis("~")
        end, { desc = "Diff this ~" })
        map("n", "<leader>td", gitsigns.toggle_deleted, { desc = "Git - Toggle deleted" })

        -- Text object
        map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", { desc = "Git - Select hunk" })
      end,
    })
  end,
}
