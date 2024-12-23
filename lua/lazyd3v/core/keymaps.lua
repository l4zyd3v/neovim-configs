vim.g.mapleader = " "
vim.g.maplocalleader = " "

local keymap = vim.keymap
-- window management
keymap.set("n", "<leader>sv", "<C-w>v", { desc = "Split window vertically" }) -- split window vertically
keymap.set("n", "<leader>sh", "<C-w>s", { desc = "Split window horizontally" }) -- split window horizontally
keymap.set("n", "<leader>se", "<C-w>=", { desc = "Make splits equal size" }) -- make split windows equal width & height
keymap.set("n", "<leader>sx", "<cmd>close<CR>", { desc = "Close current split" }) -- close current split window

keymap.set("n", "<leader>sc", "<cmd>vertical resize 50<CR>", { desc = "a narrow window" })

-- keymap for markdown user stoies boilerplate

keymap.set(
  "n",
  "<leader>usrstr",
  "i\n\n## Description\n\n#### As a user, \n\n###### sp - storypoint\n\n##### Acceptance Criteria\n\n- ##### Criteria<esc>",
  { desc = "Insert user story template" }
)

vim.api.nvim_set_keymap("n", "<leader>33", ":nohlsearch<CR>", { noremap = true, silent = true })

keymap.set("n", "<C-s>", "<cmd>w<CR>", { desc = "Save file" }) -- save file
keymap.set("i", "<C-s>", "<cmd>w<CR>", { desc = "Save file" }) -- save file

keymap.set("n", "<M-w>", "<cmd>TmuxNavigatePrevious<CR>", { desc = "Navigate to previous tmux pane" }) -- navigate to previous tmux pane

keymap.set("n", "<M-l>", "<cmd>TmuxNavigateRight<CR>", { desc = "Navigate to right" }) -- navigate to right
keymap.set("n", "<M-h>", "<cmd>TmuxNavigateLeft<CR>", { desc = "Navigate to left" }) -- navigate to left

keymap.set("n", "<M-j>", "<C-e>", { desc = "scroll down" }) -- scroll down

keymap.set("n", "<M-k>", "<C-y>", { desc = "Scroll down" }) -- scroll down

keymap.set("n", "<M-J>", "8<C-e>", { desc = "scroll down" }) -- scroll down more

keymap.set("n", "<M-K>", "8<C-y>", { desc = "Scroll down" }) -- scroll down more

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
