return {
  "nickjvandyke/opencode.nvim",
  dependencies = {
    -- Recommended for `ask()` and `select()`.
    ---@module 'snacks' <- Loads `snacks.nvim` types for configuration intellisense.
    { "folke/snacks.nvim", opts = { input = {}, picker = {}, terminal = {} } },
  },

  config = function()
    local opencode_cmd = "opencode --port"
    local did_first_opencode_focus_fix = false
    local first_focus_auid = nil
    ---@type snacks.terminal.Opts
    local snacks_terminal_opts = {
      start_insert = true,
      auto_insert = true,
      win = {
        position = "float",
        width = 0.85,
        height = 0.85,
        border = "rounded",
        enter = true,
        on_win = function(win)
          require("opencode.terminal").setup(win.win)

          -- First-open only: wait for the prompt to actually render, then snap focus.
          if not did_first_opencode_focus_fix and first_focus_auid == nil then
            first_focus_auid = vim.api.nvim_create_autocmd("TermRequest", {
              buffer = win.buf,
              callback = function(ev)
                local cursor = ev.data and ev.data.cursor
                if not (cursor and cursor[1] and cursor[1] > 1) then
                  return
                end

                if first_focus_auid ~= nil then
                  vim.api.nvim_del_autocmd(first_focus_auid)
                  first_focus_auid = nil
                end

                vim.defer_fn(function()
                  if vim.api.nvim_win_is_valid(win.win) then
                    vim.api.nvim_set_current_win(win.win)
                    vim.cmd("startinsert")
                    did_first_opencode_focus_fix = true
                  end
                end, 30)
              end,
            })
          end

          vim.keymap.set({ "t", "n" }, "<C-c>", function()
            require("opencode").toggle()
          end, { buffer = win.buf, desc = "Hide opencode window" })
        end,
      },
    }

    ---@type opencode.Opts
    vim.g.opencode_opts = {
      server = {
        start = function()
          require("snacks.terminal").open(opencode_cmd, snacks_terminal_opts)
        end,
        stop = function()
          require("snacks.terminal").get(opencode_cmd, snacks_terminal_opts):close()
        end,
        toggle = function()
          require("snacks.terminal").toggle(opencode_cmd, snacks_terminal_opts)
        end,
      },
    }

    -- Required for `opts.events.reload`.
    vim.o.autoread = true

    -- Recommended/example keymaps.
    vim.keymap.set({ "n", "x" }, "<C-a>", function()
      require("opencode").ask("@this: ", { submit = true })
    end, { desc = "Ask opencode…" })
    vim.keymap.set({ "n", "x" }, "<C-x>", function()
      require("opencode").select()
    end, { desc = "Execute opencode action…" })
    vim.keymap.set({ "n", "t" }, "<Leader>jj", function()
      require("opencode").toggle()
    end, { desc = "Toggle opencode" })

    vim.keymap.set({ "n", "x" }, "go", function()
      return require("opencode").operator("@this ")
    end, { desc = "Add range to opencode", expr = true })
    vim.keymap.set("n", "goo", function()
      return require("opencode").operator("@this ") .. "_"
    end, { desc = "Add line to opencode", expr = true })

    vim.keymap.set("n", "<S-C-u>", function()
      require("opencode").command("session.half.page.up")
    end, { desc = "Scroll opencode up" })
    vim.keymap.set("n", "<S-C-d>", function()
      require("opencode").command("session.half.page.down")
    end, { desc = "Scroll opencode down" })

    -- You may want these if you use the opinionated `<C-a>` and `<C-x>` keymaps above — otherwise consider `<leader>o…` (and remove terminal mode from the `toggle` keymap).
    vim.keymap.set("n", "+", "<C-a>", { desc = "Increment under cursor", noremap = true })
    vim.keymap.set("n", "-", "<C-x>", { desc = "Decrement under cursor", noremap = true })
  end,
}
