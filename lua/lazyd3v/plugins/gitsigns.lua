return {
  "lewis6991/gitsigns.nvim",
  event = { "BufReadPre", "BufNewFile" },
  -- config = true,
  config = function()
    require("gitsigns").setup({

      on_attach = function(bufnr)
        local gs = package.loaded.gitsigns

        local function map(mode, l, r, opts)
          opts = opts or {}
          opts.buffer = bufnr
          vim.keymap.set(mode, l, r, opts)
        end

        map("n", "<leader>99", gs.diffthis)
        map("n", "<leader>00", gs.blame_line)
      end,
    })
  end,
}
