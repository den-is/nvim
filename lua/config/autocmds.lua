local api = vim.api

--- Remove all trailing whitespace on save
local TrimWhiteSpaceGrp = api.nvim_create_augroup("TrimWhiteSpaceGrp", { clear = true })
-- api.nvim_create_autocmd("BufWritePre", {
--   command = [[:%s/\s\+$//e]],
--   group = TrimWhiteSpaceGrp,
--   desc = "Trim trailing whitespace for all filetypes",
-- })
api.nvim_create_autocmd("BufWritePre", {
  group = TrimWhiteSpaceGrp,
  callback = function()
    if vim.bo.filetype ~= "markdown" then
      vim.cmd([[:%s/\s\+$//e]])
    end
  end,
  desc = "Trim trailing whitespace for all filetypes (with exceptions)",
})

-- Disable new line comment
vim.api.nvim_create_autocmd("BufEnter", {
  callback = function()
    vim.opt.formatoptions:remove({ "c", "r", "o" })
  end,
  desc = "Disable New Line Comment",
})

-- https://github.com/hashicorp/terraform-ls/blob/main/docs/USAGE.md
-- expects a terraform filetype and not a tf filetype
api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = { "*.tf" },
  callback = function()
    vim.api.nvim_command("set filetype=terraform")
  end,
  desc = "Detect terraform filetype",
})

-- -- Detected automatically as terraform-vars filetype (probably integrated in terraform-ls)
-- -- can't add `terraform-vars` to conform.nvim formatters_by_ft table for autoformatting
api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = "*.tfvars",
  callback = function()
    vim.api.nvim_command("set filetype=hcl")
  end,
  desc = "Detect terraform vars",
})

api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = { ".terraformrc", "terraform.rc", ".tofurc", "tofu.rc", "*.tfrc" },
  callback = function()
    vim.api.nvim_command("set filetype=hcl")
  end,
  desc = "Set terraformrc filetype to hcl",
})

api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  group = vim.api.nvim_create_augroup("FixTerraformCommentString", { clear = true }),
  pattern = { "*tf", "*.hcl", "*.tfvars", ".terraformrc", "terraform.rc", ".tofurc", "tofu.rc", "*.tfrc" },
  callback = function(ev)
    vim.bo[ev.buf].commentstring = "# %s"
  end,
  desc = "Fix terraform and hcl comment string",
})

api.nvim_create_autocmd("TextYankPost", {
  callback = function()
    vim.highlight.on_yank()
  end,
  desc = "Highlight on Yank",
})

api.nvim_create_autocmd("BufReadPost", {
  callback = function()
    local mark = vim.api.nvim_buf_get_mark(0, '"')
    local lcount = vim.api.nvim_buf_line_count(0)
    if mark[1] > 0 and mark[1] <= lcount then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
  desc = "go to last loc when opening a buffer",
})

-- http://vimcasts.org/episodes/tabs-and-spaces/
api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = { "*.go", "go.sum", "go.mod", "Makefile" },
  callback = function()
    vim.opt.tabstop = 4
    vim.opt.softtabstop = 4
    vim.opt.shiftwidth = 4
    vim.opt.expandtab = false
    -- do not display tab characters. UI becomes too noisy
    vim.opt.list = false
  end,
  desc = "Go Tabs configuration",
})

api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = { "*.py" },
  callback = function()
    vim.opt.tabstop = 4
    vim.opt.softtabstop = 4
    vim.opt.shiftwidth = 4
    vim.opt.expandtab = true
  end,
  desc = "Python Tabs configuration",
})

api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = { "*.txt", "*.md" },
  callback = function()
    vim.opt.spell = true
  end,
  desc = "Enable spell checking for certain file types",
})
