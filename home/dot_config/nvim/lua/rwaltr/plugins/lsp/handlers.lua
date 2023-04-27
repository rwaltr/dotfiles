local M = {}

---Sets Document Highlighting
---@param client lsp.Client
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
---@param bufnr Buffer
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
---@param client lsp.Client
---@param bufnr Buffer Buffer number
M.on_attach = function(client, bufnr)
  if client.name == "tsserver" then
    client.server_capabilities.documentFormattingProvider = false
  end
  lsp_keymaps(bufnr)
  lsp_highlight_document(client)
end

-- local ufo_ok = pcall(require, "ufo")
-- if ufo_ok then
--   capabilities.textDocument.foldingRange = {
--     dynamicRegistration = false,
--     lineFoldingOnly = true,
--   }
-- end

return M
