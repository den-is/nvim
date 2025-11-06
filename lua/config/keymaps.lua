-- https://neovim.io/doc/user/vimindex.html#index
-- https://neovim.io/doc/user/quickref.html#quickref
-- https://neovim.io/doc/user/news-0.11.html#_defaults

vim.g.mapleader = " "
vim.g.maplocalleader = " "

local keymap = vim.keymap.set

keymap("n", "<leader>w", "<CMD>write<CR>", { desc = "Save/write buffer" })
keymap("n", "<leader>wn", "<CMD>noautocmd write<CR>", { desc = "Save/write buffer w/o formatting" })
keymap("n", "<leader>q", "<CMD>quit<CR>", { desc = "Quit buffer" })
keymap("i", "jj", "<ESC>", { desc = "Exit insert mode with jj" })

-- https://github.com/jdhao/nvim-config/blob/a872921029c295672748e056f15fdaa1832dce76/lua/mappings.lua#L89-L98
keymap("n", "<leader>so", function()
  vim.cmd([[
      update $MYVIMRC
      source $MYVIMRC
    ]])
  vim.notify("Nvim config successfully reloaded!", vim.log.levels.INFO, { title = "nvim-config" })
end, {
  silent = true,
  desc = "reload init.lua",
})

-- Remap for dealing with visual line wraps
-- https://vim.fandom.com/wiki/Move_cursor_by_display_lines_when_wrapping
-- https://github.com/LazyVim/LazyVim/blob/25abbf546d564dc484cf903804661ba12de45507/lua/lazyvim/config/keymaps.lua#L8-L11
keymap({ "n", "x" }, "j", "v:count == 0 ? 'gj' : 'j'", { desc = "Down", expr = true, silent = true })
keymap({ "n", "x" }, "<Down>", "v:count == 0 ? 'gj' : 'j'", { desc = "Down", expr = true, silent = true })
keymap({ "n", "x" }, "k", "v:count == 0 ? 'gk' : 'k'", { desc = "Up", expr = true, silent = true })
keymap({ "n", "x" }, "<Up>", "v:count == 0 ? 'gk' : 'k'", { desc = "Up", expr = true, silent = true })

-- Better Indentations - stay in visual mode after indentation
keymap("v", "<", "<gv", { desc = "Shift left in visual mode without going to Normal after first indent" })
keymap("v", ">", ">gv", { desc = "Shift right in visual mode without going to Normal after first indent" })

-- paste over currently selected text without yanking it
keymap("v", "p", '"_dp', { desc = "Put the text [from register x] after the cursor, over selected text" })
keymap("v", "P", '"_dP', { desc = "Put the text [from register x] before the cursor, over selected text" })

-- breaks `xp` combination - swapping two adjacent characters
keymap({ "n", "v" }, "x", '"_x', { desc = "Delete character and don't yank" })
keymap({ "n", "v" }, "X", '"_D', { desc = "Delete until the end of line and don't yank" })

keymap("n", "c", '"_c', { desc = "Change{motion} and don't yank" })
keymap("n", "C", '"_C', { desc = "Change to end of line and don't yank" })

-- Select previous paste
keymap("n", "gp", "`[v`]", { desc = "Select previous paste" })

-- Select all
keymap("n", "<C-a>", "gg<S-v>G", { desc = "Select all" })

-- increment/decrement numbers
keymap("n", "<leader>+", "<C-a>", { desc = "Increment number" })
keymap("n", "<leader>-", "<C-x>", { desc = "Decrement number" })

-- Check if have highlight enabled at all. See `:help hlsearch`
keymap("n", "<Esc>", "<CMD>nohlsearch<CR>", { desc = "Clear search highlights" })

-- Vertical scroll and center
keymap("n", "<C-d>", "<C-d>zz", { desc = "Scroll half page DOWN and stay centered" })
keymap("n", "<C-u>", "<C-u>zz", { desc = "Scroll half page UP and stay centered" })

-- Jump seach occurrences and stay centered
keymap("n", "n", "nzz", { desc = "Jump to next search occurrence and stay centered" })
keymap("n", "N", "Nzzzv", { desc = "Jump to previous search occurrence and stay centered" })

-- Window management
keymap("n", "<leader>sv", "<CMD>vsplit<CR>", { desc = "Split window vertically" })
keymap("n", "<leader>sh", "<CMD>split<CR>", { desc = "Split window horizontally" })
keymap("n", "<leader>se", "<C-w>=", { desc = "Make splits equal size" })
keymap("n", "<leader>sx", "<CMD>close<CR>", { desc = "Close current split" })

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--
--  See `:help wincmd` for a list of all window commands
keymap("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
keymap("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
keymap("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
keymap("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })

-- Tabs management
keymap("n", "<leader>to", "<CMD>tabnew<CR>", { desc = "Open new tab" })
keymap("n", "<leader>tf", "<CMD>tabnew %<CR>", { desc = "Open current buffer in a new tab" })
keymap("n", "<leader>tn", "<CMD>tabn<CR>", { desc = "Go to next tab" })
keymap("n", "<leader>tp", "<CMD>tabp<CR>", { desc = "Go to previous tab" })
keymap("n", "<leader>tx", "<CMD>tabclose<CR>", { desc = "Close current tab" })

-- Buffers management
--  Also don't forget about <C-i> and <C-o> to go forward/backward in the jumplist
--  In a traditional terminal environment, both Tab and Ctrl+I generate the same ASCII character (0x09)
--  So when you override Tab, Ctrl-i - jumplist navigation - is also overridden
--  https://vi.stackexchange.com/a/23343/6400
-- neovim 0.11 introduced [b ]b [B ]B https://neovim.io/doc/user/news-0.11.html#_defaults
-- keymap("n", "<Tab>", "<CMD>bnext<CR>", { desc = "Go to next buffer", noremap = true, silent = true })
-- keymap("n", "<S-Tab>", "<CMD>bprevious<CR>", { desc = "Go to previous buffer", noremap = true, silent = true })

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
-- More diagnostics shortcuts are in plugin/trouble.lua|lsp.lua|snacks.lua|telescope.lua
keymap("n", "<leader>xD", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })
