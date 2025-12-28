local bufnr = vim.api.nvim_get_current_buf()

-- default nvim LSP - gra
vim.keymap.set("n", "<leader>a", function()
  vim.cmd.RustLsp("codeAction") -- supports rust-analyzer's grouping
  -- or vim.lsp.buf.codeAction() if you don't want grouping.
end, { silent = true, buffer = bufnr })

-- override default nvim LSP hover (or in my Case LspSaga hover. default nvim.lsp is C-k)
-- to scroll Hover window press S-k again - then you can scroll its contents
vim.keymap.set(
  "n",
  "K", -- Override Neovim's built-in hover keymap with rustaceanvim's hover actions
  function()
    vim.cmd.RustLsp({ "hover", "actions" })
  end,
  { silent = true, buffer = bufnr }
)
