-- https://github.com/mbbill/undotree
return {
  "mbbill/undotree",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    vim.keymap.set("n", "<leader>eu", vim.cmd.UndotreeToggle, { desc = "Open Undo Tree" })
  end,
}
