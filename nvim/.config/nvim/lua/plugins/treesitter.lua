return {
  "nvim-treesitter/nvim-treesitter",
  branch = "main",
  build = ":TSUpdate",
  event = { "BufReadPost", "BufNewFile", "FileType" },
  config = function()
    vim.api.nvim_create_autocmd("FileType", {
      group = vim.api.nvim_create_augroup("UserTreesitter", { clear = true }),
      callback = function(args)
        local lang = vim.treesitter.language.get_lang(vim.bo[args.buf].filetype)
        if not lang then
          return
        end

        pcall(vim.treesitter.start, args.buf, lang)
        vim.bo[args.buf].indentexpr = "v:lua.require('nvim-treesitter').indentexpr()"
      end,
    })
  end,
}
