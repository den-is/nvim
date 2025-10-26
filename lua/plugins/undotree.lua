-- https://github.com/mbbill/undotree
-- replaced by Snacks.picker.undo()
return {
  "mbbill/undotree",
  enabled = false,
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    vim.keymap.set("n", "<leader>ut", vim.cmd.UndotreeToggle, { desc = "Undo Tree" })
  end,
}
