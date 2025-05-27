vim.g.mapleader = " "
vim.g.maplocalleader = " "

local keymap = vim.keymap

keymap.set("n", "<leader>w", "<CMD>write<CR>", { desc = "Save/write buffer" })
keymap.set("n", "<leader>wn", "<CMD>noautocmd write<CR>", { desc = "Save/write buffer w/o formatting" })
keymap.set("n", "<leader>q", "<CMD>quit<CR>", { desc = "Quit buffer" })
keymap.set("i", "jj", "<ESC>", { desc = "Exit insert mode with jj" })

-- Remap for dealing with visual line wraps
-- https://vim.fandom.com/wiki/Move_cursor_by_display_lines_when_wrapping
-- https://github.com/LazyVim/LazyVim/blob/25abbf546d564dc484cf903804661ba12de45507/lua/lazyvim/config/keymaps.lua#L8-L11
keymap.set({ "n", "x" }, "j", "v:count == 0 ? 'gj' : 'j'", { desc = "Down", expr = true, silent = true })
keymap.set({ "n", "x" }, "<Down>", "v:count == 0 ? 'gj' : 'j'", { desc = "Down", expr = true, silent = true })
keymap.set({ "n", "x" }, "k", "v:count == 0 ? 'gk' : 'k'", { desc = "Up", expr = true, silent = true })
keymap.set({ "n", "x" }, "<Up>", "v:count == 0 ? 'gk' : 'k'", { desc = "Up", expr = true, silent = true })

-- Better Indentations - stay in visual mode after indentation
keymap.set("v", "<", "<gv", { desc = "Shift left in visual mode without going to Normal after first indent" })
keymap.set("v", ">", ">gv", { desc = "Shift right in visual mode without going to Normal after first indent" })

-- paste over currently selected text without yanking it
keymap.set("v", "p", '"_dp', { desc = "Put the text [from register x] after the cursor, over selected text" })
keymap.set("v", "P", '"_dP', { desc = "Put the text [from register x] before the cursor, over selected text" })

-- breaks `xp` combination - swapping two adjacent characters
keymap.set({ "n", "v" }, "x", '"_x', { desc = "Delete character and don't yank" })

keymap.set("n", "c", '"_c', { desc = "Change{motion} character and don't yank old text" })
keymap.set("n", "C", '"_C', { desc = "Change to end of line and don't yank old text" })

-- Select previous paste
keymap.set("n", "gp", "`[v`]", { desc = "Select previous paste" })

-- Select all
keymap.set("n", "<C-a>", "gg<S-v>G", { desc = "Select all" })

-- increment/decrement numbers
keymap.set("n", "<leader>+", "<C-a>", { desc = "Increment number" })
keymap.set("n", "<leader>-", "<C-x>", { desc = "Decrement number" })

-- Check if have highlight enabled at all. See `:help hlsearch`
keymap.set("n", "<Esc>", "<CMD>nohlsearch<CR>", { desc = "Clear search highlights" })

-- Vertical scroll and center
keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Scroll half page DOWN and stay centered" })
keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Scroll half page UP and stay centered" })

-- Jump seach occurrences and stay centered
keymap.set("n", "n", "nzz", { desc = "Jump to next search occurrence and stay centered" })
keymap.set("n", "N", "nzzzv", { desc = "Jump to previous search occurrence and stay centered" })

-- Window management
keymap.set("n", "<leader>sv", "<CMD>vsplit<CR>", { desc = "Split window vertically" })
keymap.set("n", "<leader>sh", "<CMD>split<CR>", { desc = "Split window horizontally" })
keymap.set("n", "<leader>se", "<C-w>=", { desc = "Make splits equal size" })
keymap.set("n", "<leader>sx", "<CMD>close<CR>", { desc = "Close current split" })

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--
--  See `:help wincmd` for a list of all window commands
keymap.set("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
keymap.set("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
keymap.set("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
keymap.set("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })

-- Tabs management
keymap.set("n", "<leader>to", "<CMD>tabnew<CR>", { desc = "Open new tab" })
keymap.set("n", "<leader>tx", "<CMD>tabclose<CR>", { desc = "Close current tab" })
keymap.set("n", "<leader>tn", "<CMD>tabn<CR>", { desc = "Go to next tab" })
keymap.set("n", "<leader>tp", "<CMD>tabp<CR>", { desc = "Go to previous tab" })
keymap.set("n", "<leader>tf", "<CMD>tabnew %<CR>", { desc = "Open current buffer in a new tab" })

---- Buffers management
---- Also don't forget about <C-i> and <C-o> to go forward/backward in the jumplist
---- In a traditional terminal environment, both Tab and Ctrl+I generate the same ASCII character (0x09)
---- So when you override Tab, Ctrl-i - jumplist navigation - is also overridden
---- https://vi.stackexchange.com/a/23343/6400
keymap.set("n", "<Tab>", "<CMD>bnext<CR>", { desc = "Go to next buffer", noremap = true, silent = true })
keymap.set("n", "<S-Tab>", "<CMD>bprevious<CR>", { desc = "Go to previous buffer", noremap = true, silent = true })

-- Replaced by Snacks.toogle
-- keymap.set("n", "<leader>tw", function()
--   local status = vim.o.wrap and "OFF" or "ON"
--   vim.api.nvim_echo({ { "Toggling wrap " .. status, "Normal" } }, true, {})
--   vim.o.wrap = not vim.o.wrap
-- end, { desc = "Toggle line wrap" })

-- Replaced by Snacks.toogle
-- keymap.set("n", "<leader>ts", function()
--   local status = vim.o.spell and "OFF" or "ON"
--   vim.api.nvim_echo({ { "Toggling spellcheck " .. status, "Normal" } }, true, {})
--   vim.o.spell = not vim.o.spell
-- end, { desc = "Toggle spellcheck" })

-- Diagnostic keymaps
-- More diagnostics shortcuts are in plugin/trouble.lua|lsp.lua|telescope.lua
keymap.set("n", "<leader>xD", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })
