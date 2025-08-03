local api = vim.api

vim.filetype.add({
  extension = {
    env = "sh",
  },
  filename = {
    [".env"] = "sh",
    ["tsconfig.json"] = "jsonc",
    [".yamlfmt"] = "yaml",
    [".yamllint"] = "yaml",
  },
  pattern = {
    ["%.env%.[%w_.-]+"] = "sh",
  },
})

--- Remove all trailing whitespace on save
local TrimWhiteSpaceGrp = api.nvim_create_augroup("TrimWhiteSpaceGrp", { clear = true })
-- api.nvim_create_autocmd("BufWritePre", {
--   command = [[:%s/\s\+$//e]],
--   group = TrimWhiteSpaceGrp,
--   desc = "Trim trailing whitespace for all filetypes",
-- })
api.nvim_create_autocmd("BufWritePre", {
  desc = "Trim trailing whitespace for all filetypes (with exceptions)",
  group = TrimWhiteSpaceGrp,
  callback = function()
    if vim.bo.filetype ~= "markdown" then
      vim.cmd([[:%s/\s\+$//e]])
    end
  end,
})

-- Disable new line comment
api.nvim_create_autocmd("BufEnter", {
  desc = "Disable New Line comment",
  callback = function()
    vim.opt.formatoptions:remove({ "c", "r", "o" })
  end,
})

-- https://github.com/hashicorp/terraform-ls/blob/main/docs/USAGE.md
-- expects a terraform filetype and not a tf filetype
api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  desc = "Detect terraform filetype",
  pattern = { "*.tf" },
  callback = function()
    vim.api.nvim_command("set filetype=terraform")
  end,
})

-- Detected automatically as terraform-vars filetype (probably integrated in terraform-ls)
-- can't add `terraform-vars` to conform.nvim formatters_by_ft table for autoformatting
api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  desc = "Detect terraform vars",
  pattern = "*.tfvars",
  callback = function()
    vim.api.nvim_command("set filetype=hcl")
  end,
})

api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  desc = "Set terraformrc filetype to hcl",
  pattern = { ".terraformrc", "terraform.rc", ".tofurc", "tofu.rc", "*.tfrc" },
  callback = function()
    vim.api.nvim_command("set filetype=hcl")
  end,
})

api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  desc = "Fix terraform and hcl comment string",
  group = vim.api.nvim_create_augroup("FixTerraformCommentString", { clear = true }),
  pattern = { "*tf", "*.hcl", "*.tfvars", ".terraformrc", "terraform.rc", ".tofurc", "tofu.rc", "*.tfrc" },
  callback = function(ev)
    vim.bo[ev.buf].commentstring = "# %s"
  end,
})

api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  desc = "Set .conf.local filetype to conf",
  pattern = { "*.conf.local" },
  callback = function()
    vim.api.nvim_command("set filetype=conf")
  end,
})

api.nvim_create_autocmd("TextYankPost", {
  desc = "Highlight on Yank",
  callback = function()
    vim.hl.on_yank()
  end,
})

-- remember last position in file/buffer on nvim close and reopen
api.nvim_create_autocmd("BufReadPost", {
  desc = "go to last loc when opening a buffer",
  callback = function()
    local mark = vim.api.nvim_buf_get_mark(0, '"')
    local lcount = vim.api.nvim_buf_line_count(0)
    if mark[1] > 0 and mark[1] <= lcount then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
})

api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  desc = "Enable spell checking for certain file types",
  pattern = { "*.txt", "*.md" },
  callback = function()
    vim.opt.spell = true
  end,
})
