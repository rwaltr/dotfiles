--LSPInstall

local lsp_installer = require "nvim-lsp-installer"

local function on_attach(client, bufnr)
  -- Set up buffer-local keymaps (vim.api.nvim_buf_set_keymap()), etc.


   -- formatting
  if client.name == 'tsserver' then
    client.resolved_capabilities.document_formatting = false
  end

  if client.resolved_capabilities.document_formatting then
    vim.api.nvim_command [[augroup Format]]
    vim.api.nvim_command [[autocmd! * <buffer>]]
    vim.api.nvim_command [[autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_seq_sync()]]
    vim.api.nvim_command [[augroup END]]
  end
end
lsp_installer.on_server_ready(function(server)
  -- Specify the default options which we'll use to setup all servers
  local default_opts = {
    on_attach = on_attach,
	  capabilities = require'cmp_nvim_lsp'.update_capabilities(vim.lsp.protocol.make_client_capabilities())
  }

  -- Now we'll create a server_opts table where we'll specify our custom LSP server configuration
  local server_opts = {
    -- Provide settings that should only apply to the "eslintls" server
    ["eslintls"] = function()
      default_opts.settings = {
        format = {
          enable = true,
        },
      }
    end,
		["sumneko_lua"] = function()
		  default_opts.settings = {
				Lua = {
					diagnostics = {
-- reconize Vim global
						globals = {"vim", "use"},
					},
					workspace = {
						library = {[vim.fn.expand('$VIMRUNTIME/lua')] = true, [vim.fn.expand('$VIMRUNTIME/lua/vim/lsp')] = true}
					},
				},
			}

		end,
  }


  -- Use the server's custom settings, if they exist, otherwise default to the default options
  local server_options = server_opts[server.name] and server_opts[server.name]() or default_opts
  server:setup(server_options)
end)

