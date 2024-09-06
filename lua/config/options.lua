-- useful debug commands
-- :echo &runtimepath
-- :new | put =split(&runtimepath, ',')

-- UI -------------------------------------------------------------------------
vim.opt.encoding = "utf-8" -- The encoding displayed
vim.opt.fileencoding = "utf-8" -- The encoding written to file
vim.opt.colorcolumn = "80,120" -- Visual line length guides
vim.opt.scrolloff = 5 -- Minimal number of screen lines to keep above and below the cursor.
vim.opt.sidescrolloff = 5
vim.opt.cursorline = true
-- vim.opt.cursorcolumn = true -- lol. line+column=crosshair
vim.opt.splitright = true -- natural window splitting
vim.opt.splitbelow = true
vim.opt.backspace = "indent,eol,start"
vim.opt.number = true
vim.opt.hidden = true
-- vim.opt.relativenumber = true
vim.opt.signcolumn = "yes"
-- TODO: disable mouse or enable in specific modes
-- vim.opt.mouse         = 'a'
vim.opt.mouse = "nvi"
-- Decrease update time. The length of time Vim waits after you stop typing before it triggers the plugin is governed by the setting updatetime.
vim.opt.updatetime = 250
-- Decrease mapped sequence wait time
-- Displays which-key popup sooner - also which-key sets it to 500
vim.opt.timeoutlen = 500
-- should be false since we are using lualine
vim.opt.showmode = false
-- Sets how neovim will display certain whitespace characters in the editor.
--  See `:help 'list'`
--  and `:help 'listchars'`
vim.opt.list = true
vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }
-- Enable break indent. Every wrapped line will continue visually indented
-- (same amount of space as the beginning of that line)
vim.opt.breakindent = true
vim.opt.ruler = true

-- CMD ------------------------------------------------------------------------
vim.opt.history = 500
vim.opt.inccommand = "split" -- Preview substitutions live, as you type!
vim.opt.showcmd = true -- Show command or size of selected text in Visual mode
vim.opt.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"
-- wildmenu will block nvim-cmp/cmp-cmdline completions
-- vim.opt.wildmenu   = true
-- vim.opt.wildmode   = "list:longest,full"
-- vim.opt.wildignore = "wildignore=*.o,*~,*.pyc,*.so,*.zip,*.docx,*.xlsx,*.jpg,*.png,*.gif,*.pdf,*.exe,*.flv,*.img"

-- Sync clipboard between OS and Neovim ---------------------------------------
--  Schedule the setting after `UiEnter` because it can increase startup-time.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
vim.schedule(function()
  vim.opt.clipboard = "unnamedplus"
end)

-- Colors ---------------------------------------------------------------------
vim.opt.termguicolors = true
vim.opt.background = "dark"

-- Tab and Indentation --------------------------------------------------------
vim.opt.expandtab = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2
vim.opt.autoindent = true
vim.opt.wrap = false
vim.opt.linebreak = true
vim.opt.breakindent = true
vim.opt.textwidth = 0
vim.opt.wrapmargin = 0

-- Search ---------------------------------------------------------------------
-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.incsearch = true -- While typing a search command, show where the pattern, as it was typed so far, matches
vim.opt.hlsearch = true -- Highlight all search matches

-- Spellcheck -----------------------------------------------------------------
-- more spell dictionaries can be found here:
-- http://ftp.vim.org/pub/vim/runtime/spell/
vim.opt.spelllang = "en_us,ru_ru"
---- enabled individually per filetype by autocmd, or manually using <leader>ts
-- vim.opt.spell = true

-- Backups and undo history
vim.opt.undofile = true -- Save undo history
vim.opt.errorbells = false
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.writebackup = false
