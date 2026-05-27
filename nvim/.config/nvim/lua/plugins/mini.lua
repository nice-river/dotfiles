return {
  {
    "nvim-mini/mini.pairs",
    version = false,
    event = "InsertEnter",
    opts = {
      modes = {
        insert = true,
        command = false,
        terminal = false,
      },
    },
  },

  {
    "nvim-mini/mini.comment",
    version = false,
    event = "InsertEnter",
  },
  {
    "echasnovski/mini.sessions",
    version = false,
    event = "VeryLazy",
    opts = {
      autoread = true,
      autowrite = true,

      directory = vim.fn.stdpath("data") .. "/sessions",

      file = "",

      force = {
        read = true,
        write = true,
        delete = false,
      },

      verbose = {
        read = true,
        write = true,
        delete = true,
      },
    },
    config = function(_, opts)
      vim.o.sessionoptions = table.concat({
        "buffers",
        "curdir",
        "folds",
        "help",
        "tabpages",
        "winsize",
        "terminal",
        "localoptions",
      }, ",")

      require("mini.sessions").setup(opts)
    end,

    keys = {
      {
        "<leader>ps",
        function()
          require("mini.sessions").select()
        end,
        desc = "Select session",
      },
      {
        "<leader>pw",
        function()
          local default = vim.fn.fnamemodify(vim.fn.getcwd(), ":t")
          local name = vim.fn.input("Session name: ", default)
          if name == "" then
            return
          end
          require("mini.sessions").write(name)
        end,
        desc = "Write session",
      },
      {
        "<leader>pr",
        function()
          require("mini.sessions").select()
        end,
        desc = "Read session",
      },
      {
        "<leader>pd",
        function()
          local name = vim.fn.input("Delete session name: ")
          if name == "" then
            return
          end
          require("mini.sessions").delete(name)
        end,
        desc = "Delete session",
      },
    },
  },
}
