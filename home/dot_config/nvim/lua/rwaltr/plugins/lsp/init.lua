return {
  {
    "neovim/nvim-lspconfig",
    event = "BufReadPre",
    dependencies = {
      { "folke/neoconf.nvim", cmd = "Neoconf", config = true },
      "mason.nvim",
      "folke/lsp-colors.nvim",
      {
        "ray-x/lsp_signature.nvim",
        config = function()
          require("rwaltr.plugins.lsp.signature")
        end,
        enabled = false,
      },
      { "j-hui/fidget.nvim", enabled = false, config = true, event = "VeryLazy" },
      -- {
      --   "~whynothugo/lsp_lines.nvim",
      --   url = "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
      --   event = "VeryLazy",
      --   config = function ()
      --     require("lsp_lines").setup()
      --   end,
      -- },
      { "simrat39/symbols-outline.nvim", config = true },
      {
        "someone-stole-my-name/yaml-companion.nvim", ft = "yaml",
        config = function()
          require("telescope").load_extension("yaml_schema")
        end
      },
      { "folke/neodev.nvim", config = true },
      { "williamboman/mason-lspconfig.nvim" },
      "hrsh7th/cmp-nvim-lsp",
    },
    -- region LSP config
    config = function()
      -- TODO: Refactor LSP Interface and Keybinds
      -- init ops
      local opts = {
        on_attach = require("rwaltr.plugins.lsp.handlers").on_attach,
        capabilities = require("rwaltr.plugins.lsp.handlers").capabilities,
      }
      -- Import mason_lspconfig
      local mason_lspconfig = require("mason-lspconfig")
      local lspconfig = require("lspconfig")

      -- Define Mason settings
      local servers = {
        "terraformls",
        "jsonls",
        "yamlls",
        "sumneko_lua",
        "tflint",
        "bashls",
        "marksman",
        "prosemd_lsp",
        "dockerls",
        "gopls",
        "golangci_lint_ls",
        "rust_analyzer",
      }

      mason_lspconfig.setup({
        ensure_installed = servers,
        automatic_installation = true,
      })

      -- Mason setup_handlers expects the first key to be the "default function"
      mason_lspconfig.setup_handlers({
        -- Default Function
        function(server_name)
          lspconfig[server_name].setup({ opts })
        end,
        -- JsonLS settings
        ["jsonls"] = function()
          local jsonls_opts = require("rwaltr.plugins.lsp.settings.jsonls")
          local extended_opts = vim.tbl_deep_extend("force", jsonls_opts, opts)
          lspconfig.jsonls.setup({ extended_opts })
        end,
        -- Yamlls settings
        ["yamlls"] = function()
          local yamls_opts = require("rwaltr.plugins.lsp.settings.yamlls")
          local extended_opts = vim.tbl_deep_extend("force", yamls_opts, opts)
          lspconfig.yamlls.setup({ extended_opts })
        end,
        -- Lua Settings
        ["sumneko_lua"] = function()
          lspconfig.sumneko_lua.setup({
            settings = {
              -- on_attach = opts.on_attach,
              -- capabilities = opts.capabilities,
              Lua = {
                diagnostics = {
                  globals = { "vim" },
                },
                completion = {
                  callSnippet = "Replace",
                },
              },
            },
          })
        end,
        -- Rust Tooling
        ["rust_analyzer"] = function()
          local rust_opts = require("rwaltr.plugins.lsp.settings.rust")
          local rust_tools_status_ok, rust_tools = pcall(require, "rust-tools")
          if not rust_tools_status_ok then
            return
          end
          rust_tools.setup(rust_opts)
        end,
        -- ZK notetaker
        ["zk"] = function()
          local zk_opts = require("rwaltr.plugins.lsp.settings.zk")
          local extented_opts = vim.tbl_deep_extend("force", zk_opts, opts)
          lspconfig.zk.setup(extented_opts)
        end,
        -- insert more here
      })
      --#endregion

      require("rwaltr.plugins.lsp.handlers").setup()
    end,
  },

  {
    "jose-elias-alvarez/null-ls.nvim",
    event = "BufReadPre",
    dependencies = {
      "mason.nvim",
      "jayp0521/mason-null-ls.nvim",
    },
    --#region Null LS Config
    config = function()
      local nls = require("null-ls")
      local format = nls.builtins.formatting
      local diag = nls.builtins.diagnostics
      local ca = nls.builtins.code_actions
      local hvr = nls.builtins.hover
      nls.setup({
        root_dir = require("null-ls.utils").root_pattern(".null-ls.root", ".neoconf.json", ".git"),
        on_attach = require("rwaltr.plugins.lsp.handlers").on_attach,
        sources = {
          ca.gitrebase,
          ca.gitsigns,
          ca.proselint,
          ca.shellcheck,
          diag.codespell,
          diag.fish,
          diag.proselint,
          diag.shellcheck,
          diag.yamllint,
          format.codespell,
          format.jq,
          format.fish_indent,
          format.prettier.with({ extra_args = { "--no-semi", "--jsx-single-quote" } }),
          format.prettierd,
          format.shfmt,
          format.remark,
          format.shellharden,
          format.shfmt,
          format.terraform_fmt,
          format.trim_newlines,
          format.trim_whitespace,
          format.stylua,
          hvr.dictionary,
        },
      })
    end,
    --#endregion
  },

  { "b0o/schemastore.nvim" },
  -- TODO: Configure Navic
  { "SmiteshP/nvim-navic" },

  {
    "williamboman/mason.nvim",
    name = "mason.nvim",
    cmd = "Mason",
    ensure_installed = {
      "deno",
      "jq",
      "prettierd",
      "selene",
      "shellcheck",
      "shfmt",
      "stylua",
      "yamllint",
      "proselint",
      "shellharden",
      "codespell",
    },
    config = function(plugin)
      require("mason").setup()
      local mr = require("mason-registry")
      for _, tool in ipairs(plugin.ensure_installed) do
        local p = mr.get_package(tool)
        if not p:is_installed() then
          p:install()
        end
      end
    end,
  },
}
