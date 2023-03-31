local M = {}

local icons = require("rwaltr.util.icons")

--- Sets up vim.diagnostics.config
M.setup = function()
  local signs = {
    { name = "DiagnosticSignError", text = icons.diagnostics.Error },
    { name = "DiagnosticSignWarn", text = icons.diagnostics.Warning },
    { name = "DiagnosticSignHint", text = icons.diagnostics.Hint },
    { name = "DiagnosticSignInfo", text = icons.diagnostics.Information },
  }

  for _, sign in ipairs(signs) do
    vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
  end

  local diagnosticConfig = {
    -- disable virtual text
    virtual_text = true,
    -- show signs
    signs = {
      active = signs,
    },
    update_in_insert = true,
    underline = true,
    severity_sort = true,
    float = {
      focusable = true,
      style = "minimal",
      border = "rounded",
      source = "if_many",
      header = "",
      prefix = "",
    },
  }

  vim.diagnostic.config(diagnosticConfig)
end

---Sets Document Highlighting
---@param client vim.lsp.client
local function lsp_highlight_document(client)
  -- Set autocommands conditional on server_capabilities
  if client.server_capabilities.documentHighlightProvider then
    local status_ok, illuminate = pcall(require, "illuminate")
    if not status_ok then
      return
    end
    illuminate.on_attach(client)
  end
end

--- Sets Keymaps for LSP and notifies which-key
---@param bufnr buffer
local function lsp_keymaps(bufnr)
-- Inspired by https://github.com/ThePrimeagen/init.lua/blob/249f3b14cc517202c80c6babd0f9ec548351ec71/after/plugin/lsp.lua#L51

  local opts = { remap = false, buffer = bufnr }

  vim.keymap.set("n", "gD", function() vim.lsp.buf.declaration() end, opts)
  vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
  vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
  vim.keymap.set("n", "gi", function() vim.lsp.buf.implementation() end, opts)
  vim.keymap.set("n", "<C-k>", function() vim.lsp.buf.signature_help() end, opts)
  vim.keymap.set("n", "gr", function() vim.lsp.buf.references() end, opts)
  vim.keymap.set("n", "gl", function() vim.diagnostic.open_float() end, opts)
  vim.keymap.set("n", "[d", function() vim.diagnostic.goto_prev(opts) end, opts)
  vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev(opts) end, opts)

  local status_ok, wk = pcall(require, "which-key")
  if status_ok then
    wk.register({
      g = {
        D = "LSP Declaration",
        d = "LSP Definition",
        i = "LSP Implementation",
        r = "LSP Reference",
        l = "LSP Diagnostics",
      },
      K = "LSP Hover",
    })
  end
end

--- Calls Keymaps and highlights for buffer and client
---@param client vim.lsp.client LSP Client in use
---@param bufnr buffer Buffer number
M.on_attach = function(client, bufnr)
  if client.name == "tsserver" then
    client.server_capabilities.documentFormattingProvider = false
  end
  lsp_keymaps(bufnr)
  lsp_highlight_document(client)
end

local capabilities = vim.lsp.protocol.make_client_capabilities()

local ufo_ok = pcall(require, "ufo")
if ufo_ok then
  capabilities.textDocument.foldingRange = {
    dynamicRegistration = false,
    lineFoldingOnly = true,
  }
end

local cmp_nvim_lsp = require("cmp_nvim_lsp")


M.capabilities = cmp_nvim_lsp.default_capabilities(capabilities)

return M
