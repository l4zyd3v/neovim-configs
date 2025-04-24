return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
    "MunifTanjim/nui.nvim",
    -- {"3rd/image.nvim", opts = {}}, -- Optional image support in preview window: See `# Preview Mode` for more information
  },
  config = function()
    require("neo-tree").setup({
      window = {
        -- position = "float",
        width = 35,
      },
      filesystem = {
        follow_current_file = {
          enabled = true,
        },
        filtered_items = {
          visible = true, -- This will make all hidden files visible
        },
      },
    })
  end,
  keys = {
    { "<leader>ee", "<cmd>Neotree toggle<cr>", desc = "Toggle NeoTree" },
    { "<leader>eg", "<cmd>Neotree reveal<cr>", desc = "Reveal current file in NeoTree" },
  },
}
