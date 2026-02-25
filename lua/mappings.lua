require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

map("i", "jk", "<ESC>")
map("n", "<Esc>", "<cmd>noh<cr>", { desc = "Clear search highlight" })
map("n", "<C-d>", "<C-d>zz")
map("n", "<C-u>", "<C-u>zz")
-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")
--
vim.keymap.set("n", "<leader>rr", function()
  -- require("nvchad.term").runner {
  --    id = "htoggleTerm",
  --    pos = "sp",
  --
  --    cmd = function()
  --      local file = vim.fn.expand "%"
  --
  --      local ft_cmds = {
  --        python = "python3 " .. file,
  --        cpp = "clear && g++ -o out " .. file .. " && ./out",
  --      }
  --
  --      return ft_cmds[vim.bo.ft]
  --    end,
  -- }


  local python = require("venv-selector").python()

  if not python then
    vim.notify("No venv selected. Use :VenvSelect first.", vim.log.levels.WARN)
    return
  end

  local file = vim.fn.expand("%:p")

  if vim.bo.filetype ~= "python" then
    vim.notify("Not a Python file.", vim.log.levels.WARN)
    return
  end

  -- Save the file first, then run it in a terminal split
  vim.cmd("w")
  require("nvchad.term").runner { pos = "sp", id = "htoggleTerm", cmd = python .. " " .. file}
  
  vim.cmd("stopinsert")
  
end, { desc = "Run Python file with selected venv" })
