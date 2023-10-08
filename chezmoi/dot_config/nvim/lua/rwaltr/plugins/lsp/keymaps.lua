local M = {}

M._keys = nil

--- Returns map of keys based on installed plugins and their capabilities needed
---@return (LazyKeys|{has?:string})[]
function M.get()
  ---@type LazyKeys{}
  local keys = {
    {},
  }

  return keys
end

-- Does LSP support this method?
---@param buffer buffer
---@param method string
---@return boolean 
function M.has(buffer, method)
  method = method:find("/") and method or "textDocument/" .. method
  local clients = vim.lsp.get_active_clients({ bufnr = buffer })
  for _, client in ipairs(clients) do
    if client.supports_method(method) then
      return true
    end
  end
  return false
end

-- The function that should run when an LSP is attached
---@param client lsp.Client
---@param buffer buffer
function M.on_attach(client, buffer)
  
end

return M
