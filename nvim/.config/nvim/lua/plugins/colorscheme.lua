return { -- the colorscheme should be available when starting Neovim
  {
    "folke/tokyonight.nvim",
    lazy = true, -- make sure we load this during startup if it is your main colorscheme
    -- priority = 1000, -- make sure to load this before all the other start plugins
    -- config = function(_, opts)
    --   -- load the colorscheme here
    --   require("tokyonight").setup(opts)
    --   vim.cmd.colorscheme("tokyonight")
    -- end,
  },
  {
    "thesimonho/kanagawa-paper.nvim",
    lazy = true,
    -- priority = 1000,
    opts = {},
  },
  -- Using lazy.nvim
  {
    "ribru17/bamboo.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      require("bamboo").setup({
        -- optional configuration here
      })
      vim.cmd.colorscheme("bamboo")
    end,
  },
  {
    "AvengeMedia/base46",
    lazy = true,
    opts = {},
  },
}
