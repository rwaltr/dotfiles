return {
  {
    "leoluz/nvim-dap-go",
    opts = {
      dap_configurations = {
        {
          -- Must be "go" or it will be ignored by the plugin
          type = "go",
          name = "Connect remote",
          request = "attach",
          mode = "remote",
          substitutePath = {
            {
              from = "${workspaceFolder}",
              to = "/app",
            },
          },
        },
      },
      delve = {
        port = 2345,
      },
    },
    config = function(_, opts)
      require("dap-go").setup(opts)
    end,
  },
}
