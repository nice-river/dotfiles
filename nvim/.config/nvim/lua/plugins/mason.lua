return {
  "mason-org/mason.nvim",
  dependencies = {
    "williamboman/mason-lspconfig.nvim",
    "neovim/nvim-lspconfig",
  },
  config = function()
    require("mason").setup()
    require("mason-lspconfig").setup({
      ensure_installed = {
        "basedpyright",
        "ruff",
        "emmylua_ls",
        "sylua",
        "rust-analyzer",
      },
      automatic_installation = true,
    })
  end,
}
