-- https://github.com/lewis6991/gitsigns.nvim
return {
  "lewis6991/gitsigns.nvim",
  event = { "BufReadPre", "BufNewFile" },
  opts = {},
  config = function()
    require("gitsigns").setup({

      signs = {
        add = { text = "▎" },
        change = { text = "▎" },
        delete = { text = "" },
        topdelete = { text = "" },
        changedelete = { text = "▎" },
        untracked = { text = "▎" },
      },
      signs_staged = {
        add = { text = "▎" },
        change = { text = "▎" },
        delete = { text = "" },
        topdelete = { text = "" },
        changedelete = { text = "▎" },
      },

      -- sign priority in signcolumn
      sign_priority = 25,
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
        -- stylua: ignore start
        map("n", "<leader>hs", gitsigns.stage_hunk, { desc = "Git - Stage/Unstage hunk" })
        map("n", "<leader>hr", gitsigns.reset_hunk, { desc = "Git - Reset hunk" })
        map("v", "<leader>hs", function() gitsigns.stage_hunk({ vim.fn.line("."), vim.fn.line("v") }) end, { desc = "Git - Stage hunk" })
        map("v", "<leader>hr", function() gitsigns.reset_hunk({ vim.fn.line("."), vim.fn.line("v") }) end, { desc = "Git - Reset hunk" })

        map("n", "<leader>hS", gitsigns.stage_buffer, { desc = "Git - Stage buffer" })
        map("n", "<leader>hR", gitsigns.reset_buffer, { desc = "Git - Reset buffer" })

        map("n", "<leader>hp", gitsigns.preview_hunk, { desc = "Git - Preview hunk" })

        map("n", "<leader>hb", function() gitsigns.blame_line({ full = true }) end, { desc = "Blame line" })
        map("n", "<leader>hB", gitsigns.toggle_current_line_blame, { desc = "Git - Toggle line blame" })
        map("n", "<leader>hd", gitsigns.diffthis, { desc = "Git - Diff this" })
        map("n", "<leader>hD", function() gitsigns.diffthis("~") end, { desc = "Git - Diff this ~" })
        map("n", "<leader>td", gitsigns.preview_hunk_inline, { desc = "Git - Toggle preview inline" })

        -- Text object
        map({ "o", "x" }, "ih", "<CMD><C-U>Gitsigns select_hunk<CR>", { desc = "Git - Select hunk" })
        -- stylua: ignore end
      end,
    })
  end,
}
