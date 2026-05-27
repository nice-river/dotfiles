return {
  "nvim-tree/nvim-tree.lua",
  version = "*",
  cmd = {
    "NvimTreeToggle",
    "NvimTreeOpen",
    "NvimTreeClose",
    "NvimTreeFocus",
    "NvimTreeFindFile",
  },
  keys = {
    { "<leader>e", "<cmd>NvimTreeToggle<cr>", desc = "Explorer" },
    { "<leader>E", "<cmd>NvimTreeFindFile<cr>", desc = "Explorer Find File" },
  },
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  opts = {
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
