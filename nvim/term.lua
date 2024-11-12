local Terminal = require("toggleterm.terminal").Terminal

require("toggleterm").setup{
  size = 20,
  open_mapping = [[<c-t>]],
  hide_numbers = true,
  shade_terminals = true,
  start_in_insert = true,
  insert_mappings = true,
  persist_size = true,
  direction = "horizontal",
  close_on_exit = true,
  shell = vim.o.shell,
}

local project_runner = Terminal:new({
  cmd = "sh neovim.sh",
  dir = ".",
  direction = "horizontal",
  close_on_exit = false,
  on_open = function(term)
    vim.cmd("startinsert!")
    vim.api.nvim_buf_set_keymap(term.bufnr, "n", "q", "<cmd>close<CR>", {noremap = true, silent = true})
  end,
  on_close = function()
    vim.cmd("startinsert!")
  end,
})

function _PROJECT_TOGGLE()
  project_runner:toggle()
end

vim.api.nvim_set_keymap("n", "<F5>", "<cmd>lua _PROJECT_TOGGLE()<CR>", {noremap = true, silent = true})
