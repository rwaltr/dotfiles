-- Import mason and lspconfig
local mason_lspconfig_ok, mason_lspconfig = pcall(require, "mason-lspconfig") 
if not mason_lspconfig_ok then
  return
end
local lspconfig_status_ok, lspconfig = pcall(require, "lspconfig")
if not lspconfig_status_ok then
  return
end

-- init ops 🤷
local opts = {}

-- Mason setup_handlers expects the first key to be the "default function"
-- Then you can custiomize the handler using a key=value pair
-- [yamlls] = function() print hello end
mason_lspconfig.setup_handlers({
  -- Default Function
  function (server_name)
   opts = {
      on_attach = require("rwaltr.lsp.handlers").on_attach, 
      capabilities = require("rwaltr.lsp.handlers").capabilities,
    }
    lspconfig[server_name].setup{opts}
  end,
  ["jsonls"] = function ()
    lspconfig.jsonls.setup{opts}
  end,
})
