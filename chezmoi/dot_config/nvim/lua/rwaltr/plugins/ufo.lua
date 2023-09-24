return { {
  "kevinhwang91/nvim-ufo",
  enabled = true,
  dependencies = "kevinhwang91/promise-async",
  event = "BufReadPre",
  config = function()
    local status_ok, ufo = pcall(require, "ufo")
    if not status_ok then
      return
    end

    local ftMap = {
      yaml = { 'treesitter', "indent" },
      git = '',
    }
    -- Overwrite options
    -- foldcolumn set to 0 hides the column
    -- when its set to '1' or 'auto' it will show it
    vim.o.foldcolumn = '0'
    vim.o.foldlevel = 99
    vim.o.foldlevelstart = 99
    vim.o.foldenable = true
    vim.o.foldminlines = 0

    --[[ annoying chars sets ]]
    vim.o.fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]]
    -- set keymaps
    vim.keymap.set('n', 'zR', require("ufo").openAllFolds)
    vim.keymap.set('n', 'zM', require("ufo").closeAllFolds)
    vim.keymap.set('n', 'zr', require('ufo').openFoldsExceptKinds)
    vim.keymap.set('n', 'zm', require('ufo').closeFoldsWith) -- closeAllFolds == closeFoldsWith(0)

    -- set Highlights..
    local hl = vim.api.nvim_get_hl_by_name("ColorColumn", true)
    vim.api.nvim_set_hl(0, "FoldColumn", hl)

    -- Virt Text Handler
    local handler = function(virtText, lnum, endLnum, width, truncate)
      local newVirtText = {}
      local suffix = ('  %d '):format(endLnum - lnum)
      local sufWidth = vim.fn.strdisplaywidth(suffix)
      local targetWidth = width - sufWidth
      local curWidth = 0
      for _, chunk in ipairs(virtText) do
        local chunkText = chunk[1]
        local chunkWidth = vim.fn.strdisplaywidth(chunkText)
        if targetWidth > curWidth + chunkWidth then
          table.insert(newVirtText, chunk)
        else
          chunkText = truncate(chunkText, targetWidth - curWidth)
          local hlGroup = chunk[2]
          table.insert(newVirtText, { chunkText, hlGroup })
          chunkWidth = vim.fn.strdisplaywidth(chunkText)
          -- str width returned from truncate() may less than 2nd argument, need padding
          if curWidth + chunkWidth < targetWidth then
            suffix = suffix .. (' '):rep(targetWidth - curWidth - chunkWidth)
          end
          break
        end
        curWidth = curWidth + chunkWidth
      end
      table.insert(newVirtText, { suffix, 'MoreMsg' })
      return newVirtText
    end

    -- enable UFO
    ufo.setup({
      open_fold_hl_timeout = 150,
      close_fold_kinds = { 'imports', 'comment' },
      fold_virt_text_handler = handler,
      provider_selector = function(bufnr, filetype, buftype)
        -- return a string type use internal providers
        -- return a string in a table like a string type
        -- return empty string '' will disable any providers
        -- return `nil` will use default value {'lsp', 'indent'}

        -- if you prefer treesitter provider rather than lsp,
        -- return ftMap[filetype] or {'treesitter', 'indent'}
        return ftMap[filetype]
      end,
      preview = {
        win_config = {
          winhighlight = 'Normal:Folded',
          winblend = 0
        },
      },
    })

  end
} }
