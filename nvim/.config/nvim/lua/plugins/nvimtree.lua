return {
  "nvim-tree/nvim-tree.lua",
  version = "*",

  -- in order to replace `netrw`
  lazy = false,

  -- It is strongly recommended to disable |netrw|. As it is a bundled plugin it
  -- must be disabled manually at the start of your `init.lua` as per |netrw-noload|:
  --   vim.g.loaded_netrw       = 1
  --   vim.g.loaded_netrwPlugin = 1
  init = function()
    -- forbid `netrw` load
    vim.g.loaded_netrw = 1
    vim.g.loaded_netrwPlugin = 1
  end,

  keys = {
    { "<leader>e", "<cmd>NvimTreeToggle<cr>", desc = "Explorer" },
    { "<leader>E", "<cmd>NvimTreeFindFile<cr>", desc = "Explorer Find File" },
  },
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  opts = {
    disable_netrw = true,
    hijack_netrw = true,

    hijack_directories = {
      enable = true,
      auto_open = true,
    },

    view = {
      width = 32,
      side = "right",
    },
    renderer = {
      group_empty = true,
      highlight_git = true,
      highlight_diagnostics = true,
    },
    filters = {
      dotfiles = false,
      git_ignored = false,
    },
    git = {
      enable = true,
      ignore = false,
    },
    diagnostics = {
      enable = true,
      show_on_dirs = true,
    },
    update_focused_file = {
      enable = true,
      update_root = true,
    },
    on_attach = function(bufnr)
      local api = require("nvim-tree.api")

      api.config.mappings.default_on_attach(bufnr)

      local function map(lhs, rhs, desc)
        vim.keymap.set("n", lhs, rhs, {
          buffer = bufnr,
          noremap = true,
          silent = true,
          nowait = true,
          desc = "nvim-tree: " .. desc,
        })
      end

      map("h", api.node.navigate.parent_close, "Close Parent Directory")
      map("l", api.node.open.edit, "Open")
    end,
  },
}
