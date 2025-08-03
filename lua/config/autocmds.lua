local api = vim.api

vim.filetype.add({
  extension = {
    env = "sh",
    -- https://github.com/hashicorp/terraform-ls/blob/main/docs/USAGE.md
    -- expects a terraform filetype and not a tf filetype
    tf = "terraform",
    -- Detected automatically as terraform-vars filetype (probably integrated in terraform-ls)
    -- can't add `terraform-vars` to conform.nvim formatters_by_ft table for autoformatting
    tfvars = "hcl",
    tfrc = "hcl",
  },
  filename = {
    [".env"] = "sh",
    ["tsconfig.json"] = "jsonc",
    [".yamlfmt"] = "yaml",
    [".yamllint"] = "yaml",
    [".terraformrc"] = "hcl",
    ["terraform.rc"] = "hcl",
    [".tofurc"] = "hcl",
    ["tofu.rc"] = "hcl",
  },
  pattern = {
    ["%.env%.[%w_.-]+"] = "sh",
    [".*%.conf%.local"] = "conf",
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
  desc = "Trim trailing whitespace for all filetypes except markdown",
  group = TrimWhiteSpaceGrp,
  callback = function()
    if vim.bo.filetype ~= "markdown" then
      vim.cmd([[:%s/\s\+$//e]])
    end
  end,
})

-- Disable new line comment
api.nvim_create_autocmd("BufEnter", {
  desc = "Disable new line comments",
  callback = function()
    vim.opt.formatoptions:remove({ "c", "r", "o" })
  end,
})

api.nvim_create_autocmd("FileType", {
  desc = "Fix Terraform and HCL comment string",
  group = vim.api.nvim_create_augroup("FixTerraformCommentString", { clear = true }),
  pattern = { "hcl", "terraform", "terraform-vars" },
  callback = function(ev)
    vim.bo[ev.buf].commentstring = "# %s"
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
  desc = "Open buffer at the last location in file before last Nvim close",
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
