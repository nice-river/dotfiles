local M = {}

M.servers = {
  emmylua_ls = require("config.lsp.emmylua_ls"),
  rust_analyzer = require("config.lsp.rust_analyzer"),
  basedpyright = require("config.lsp.basedpyright"),
}

function M.on_attach()
  vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("UserLspAttach", { clear = true }),
    callback = function(args)
      local bufnr = args.buf
      local client = vim.lsp.get_client_by_id(args.data.client_id)

      if client and client:supports_method("textDocument/inlayHint") then
        vim.lsp.inlay_hint.enable(true, {
          bufnr = bufnr,
        })
      end

      local map = function(mode, lhs, rhs, desc)
        vim.keymap.set(mode, lhs, rhs, {
          buffer = bufnr,
          desc = desc,
        })
      end

      map("n", "gd", vim.lsp.buf.definition, "Goto definition")
      map("n", "gD", vim.lsp.buf.declaration, "Goto declaration")
      map("n", "gr", vim.lsp.buf.references, "References")
      map("n", "gi", vim.lsp.buf.implementation, "Goto implementation")
      map("n", "K", vim.lsp.buf.hover, "Hover")
      map("n", "<leader>rn", vim.lsp.buf.rename, "Rename")
      map("n", "<leader>ca", vim.lsp.buf.code_action, "Code action")
      map("n", "<leader>cd", vim.diagnostic.open_float, "Line diagnostic")
      map("n", "]w", function()
        vim.diagnostic.jump({
          count = 1,
          severity = vim.diagnostic.severity.WARN,
          float = true,
        })
      end, "Next warning")

      map("n", "[w", function()
        vim.diagnostic.jump({
          count = -1,
          severity = vim.diagnostic.severity.WARN,
          float = true,
        })
      end, "Previous warning")

      map("n", "]e", function()
        vim.diagnostic.jump({
          count = 1,
          severity = vim.diagnostic.severity.ERROR,
          float = true,
        })
      end, "Next error")

      map("n", "[e", function()
        vim.diagnostic.jump({
          count = -1,
          severity = vim.diagnostic.severity.ERROR,
          float = true,
        })
      end, "Previous error")
    end,
  })
end

function M.setup()
  M.on_attach()

  for name, config in pairs(M.servers) do
    vim.lsp.config(name, config)
    vim.lsp.enable(name)
  end
end

return M
