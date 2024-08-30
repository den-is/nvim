-- https://github.com/folke/lazydev.nvim
-- https://github.com/Allaman/nvim/blob/main/lua/core/plugins/lazydev.lua
return {
  {
    "folke/lazydev.nvim",
    ft = "lua",
    opts = {
      -- See the configuration section for more details
      -- Library items can be absolute paths
      -- "~/projects/my-awesome-lib",
      -- Or relative, which means they will be resolved as a plugin "LazyVim",
      -- When relative, you can also provide a path to the library in the plugin dir
      -- Load luvit types when the `vim.uv` word is found
      {
        path = "luvit-meta/library",
        words = { "vim%.uv" },
      },
    },
  },
  {
    -- optional `vim.uv` typings
    "Bilal2453/luvit-meta",
    lazy = true,
  },
  {
    -- optional completion source for require statements and module annotations
    "hrsh7th/nvim-cmp",
    opts = function(_, opts)
      opts.sources = opts.sources or {}
      table.insert(opts.sources, {
        name = "lazydev",
        group_index = 0, -- set group index to 0 to skip loading LuaLS completions
      })
    end,
  },
}
