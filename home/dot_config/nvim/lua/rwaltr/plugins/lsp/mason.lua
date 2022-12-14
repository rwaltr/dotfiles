-- init ops 🤷
local opts = {
  on_attach = require("rwaltr.plugins.lsp.handlers").on_attach,
  capabilities = require("rwaltr.plugins.lsp.handlers").capabilities,
}
-- Import mason and lspconfig
local status_ok, mason = pcall(require, "mason")
if not status_ok then
  return
end

local mason_lspconfig_ok, mason_lspconfig = pcall(require, "mason-lspconfig")
if not mason_lspconfig_ok then
  return
end

-- Import Neoconf
local status_neoconf_ok , neoconf = pcall (require, "neoconf")
if status_neoconf_ok then
  neoconf.setup()
end



--#region Luadev
local l_status, neodev = pcall(require, "neodev")
if not l_status then
  vim.notify("No neodev")
  return
end
neodev.setup({})
--#endregion Luadev

local lspconfig_status_ok, lspconfig = pcall(require, "lspconfig")
if not lspconfig_status_ok then
  return
end

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
  "zk@v0.11.1",
}

local settings = {
  ui = {
    border = "rounded",
  },
  log_level = vim.log.levels.INFO,
  max_concurrent_installers = 4,
}

mason.setup(settings)
mason_lspconfig.setup {
  ensure_installed = servers,
  automatic_installation = true,
}



-- Mason setup_handlers expects the first key to be the "default function"
-- Then you can custiomize the handler using a key=value pair
-- [yamlls] = function() print hello end
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
    -- OLD
    -- local lua_opts = require("rwaltr.lsp.settings.sumneko_lua")
    -- local extended_opts = vim.tbl_deep_extend("force", lua_opts, opts)
    -- lspconfig.sumneko_lua.setup { extended_opts }
    -- /OLD
    lspconfig.sumneko_lua.setup({
      settings = {
        -- on_attach = opts.on_attach,
        -- capabilities = opts.capabilities,
        Lua = {
          diagnostics = {
            globals = {"vim"},
          },
          completion = {
            callSnippet = "Replace"
          }
        }
      }
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
  ["zk"] = function()
    local zk_opts = require("rwaltr.plugins.lsp.settings.zk")
    local extented_opts = vim.tbl_deep_extend("force", zk_opts, opts)
    lspconfig.zk.setup(extented_opts)
  end
  -- insert more here
})
require("rwaltr.plugins.ufo")
