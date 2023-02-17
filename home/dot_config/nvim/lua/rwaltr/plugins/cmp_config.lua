-- Autocompletion
return { {
  "hrsh7th/nvim-cmp",
  name = "nvim-cmp",
  event = "InsertEnter",
  dependencies = {
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",
    "hrsh7th/cmp-cmdline",
    "saadparwaiz1/cmp_luasnip",
    "f3fora/cmp-spell",
    "hrsh7th/cmp-emoji",
    "hrsh7th/cmp-calc",
    {
      "petertriho/cmp-git",
      config = true
    },
  },
  config = function()

    local cmp = require("cmp")

    local snip_status_ok, luasnip = pcall(require, "luasnip")
    if not snip_status_ok then
      return
    end


    local check_backspace = function()
      local col = vim.fn.col(".") - 1
      ---@diagnostic disable-next-line: param-type-mismatch, undefined-field
      return col == 0 or vim.fn.getline("."):sub(col, col):match("%s")
    end

    local kind_icons = require("rwaltr.util.icons").kind


    -- find more here: https://www.nerdfonts.com/cheat-sheet
    cmp.setup({
      snippet = {
        expand = function(args)
          require("luasnip").lsp_expand(args.body) -- For `luasnip` users.
        end,
      },
      mapping = cmp.mapping.preset.insert {
        ["<C-k>"] = cmp.mapping.select_prev_item(),
        ["<C-j>"] = cmp.mapping.select_next_item(),
        ["<C-b>"] = cmp.mapping(cmp.mapping.scroll_docs(-4), { "i", "c" }),
        ["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(4), { "i", "c" }),
        ["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
        ["<C-y>"] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
        ["<C-e>"] = cmp.mapping({
          i = cmp.mapping.abort(),
          c = cmp.mapping.close(),
        }),
        ["<CR>"] = cmp.mapping.confirm({ select = true }),
        ["<C-CR>"] = cmp.mapping(function(fallback)
          if luasnip.expandable() then
            luasnip.expand()
          elseif luasnip.expand_or_jumpable() then
            luasnip.expand_or_jump()
          elseif check_backspace() then
            fallback()
          else
            fallback()
          end
        end, {
          "i",
          "s",
        }),
        ["<S-CR>"] = cmp.mapping(function(fallback)
          if luasnip.jumpable(-1) then
            luasnip.jump(-1)
          else
            fallback()
          end
        end, {
          "i",
          "s",
        }),
      },
      experimental = {
        ghost_text = {
          enabled = true,
          hl_group = "LspCodeLens",
        },
      },
      formatting = {
        fields = { "kind", "abbr", "menu" },
        format = function(entry, vim_item)
          -- Kind icons
          vim_item.kind = string.format("%s", kind_icons[vim_item.kind])
          -- vim_item.kind = string.format('%s %s', kind_icons[vim_item.kind], vim_item.kind) -- This concatenates the icons with the name of the item kind
          vim_item.menu = ({
            luasnip = "[Snippet]",
            buffer = "[Buffer]",
            path = "[Path]",
            spell = "[Spelling]",
            nvim_lsp = "[LSP]",
            cmdline = "[CMD]",
            emoji = "[Emoji]",
            calc = "[Calc]",
            git = "[Git]",
            nvim_lua = "[NvimLua]",
            codium = "[Codium]"
          })[entry.source.name]
          return vim_item
        end,
      },
      sources = cmp.config.sources({
        { name = "nvim_lsp" },
        { name = "luasnip" }, -- For luasnip users.
        { name = "git" },
        { name = "path" },
        { name = "codium" },
        {
          name = "buffer",
          option = {
            get_bufnrs = function()
              return vim.api.nvim_list_bufs()
            end,
          },
        },
        { name = "calc" },
        { name = "emoji" },
        { name = "spell" },
      }),
    })
    -- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
    cmp.setup.cmdline({ "/", "?" }, {
      sources = {
        { name = "buffer" },
      },
    })

    cmp.setup.filetype({ 'gitcommit', 'octo' }, {
      sources = cmp.config.sources({
        { name = 'git' },
        { name = 'buffer' },
        { name = 'luasnip' },
        { name = 'emoji' },
        { name = 'spell' },
      })
    })

    -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
    cmp.setup.cmdline(":", {
      sources = cmp.config.sources({
        { name = "path" },
      }, {
        { name = "cmdline" },
      }),
    })

  end,
},
  {
    "jcdickinson/codeium.nvim",
    config = true,
    cmd = { "Codeium" },
    before = "nvim-cmp"
  },
}
