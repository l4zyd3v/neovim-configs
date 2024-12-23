return {
  "github/copilot.vim",
  config = function()
    vim.api.nvim_set_keymap("n", "<leader>coe", "<cmd>Copilot enable<CR>", { desc = "Copilot enable" })

    vim.api.nvim_set_keymap("n", "<leader>cod", "<cmd>Copilot disable<CR>", { desc = "Copilot disable" })
  end,
}
