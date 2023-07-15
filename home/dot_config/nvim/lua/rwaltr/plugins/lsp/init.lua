return {
  {
    "neovim/nvim-lspconfig",
    name = "nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      { "folke/neoconf.nvim", cmd = "Neoconf", config = false, dependencies = { "nvim-lspconfig" } },
      { "mason.nvim" },
      { "folke/lsp-colors.nvim" },
      { "simrat39/symbols-outline.nvim", config = true },
      { "folke/neodev.nvim", config = true },
      { "williamboman/mason-lspconfig.nvim" },
      { "hrsh7th/cmp-nvim-lsp" },
    },

    ---@class PluginLspOpts
    opts = {
      diagnostics = {
        -- disable virtual text
        virtual_text = {
          spacing = 4,
          source = "if_many",
          prefix = "● ",
          -- this will set set the prefix to a function that returns the diagnostics icon based on the severity
          -- this only works on a recent 0.10.0 build. Will be set to "●" when not supported
          -- prefix = "icons",
        },
        -- -- show signs
        -- signs = {
        --   active = signs,
        -- },
        update_in_insert = false,
        underline = true,
        severity_sort = true,
        -- float = {
        --   focusable = false,
        --   style = "minimal",
        --   border = "rounded",
        --   source = "if_many",
        --   header = "",
        --   prefix = "",
        -- },
      },
      -- add any global capabilities here
      capabilities = {
        textDocument = {
          foldingRange = {
            dynamicRegistration = false,
            lineFoldingOnly = true,
          },
        },
      },
      -- Automatically format on save
      autoformat = true,
      -- options for vim.lsp.buf.format
      -- `bufnr` and `filter` is handled by the LazyVim formatter,
      -- but can be also overridden when specified
      format = {
        formatting_options = nil,
        timeout_ms = nil,
      },
      -- LSP server settings
      ---@type lspconfig.options
      servers = {
        yamlls = {
          settings = {
            yaml = {
              keyOrdering = false,
            },
          },
        },
        jsonls = {
          settings = {
            json = {},
          },
        },
        lua_ls = {
          -- mason = false, -- set to false if you don't want this server to be installed with mason
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
        },
        bashls = {},
        dockerls = {},
        gopls = {},
        marksman = {},
        terraformls = {},
        tflint = {},
      },
      -- you can do any additional lsp server setup here
      -- return true if you don't want this server to be setup with lspconfig
      ---@type table<string, fun(server:string, opts:_.lspconfig.options):boolean?>
      setup = {
        yamlls = function(_, opts)
          local cfg = require("yaml-companion").setup()
          require("lspconfig")["yamlls"].setup(vim.tbl_deep_extend("force", opts, cfg))
          return true
        end,
        jsonls = function(_, opts)
          local cfg = {
            settings = {
              json = {
                schemas = require("schemastore").json.schemas(),
                validate = { enable = true },
              },
            },
          }
          require("lspconfig")["jsonls"].setup(vim.tbl_deep_extend("force", opts, cfg))
          return true
        end,
      },
    },

    ---@param opts PluginLspOpts
    config = function(_, opts)

      -- Set up NeoConf
      local plugin = require("lazy.core.config").spec.plugins["neoconf.nvim"]
      require("neoconf").setup(require("lazy.core.plugin").values(plugin, "opts", false))

      -- Setup on_attach
      local util = require("rwaltr.util")
      util.on_attach(function(client, buffer)
        -- TODO: Refactor LSP Interface and Keybinds
        require("rwaltr.plugins.lsp.handlers").on_attach(client, buffer)
      end)

      -- Diagnostics
      for name, icon in pairs(require("rwaltr.util.icons").diagnostics) do
        name = "DiagnosticSign" .. name
        vim.fn.sign_define(name, { text = icon, texthl = name, numhl = "" })
      end

      vim.diagnostic.config(vim.deepcopy(opts.diagnostics))

      local servers = opts.servers
      local capabilities = vim.tbl_deep_extend(
        "force",
        {},
        vim.lsp.protocol.make_client_capabilities(),
        require("cmp_nvim_lsp").default_capabilities(),
        opts.capabilities or {}
      )

      -- Server Setup
      local function setup(server)
        local server_opts = vim.tbl_deep_extend("force", {
          capabilities = vim.deepcopy(capabilities),
        }, servers[server] or {})

        if opts.setup[server] then
          if opts.setup[server](server, server_opts) then
            return
          end
        elseif opts.setup["*"] then
          if opts.setup["*"](server, server_opts) then
            return
          end
        end
        require("lspconfig")[server].setup(server_opts)
      end

      -- Grab all Mason packages
      local have_mason, mlsp = pcall(require, "mason-lspconfig")
      local all_mslp_servers = {}
      if have_mason then
        all_mslp_servers = vim.tbl_keys(require("mason-lspconfig.mappings.server").lspconfig_to_package)
      end

      local ensure_installed = {} ---@type string[]
      for server, server_opts in pairs(servers) do
        if server_opts then
          server_opts = server_opts == true and {} or server_opts
          -- run manual setup if mason=false or if this is a server that cannot be installed with mason-lspconfig
          if server_opts.mason == false or not vim.tbl_contains(all_mslp_servers, server) then
            setup(server)
          else
            ensure_installed[#ensure_installed + 1] = server
          end
        end
      end

      if have_mason then
        mlsp.setup({ ensure_installed = ensure_installed, handlers = { setup } })
      end
    end,
  },

  {
    "jose-elias-alvarez/null-ls.nvim",
    event = { "BufReadPre", "BufNewFile" },
    enabled = false,
    dependencies = {
      "mason.nvim",
    },
    --#region Null LS Config
    config = function()
      local nls = require("null-ls")
      local format = nls.builtins.formatting
      local diag = nls.builtins.diagnostics
      local ca = nls.builtins.code_actions
      local hvr = nls.builtins.hover
      nls.setup({
        root_dir = require("null-ls.utils").root_pattern(".null-ls.root", ".neoconf.json", ".git", "Makefile"),
        -- on_attach = require("rwaltr.plugins.lsp.handlers").on_attach,
        sources = {
          ca.gitrebase,
          ca.gitsigns,
          ca.proselint,
          ca.shellcheck,
          diag.codespell,
          diag.fish,
          diag.proselint,
          diag.shellcheck,
          -- diag.yamllint,
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
  {
    "someone-stole-my-name/yaml-companion.nvim",
    ft = "yaml",
    config = function()
      require("telescope").load_extension("yaml_schema")
    end,
  },
  {
    "SmiteshP/nvim-navic",
    init = function()
      vim.g.navic_silence = true
      require("rwaltr.util").on_attach(function(client, buffer)
        if client.server_capabilities.documentSymbolProvider then
          require("nvim-navic").attach(client, buffer)
        end
      end)
    end,
    opts = function()
      return {
        separator = " ",
        highlight = true,
        depth_limit = 5,
        icons = require("rwaltr.util.icons").kind,
      }
    end,
  },

  {
    "williamboman/mason.nvim",
    name = "mason.nvim",
    cmd = "Mason",
    build = ":MasonUpdate",
    opts = {
      ensure_installed = {
        "jq",
        "prettierd",
        "shellcheck",
        "shfmt",
        "stylua",
        "yamllint",
        "proselint",
        "codespell",
      },
    },
    -- @params opts MasonSettings | {ensure_installed: string[]}
    config = function(_, opts)
      require("mason").setup()
      local mr = require("mason-registry")
      local function ensure_installed()
        for _, tool in ipairs(opts.ensure_installed) do
          local p = mr.get_package(tool)
          if not p:is_installed() then
            p:install()
          end
        end
      end

      if mr.refresh then
        mr.refresh(ensure_installed)
      else
        ensure_installed()
      end
    end,
  },
  {
    "ray-x/lsp_signature.nvim",
    config = function()
      require("rwaltr.plugins.lsp.signature")
    end,
    enabled = false,
  },
}
