-- https://github.com/echasnovski/mini.nvim/blob/main/readmes/mini-move.md
-- https://www.reddit.com/r/neovim/comments/17776xa/moving_blocks_of_code_up_and_down/
-- https://vim.fandom.com/wiki/Moving_lines_up_or_down#Mappings_to_move_lines
return {
  "echasnovski/mini.move",
  event = { "BufReadPre", "BufNewFile" },
  version = "*",
  opts = {},
}
