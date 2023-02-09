-- TODO: Replace with either..
-- https://github.com/nvim-telescope/telescope-project.nvim
-- https://github.com/ahmedkhalf/project.nvim
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

    require("projections").setup({
      workspaces = workspaces,

      patterns = { ".git", ".svn", ".hg", ".zk" },
    })

    require("telescope").load_extension("projections")
    vim.opt.sessionoptions:append("localoptions")

  end
},
{
  "olimorris/persisted.nvim",
  cmd = {
      "SessionToggle",
      "SessionStart",
      "SessionStop",
      "SessionSave",
      "SessionLoad",
      "SessionLoadLast",
      "SessionDelete",
    },
  config = function()
    require("persisted").setup()
    require("telescope").load_extension("persisted") -- To load the telescope extension
  end,
}
}
