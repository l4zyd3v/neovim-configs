local function makeNote()
  vim.ui.input({ prompt = "Note: " }, function(note)
    if not note then
      print("Note input cancelled")
      return
    end

    vim.ui.input({ prompt = "Filename: " }, function(filename)
      if not filename then
        print("Filename input cancelled")
        return
      end

      local dirName = "/vim-notes"

      local path_to_save_file = vim.fn.expand("~/dev/") .. dirName

      if vim.fn.isdirectory(path_to_save_file) == 0 then
        vim.fn.mkdir(path_to_save_file, "p")
      end

      local fileExt = ".txt"

      local fullpath = path_to_save_file .. "/" .. filename .. fileExt

      local file, err = io.open(fullpath, "a")
      if file then
        file:write(note .. "\n")
        file:close()
        print("Note saved successfully.")
      else
        print("Error: Could not open file " .. filename .. ". " .. err)
      end
    end)
  end)
end

return {
  makeNote = makeNote,
}
