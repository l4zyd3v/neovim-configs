return {
  "nickjvandyke/opencode.nvim",
  dependencies = {
    -- Recommended for `ask()` and `select()`.
    ---@module 'snacks' <- Loads `snacks.nvim` types for configuration intellisense.
    { "folke/snacks.nvim", opts = { input = {}, picker = {}, terminal = {} } },
  },

  config = function()
    local opencode_cmd = "opencode --port"
    local opencode_right_width = 0.45
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

    local function get_opencode_terminal()
      local terminals = require("snacks.terminal").list()
      for _, terminal in ipairs(terminals) do
        local meta = terminal.buf and vim.b[terminal.buf] and vim.b[terminal.buf].snacks_terminal
        if meta and meta.cmd == opencode_cmd then
          return terminal
        end
      end
      return require("snacks.terminal").get(opencode_cmd, { create = false })
    end

    local function set_opencode_layout(terminal, position)
      terminal.opts.position = position
      if position == "float" then
        terminal.opts.width = snacks_terminal_opts.win.width
        terminal.opts.height = snacks_terminal_opts.win.height
        terminal.opts.border = snacks_terminal_opts.win.border
      else
        terminal.opts.width = opencode_right_width
        terminal.opts.height = nil
        terminal.opts.border = nil
      end
    end

    local function toggle_opencode_layout()
      local terminal = get_opencode_terminal()
      if not terminal then
        return
      end

      local next_position = terminal.opts.position == "right" and "float" or "right"
      set_opencode_layout(terminal, next_position)

      if terminal:valid() then
        terminal:hide()
      end
      terminal:show()

      if terminal.win and vim.api.nvim_win_is_valid(terminal.win) then
        vim.api.nvim_set_current_win(terminal.win)
        vim.cmd("startinsert")
      end
    end

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
    vim.keymap.set({ "n", "t" }, "<Leader>jk", function()
      toggle_opencode_layout()
    end, { desc = "Toggle opencode float/right" })

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
