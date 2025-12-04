require("config.options")
require("config.autocmds")
require("config.keymaps")
require("config.lazy")

-- Hack for MacOS brew installed lua/luarocks
-- required for https://github.com/CopilotC-Nvim/CopilotChat.nvim
-- luarocks path --lr-cpath --lua-version 5.1
-- :lua print(package.cpath)
-- luarocks install --lua-version 5.1 tiktoken_core
-- luarocks list --lua-version 5.1 tiktoken_core

if vim.uv.os_uname().sysname == "Darwin" then
  package.cpath = package.cpath .. ";" .. os.getenv("HOME") .. "/.luarocks/lib/lua/5.1/?.so"
end
