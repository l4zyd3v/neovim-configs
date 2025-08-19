-- lua/lazyd3v/plugins/init.lua
local makeNote = require("lazyd3v.core.makeNote")

-- Define a command to call the makeNote function
vim.api.nvim_create_user_command("MakeNote", makeNote.makeNote, {})

-- Map a key combination to the MakeNote command
vim.api.nvim_set_keymap("n", "<leader>mn", ":MakeNote<CR>", { noremap = true, silent = true })

-- Define a command to send project files to Copilot
vim.keymap.set("n", "<leader>cc+", function()
  require("lazyd3v.core.send_project_files_to_copilot").send_project_files_to_copilotchat()
end, { noremap = true, silent = true })
