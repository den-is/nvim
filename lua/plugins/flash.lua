-- https://github.com/folke/flash.nvim
-- https://www.youtube.com/watch?v=eJ3XV-3uoug
--
-- Replaces default keymaps:
-- `["x]s` - (substitute) delete N characters (into register x) and start insert
-- `["x]S` - synonym for `cc`. delete N lines (into register x) and start insert
--
-- alternatives
-- - https://github.com/smoka7/hop.nvim
-- - https://github.com/ggandor/leap.nvim
-- - original idea: https://github.com/easymotion/vim-easymotion

return {
  "folke/flash.nvim",
  event = "VeryLazy",
  ---@type Flash.Config
  opts = {},
  -- stylua: ignore
  keys = {
    { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },

    -- Treesitter incremental selection - ; and , to increase/decrease selection
    -- to be potentially replaced in 0.12 with "an", "in" in visual mode:
    -- https://github.com/neovim/neovim/pull/34011
    -- https://neovim.io/doc/user/lsp.html#_global-defaults
    { "S", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "Flash Treesitter Incremental Selection - ;/, - inc/dec" },

    -- jump somewhere (remove) do the thing and jump back - `o`perator mode (e.g. `c..`, `y..`, `d..`, etc )
    { "r", mode = "o", function() require("flash").remote() end, desc = "Remote Flash" },

    { "R", mode = { "o", "x" }, function() require("flash").treesitter_search() end, desc = "Treesitter Search" },

    -- Toggle flash for search results / or ?. Initiate search than press Ctrl-s to toggle flash
    { "<c-s>", mode = { "c" }, function() require("flash").toggle() end, desc = "Toggle Flash Search" },

    -- Treesitter incremental selection
    -- https://github.com/nvim-treesitter/nvim-treesitter/issues/8096#issuecomment-3236209267
    -- {
    --   "<leader>v",
    --   mode = {"n", "o", "x"},
    --   function()
    --     require("flash").treesitter({
    --       actions = {
    --         ["<leader>v"] = "next",
    --         ["<BS>"] = "prev",
    --       }
    --     })
    --   end,
    --   desc = "Treesitter Incremental Selection" },
  },
}
