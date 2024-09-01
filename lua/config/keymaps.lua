vim.g.mapleader = " "
vim.g.maplocalleader = " "

local map = vim.keymap

map.set("n", "<leader>w", "<CMD>write<CR>", { desc = "Save/write buffer" })
map.set("n", "<leader>q", ":quit<CR>", { desc = "Quit buffer" })
map.set("i", "jj", "<ESC>", { desc = "Exit insert mode with jj" })

-- Check if have highlight enabled at all. See `:help hlsearch`
map.set("n", "<Esc>", "<CMD>nohlsearch<CR>", { desc = "Clear search highlights" })

-- Indentations
map.set("v", "<", "<gv")
map.set("v", ">", ">gv")

-- Select previous paste
map.set("n", "gp", "`[v`]")

-- increment/decrement numbers
map.set("n", "<leader>+", "<C-a>", { desc = "Increment number" })
map.set("n", "<leader>-", "<C-x>", { desc = "Decrement number" })

-- Window management
map.set("n", "<leader>sv", ":vsplit<CR>", { desc = "Split window vertically" })
map.set("n", "<leader>sh", ":split<CR>", { desc = "Split window horizontally" })
map.set("n", "<leader>se", "<C-w>=", { desc = "Make splits equal size" })
map.set("n", "<leader>sx", ":close<CR>", { desc = "Close current split" })

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--
--  See `:help wincmd` for a list of all window commands
map.set("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
map.set("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
map.set("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
map.set("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })

-- Tabs management
map.set("n", "<leader>to", ":tabnew<CR>", { desc = "Open new tab" })
map.set("n", "<leader>tx", ":tabclose<CR>", { desc = "Close current tab" })
map.set("n", "<leader>tn", ":tabn<CR>", { desc = "Go to next tab" })
map.set("n", "<leader>tp", ":tabp<CR>", { desc = "Go to previous tab" })
map.set("n", "<leader>tf", ":tabnew %<CR>", { desc = "Open current buffer in a new tab" })

-- Buffers management
-- Also don't forget about <C-i> and <C-o> to go forward/backward in the jumplist
map.set("n", "<Tab>", ":bnext<CR>", { desc = "Go to next buffer" })
map.set("n", "<S-Tab>", ":bprevious<CR>", { desc = "Go to previous buffer" })

-- Diagnostic keymaps
-- TODO: figure out what is this. from neovim-kickstart
-- map.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })
