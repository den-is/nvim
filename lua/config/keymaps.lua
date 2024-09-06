vim.g.mapleader = " "
vim.g.maplocalleader = " "

local keymap = vim.keymap

-- Remap for dealing with visual line wraps
-- https://vim.fandom.com/wiki/Move_cursor_by_display_lines_when_wrapping
keymap.set("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true })
keymap.set("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true })

keymap.set("n", "<leader>w", "<CMD>write<CR>", { desc = "Save/write buffer" })
keymap.set("n", "<leader>q", "<CMD>quit<CR>", { desc = "Quit buffer" })
keymap.set("i", "jj", "<ESC>", { desc = "Exit insert mode with jj" })

-- Better Indentations
keymap.set("v", "<", "<gv")
keymap.set("v", ">", ">gv")

-- paste over currently selected text without yanking it
keymap.set("v", "p", '"_dp')
keymap.set("v", "P", '"_dP')

-- Select previous paste
keymap.set("n", "gp", "`[v`]", { desc = "Select previous paste" })

-- Select all
keymap.set("n", "<C-a>", "gg<S-v>G", { desc = "Select all" })

-- increment/decrement numbers
keymap.set("n", "<leader>+", "<C-a>", { desc = "Increment number" })
keymap.set("n", "<leader>-", "<C-x>", { desc = "Decrement number" })

-- Check if have highlight enabled at all. See `:help hlsearch`
keymap.set("n", "<Esc>", "<CMD>nohlsearch<CR>", { desc = "Clear search highlights" })

-- Window management
keymap.set("n", "<leader>sv", "<cmd>vsplit<CR>", { desc = "Split window vertically" })
keymap.set("n", "<leader>sh", "<cmd>split<CR>", { desc = "Split window horizontally" })
keymap.set("n", "<leader>se", "<C-w>=", { desc = "Make splits equal size" })
keymap.set("n", "<leader>sx", "<cmd>close<CR>", { desc = "Close current split" })

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--
--  See `:help wincmd` for a list of all window commands
keymap.set("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
keymap.set("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
keymap.set("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
keymap.set("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })

-- Tabs management
keymap.set("n", "<leader>to", "<cmd>tabnew<CR>", { desc = "Open new tab" })
keymap.set("n", "<leader>tx", "<cmd>tabclose<CR>", { desc = "Close current tab" })
keymap.set("n", "<leader>tn", "<cmd>tabn<CR>", { desc = "Go to next tab" })
keymap.set("n", "<leader>tp", "<cmd>tabp<CR>", { desc = "Go to previous tab" })
keymap.set("n", "<leader>tf", "<cmd>tabnew %<CR>", { desc = "Open current buffer in a new tab" })

---- Buffers management
---- Also don't forget about <C-i> and <C-o> to go forward/backward in the jumplist
---- Tab strictly equals C-i so when you override Tab CTRL-I stops working
-- map.set("n", "<Tab>", "<cmd>bnext<CR>", { desc = "Go to next buffer" })
-- map.set("n", "<S-Tab>", "<cmd>bprevious<CR>", { desc = "Go to previous buffer" })

keymap.set("n", "<leader>tw", function()
  local status = vim.o.wrap and "OFF" or "ON"
  vim.api.nvim_notify("Toggling wrap " .. status, vim.log.levels.INFO, {})
  vim.o.wrap = not vim.o.wrap
end, { desc = "Toggle line wrap" })

keymap.set("n", "<leader>ts", function()
  local status = vim.o.spell and "OFF" or "ON"
  vim.api.nvim_notify("Toggling spellcheck " .. status, vim.log.levels.INFO, {})
  vim.o.spell = not vim.o.spell
end, { desc = "Toggle spellcheck" })

-- Diagnostic keymaps
keymap.set("n", "<leader>xD", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })
