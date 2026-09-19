local U = require("utils.functions")
vim.g.ai_enabled = U.env_bool("NVIM_AI", false)

require("config.options")
require("config.autocmds")
require("config.keymaps")
require("config.lazy")
