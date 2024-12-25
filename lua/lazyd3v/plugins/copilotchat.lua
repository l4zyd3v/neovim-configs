return {
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    dependencies = {
      { "github/copilot.vim" },
      { "nvim-lua/plenary.nvim" },
    },
    opts = {
      show_help = "yes", -- Show help text for CopilotChatInPlace, default: yes
      debug = false, -- Enable or disable debug mode, the log file will be in ~/.local/state/nvim/CopilotChat.nvim.log
      disable_extra_info = "no", -- Disable extra information (e.g: system prompt) in the response.
      -- proxy = "socks5://127.0.0.1:3000", -- Proxies requests via https or socks.
    },
    build = function()
      vim.notify("Please update the remote plugins by running ':UpdateRemotePlugins', then restart Neovim.")
    end,
    event = "VeryLazy",
    keys = {
      { "<leader>cce", "<cmd>CopilotChatExplain<cr>", desc = "CopilotChat - Explain code" },
      { "<leader>cct", "<cmd>CopilotChatTests<cr>", desc = "CopilotChat - Generate tests" },
      {
        "<leader>ccW",
        "<cmd>CopilotChatVsplitToggle<cr>",
        desc = "CopilotChat - Toggle Vsplit", -- Toggle vertical split
      },
      {
        "<leader>ccv",
        ":CopilotChatVisual<space>",
        mode = "v",
        desc = "CopilotChat - Open in vertical split",
      },
      {
        "<leader>ccx",
        ":CopilotChatInPlace<cr>",
        mode = "n",
        desc = "CopilotChat - Run in-place code",
      },
      -- {
      --   "<leader>ccw",
      --   ":CopilotChat respond to the following in a learning manner and explain every detail-<Space>",
      --   desc = "CopilotChat - Chat with Copilot",
      -- },
      {
        "<leader>ccw",
        ":CopilotChat Teach the following in a learning matter: <Space>",
        desc = "CopilotChat - Chat with Copilot",
      },
      -- {
      --   "<leader>ccw",
      --   function()
      --     local prefixMsg =
      --       ":CopilotChat The following request should be answered in a learning manner with links to the documentation. The request is "
      --     vim.fn.input(prefixMsg)
      --   end,
      -- },

      {
        "<leader>ccr",
        "<cmd>CopilotChatReset<cr>",
        desc = "CopilotChat - Reset chat history and clear buffer",
      },
      {
        "<leader>ccs",
        "<cmd>CopilotChatSend<cr>",
        desc = "CopilotChat - Send code to Copilot",
      },
      {
        "<leader>ccp",
        "<cmd>CopilotChatPreview<cr>",
        desc = "CopilotChat - Preview code",
      },
      -- {
      --   "<leader>ccf",
      --   "<cmd>CopilotChatFixDiagnostic<cr>",
      --   desc = "CopilotChat - Fix diagnostic",
      -- },
      {
        "<leader>ccf",
        "<cmd>CopilotChatFix<cr>",
        desc = "CopilotChat - Fix diagnostic",
      },
      {
        "<leader>ccr",
        "<cmd>CopilotChatReset<cr>",
        desc = "CopilotChat - Reset chat history and clear buffer",
      },
      {
        "<leader>cWr",
        "<cmd>CopilotChatReset<cr>", -- Reset chat history and clear buffer.
        desc = "CopilotChat - Reset chat history and clear buffer",
      },
    },
  },
}
