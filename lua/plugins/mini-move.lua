-- https://github.com/echasnovski/mini.nvim/blob/main/readmes/mini-move.md
-- https://www.reddit.com/r/neovim/comments/17776xa/moving_blocks_of_code_up_and_down/
-- https://vim.fandom.com/wiki/Moving_lines_up_or_down#Mappings_to_move_lines
-- -- Move visual selection in Visual mode. Defaults are Alt (Meta) + hjkl.
-- left = '<M-h>',
-- right = '<M-l>',
-- down = '<M-j>',
-- up = '<M-k>',
--
-- -- Move current line in Normal mode
-- line_left = '<M-h>',
-- line_right = '<M-l>',
-- line_down = '<M-j>',
-- line_up = '<M-k>',
return {
  "echasnovski/mini.move",
  event = { "BufReadPre", "BufNewFile" },
  version = "*",
  opts = {},
}
