-- Make a note to self and save it in a file
local function makeNote()
  local note = vim.fn.input("Note: ")
  local filename = vim.fn.input("Filename: ")
  local path = vim.fn.expand("%:p:h")
  local fullpath = path .. "/" .. filename

  -- Print debug information
  print("Note: " .. note)
  print("Filename: " .. filename)
  print("Full path: " .. fullpath)

  local file, err = io.open(fullpath, "a")
  if file then
    file:write(note .. "\n")
    file:close()
    print("Note saved successfully.")
  else
    print("Error: Could not open file " .. filename .. ". " .. err)
  end
end

return {
  makeNote = makeNote,
}
