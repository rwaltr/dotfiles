return { {
  "gnikdroy/projections.nvim",
  cmd = "Telescope projections",
  event = "VeryLazy",
  config = function()
    --- exports table of dirs in "~/src/"
    ---@return table workspaces
    local function yankworkspaces()
      local workspaces = {}
      for name, type in vim.fs.dir("~/src/") do
        if type == "directory" then
          table.insert(workspaces, '~/src/' .. name)
        end
      end
      return workspaces
    end

    local workspaces = yankworkspaces()
    table.insert(workspaces, "~/.local/share")

    -- TODO: Integrate with https://github.com/folke/persistence.nvim
    require("projections").setup({
      workspaces = workspaces,
      -- workspaces = {
      -- "~/src/rwaltr",
      -- { "~/.local/share", { ".git" } }, -- My dotfiles are normally here
      -- },
      patterns = { ".git", ".svn", ".hg", ".zk" },
    })

    require("telescope").load_extension("projections")
    vim.opt.sessionoptions:append("localoptions")

  end
} }
