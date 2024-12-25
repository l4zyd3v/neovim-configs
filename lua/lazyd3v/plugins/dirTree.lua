return {
  "nvim-tree/nvim-tree.lua",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    local nvimtree = require("nvim-tree")

    vim.g.loaded_netrw = 1
    vim.g.loaded_netrwPlugin = 1

    -- vim.cmd([[ autocmd VimEnter * :Explore ]])

    vim.cmd([[ highlight NvimTreeFolderArrowClosed guifg=#3FC5FF ]])
    vim.cmd([[ highlight NvimTreeFolderArrowOpen guifg=#3FC5FF ]])

    -- configure nvim-tree
    nvimtree.setup({
      view = {
        -- preserve_window_proportions = true,
        float = {
          enable = true,
        },
        width = 80,
        relativenumber = true,
      },
      -- change folder arrow icons
      renderer = {
        indent_markers = {
          enable = false,
        },
        icons = {
          glyphs = {
            folder = {
              arrow_closed = "", -- arrow when folder is closed
              arrow_open = "", -- arrow when folder is open
            },
          },
        },
      },
      -- disable window_picker for
      -- explorer to work well with
      -- window splits
      -- actions = {
      --   open_file = {
      --     window_picker = {
      --       enable = false,
      --     },
      --   },
      -- },
      git = {
        ignore = false,
      },
      update_focused_file = {
        enable = true,
      },
    })

    -- nvimtree.setup({
    --   view = {
    --     float = {
    --       enable = true,
    --     },
    --     relativenumber = true,
    --   },
    -- })

    -- set keymaps
    local keymap = vim.keymap -- for conciseness

    _G.OpenNvimTreeAndResize = function(command)
      vim.cmd(command)
      vim.cmd("vertical resize 50")

      local max_height = vim.o.lines
      local linesFor80Percent = math.floor(max_height * 0.8)

      vim.cmd("resize " .. linesFor80Percent)
    end

    keymap.set(
      "n",
      "<leader>ee",
      "<cmd>lua _G.OpenNvimTreeAndResize('NvimTreeOpen')<CR>",
      -- "<cmd>NvimTreeOpen<CR>",
      { desc = "Toggle file explorer" }
    ) -- toggle file explorer

    keymap.set(
      "n",
      "<leader>ef",
      "<cmd>lua _G.OpenNvimTreeAndResize('NvimTreeFindFileToggle!')<CR>",
      -- "<cmd>NvimTreeFindFileToggle!<CR>",
      { desc = "Toggle file explorer on current file" }
    ) -- toggle file explorer on current file

    keymap.set(
      "n",
      "<leader>eg",
      "<cmd>lua _G.OpenNvimTreeAndResize('NvimTreeFindFile!')<CR>",
      -- "<cmd>NvimTreeFindFile!<CR>",
      { desc = "Toggle file explorer on current file" }
    ) -- toggle file explorer on current file

    keymap.set("n", "<leader>ec", "<cmd>NvimTreeCollapse<CR>", { desc = "Collapse file explorer" }) -- collapse file explorer

    keymap.set(
      "n",
      "<leader>er",
      "<cmd>lua _G.OpenNvimTreeAndResize('NvimTreeRefresh')<CR>",
      -- "<cmd>NvimTreeRefresh<CR>",
      { desc = "Refresh file explorer" }
    ) -- refresh file explorer
  end,
}
