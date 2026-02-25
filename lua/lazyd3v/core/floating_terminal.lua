local M = {}

local state = {
  buf = nil,
  win = nil,
}

local function valid_buf(buf)
  return buf and vim.api.nvim_buf_is_valid(buf)
end

local function valid_win(win)
  return win and vim.api.nvim_win_is_valid(win)
end

local function window_config()
  local width = math.floor(vim.o.columns * 0.82)
  local height = math.floor(vim.o.lines * 0.82)
  local col = math.floor((vim.o.columns - width) / 2)
  local row = math.floor((vim.o.lines - height) / 3)

  return {
    relative = "editor",
    width = width,
    height = height,
    col = col,
    row = row,
    style = "minimal",
    border = "rounded",
  }
end

local function ensure_terminal_buffer()
  if not valid_buf(state.buf) then
    state.buf = vim.api.nvim_create_buf(false, true)
    vim.bo[state.buf].bufhidden = "hide"
  end

  if vim.bo[state.buf].buftype ~= "terminal" then
    vim.api.nvim_buf_call(state.buf, function()
      vim.fn.termopen(vim.o.shell)
    end)
  end
end

function M.open()
  ensure_terminal_buffer()

  state.win = vim.api.nvim_open_win(state.buf, true, window_config())

  vim.wo[state.win].number = false
  vim.wo[state.win].relativenumber = false
  vim.wo[state.win].signcolumn = "no"
  vim.wo[state.win].winblend = 15

  vim.cmd("startinsert")
end

function M.close()
  if valid_win(state.win) then
    vim.api.nvim_win_close(state.win, true)
    state.win = nil
  end
end

function M.toggle()
  if valid_win(state.win) then
    M.close()
    return
  end

  M.open()
end

return M
