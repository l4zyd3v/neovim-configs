vim.g.mapleader = " "
vim.g.maplocalleader = " "

local keymap = vim.keymap
local floating_terminal = require("lazyd3v.core.floating_terminal")
-- window management

keymap.set("n", "<leader>tm", ":terminal<CR>", { desc = "Open terminal" }) -- open terminal
keymap.set("n", "<leader>kk", floating_terminal.toggle, { desc = "Toggle floating terminal" })
keymap.set("t", "<leader>kk", [[<C-\><C-n><cmd>lua require("lazyd3v.core.floating_terminal").toggle()<CR>]], {
  desc = "Toggle floating terminal",
})

keymap.set("n", "<leader>sv", "<C-w>v", { desc = "Split window vertically" }) -- split window vertically
keymap.set("n", "<leader>sh", "<C-w>s", { desc = "Split window horizontally" }) -- split window horizontally
keymap.set("n", "<leader>se", "<C-w>=", { desc = "Make splits equal size" }) -- make split windows equal width & height
keymap.set("n", "<leader>sx", "<cmd>close<CR>", { desc = "Close current split" }) -- close current split window

keymap.set("n", "<leader>sc", "<cmd>vertical resize 35<CR>", { desc = "a narrow window" })

-- keymap for markdown user stoies boilerplate

keymap.set(
  "n",
  "<leader>usrstr",
  "i\n\n## Description\n\n#### As a user, \n\n###### sp - storypoint\n\n##### Acceptance Criteria\n\n- ##### Criteria<esc>",
  { desc = "Insert user story template" }
)

vim.api.nvim_set_keymap("n", "<leader>½½", ":nohlsearch<CR>", { noremap = true, silent = true })

keymap.set("n", "<C-s>", "<cmd>w<CR>", { desc = "Save file" }) -- save file
keymap.set("i", "<C-s>", "<cmd>w<CR>", { desc = "Save file" }) -- save file

keymap.set("n", "<M-w>", "<cmd>TmuxNavigatePrevious<CR>", { desc = "Navigate to previous tmux pane" }) -- navigate to previous tmux pane

keymap.set("n", "<M-l>", "<cmd>TmuxNavigateRight<CR>", { desc = "Navigate to right" }) -- navigate to right
keymap.set("n", "<M-h>", "<cmd>TmuxNavigateLeft<CR>", { desc = "Navigate to left" }) -- navigate to left

local function smooth_scroll(lines, duration, fallback)
  return function()
    local ok, neoscroll = pcall(require, "neoscroll")
    if ok then
      neoscroll.scroll(lines, false, duration)
      return
    end
    vim.cmd("normal! " .. fallback)
  end
end

keymap.set("n", "<M-j>", smooth_scroll(1, 80, "<C-e>"), { desc = "Smooth scroll down" })
keymap.set("n", "<M-k>", smooth_scroll(-1, 80, "<C-y>"), { desc = "Smooth scroll up" })
keymap.set("n", "<M-J>", smooth_scroll(6, 160, "6<C-e>"), { desc = "Smooth scroll down more" })
keymap.set("n", "<M-K>", smooth_scroll(-6, 160, "6<C-y>"), { desc = "Smooth scroll up more" })

keymap.set("i", "<M-j>", "<Down>", { desc = "Arrow down" }) -- Arrow Down
keymap.set("i", "<M-k>", "<Up>", { desc = "Arrow up" }) -- Arrow Up
keymap.set("i", "<M-h>", "<Left>", { desc = "Arrow left" }) -- Arrow Left
keymap.set("i", "<M-l>", "<Right>", { desc = "Arrow right" }) -- Arrow Right

-- doesn't work, wtf.. '
-- keymap.set("n", "<9>", "<{>", { desc = "paragraph backwards" })
-- keymap.set("n", "<0>", "<}>", { desc = "paragraph forward" })

keymap.set("n", "<leader>.", "<cmd>bnext<CR>", { desc = "bnext" })
keymap.set("n", "<leader>,", "<cmd>bprev<CR>", { desc = "bprev" })
vim.api.nvim_set_keymap("t", "<leader>+", "<C-\\><C-n>", { noremap = true, silent = true })

vim.api.nvim_set_keymap("n", "J", "", { noremap = true, silent = true })

keymap.set("n", "<leader>z", ":ZenMode<CR>", { desc = "Toggle ZenMode" }) -- ZenMode
