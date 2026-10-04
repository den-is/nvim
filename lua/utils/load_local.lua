local defaults = {
  ai_enabled = false,
  disabled_lsp = {},
  plugins = {},
}

local path = vim.fn.stdpath("config") .. "/local.lua"
local stat, err, code = vim.uv.fs_stat(path)
if not stat then
  if code == "ENOENT" then
    return defaults
  end
  error("Failed to read local config: " .. tostring(err))
end

local config = dofile(path)
assert(type(config) == "table", path .. " must return a table")

for key, expected_type in pairs({ ai_enabled = "boolean", disabled_lsp = "table", plugins = "table" }) do
  assert(config[key] == nil or type(config[key]) == expected_type, path .. ": " .. key .. " must be a " .. expected_type)
end

return vim.tbl_extend("force", defaults, config)
