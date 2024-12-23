return {
  "m4xshen/autoclose.nvim",
  config = function()
    local autoclose = require("autoclose")

    autoclose.setup({
      -- keys = {
      -- 	["$"] = { escape = true, close = true, pair = "$$", disabled_filetypes = {} },
      -- },
    })
  end,
}
