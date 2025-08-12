local function is_excluded(path, excluded)
  for _, excl in ipairs(excluded) do
    if path:find(excl, 1, true) then
      return true
    end
  end
  return false
end

local function get_project_files()
  local excluded_dirs = { "/node_modules/", "/.git/", "/dist/", "/build/" }
  local cwd = vim.fn.getcwd()
  local files = vim.fn.systemlist("find " .. cwd .. " -type f")
  local filtered = {}
  for _, file in ipairs(files) do
    if not is_excluded(file, excluded_dirs) then
      table.insert(filtered, file)
    end
  end
  return filtered
end

local function send_project_files_to_copilotchat()
  local files = get_project_files()
  local content = {}
  for _, file in ipairs(files) do
    local lines = vim.fn.readfile(file)
    table.insert(content, table.concat(lines, "\n"))
  end
  local prompt = table.concat(content, "\n\n")
  local tmpfile = cwd .. "/copilot_project_prompt.txt"
  vim.fn.writefile({ prompt }, tmpfile)
  vim.cmd("CopilotChat " .. vim.fn.shellescape(tmpfile))
end

return {
  send_project_files_to_copilotchat = send_project_files_to_copilotchat,
}
