return {
  "ibhagwan/fzf-lua",
  -- optional for icon support
  dependencies = { "nvim-tree/nvim-web-devicons" },
  -- or if using mini.icons/mini.nvim
  -- dependencies = { "nvim-mini/mini.icons" },
  cmd = "FzfLua",
  keys = {
    { "<leader>sf", "<cmd>FzfLua files<cr>", desc = "Search Files" },
    { "<leader>sg", "<cmd>FzfLua live_grep<cr>", desc = "Search Grep" },
    { "<leader>sb", "<cmd>FzfLua buffers<cr>", desc = "Search Buffers" },
    { "<leader>sh", "<cmd>FzfLua help_tags<cr>", desc = "Search Help Tags" },
    { "<leader>sr", "<cmd>FzfLua oldfiles<cr>", desc = "Search Recent Files" },
    { "<leader>sc", "<cmd>FzfLua commands<cr>", desc = "Search Commands" },
    { "<leader>sk", "<cmd>FzfLua keymaps<cr>", desc = "Search Keymaps" },
    { "<leader>ld", "<cmd>FzfLua lsp_definitions<cr>", desc = "LSP Definitions" },
    { "<leader>lr", "<cmd>FzfLua lsp_references<cr>", desc = "LSP References" },
    { "<leader>ls", "<cmd>FzfLua lsp_document_symbols<cr>", desc = "Document Symbols" },
    { "<leader>lS", "<cmd>FzfLua lsp_workspace_symbols<cr>", desc = "Workspace Symbols" },
  },
  opts = {
    keymap = {
      builtin = {
        ["<C-f>"] = "preview-page-down",
        ["<C-b>"] = "preview-page-up",
        ["<C-d>"] = "preview-half-page-down",
        ["<C-u>"] = "preview-half-page-up",
        ["<C-n>"] = "preview-down",
        ["<C-p>"] = "preview-up",
      },
      fzf = {
        ["ctrl-j"] = "down",
        ["ctrl-k"] = "up",
        ["shift-down"] = "preview-page-down",
        ["shift-up"] = "preview-page-up",
      },
    },
    winopts = {
      height = 0.85,
      width = 0.85,
      row = 0.5,
      col = 0.5,
      preview = {
        layout = "flex",
        vertical = "down:45%",
        horizontal = "right:55%",
      },
    },
    files = {
      hidden = true,
      follow = true,
    },
    grep = {
      hidden = true,
      follow = true,
    },
  },
}
