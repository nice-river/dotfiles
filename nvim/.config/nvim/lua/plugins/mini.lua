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
          local sessions = require("mini.sessions")
          local fzf = require("fzf-lua")

          local names = vim.tbl_keys(sessions.detected)
          if vim.tbl_isempty(names) then
            vim.notify("No sessions found", vim.log.levels.WARN)
            return
          end

          table.sort(names)
          local entries = {}
          for i, name in ipairs(names) do
            entries[i] = string.format("%2d  %s", i, name)
          end

          fzf.fzf_exec(entries, {
            prompt = "Sessions> ",
            actions = {
              ["default"] = function(selected)
                local line = selected[1]
                if not line then
                  return
                end
                local name = line:match("^%s*%d+%s+(.+)$")
                if name then
                  sessions.read(name)
                end
              end,
            },
          })
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
  {
    "nvim-mini/mini.indentscope",
    version = false,
    event = { "BufReadPost", "BufNewFile" },
    config = function()
      require("mini.indentscope").setup({
        symbol = "│",
        draw = {
          delay = 100,
          animation = require("mini.indentscope").gen_animation.none(),
        },
        options = {
          try_as_border = true,
        },
      })

      vim.api.nvim_create_autocmd("FileType", {
        group = vim.api.nvim_create_augroup("DisableMiniIndentscope", { clear = true }),
        pattern = {
          "help",
          "lazy",
          "mason",
          "NvimTree",
          "fzf",
          "fzf-lua",
          "Trouble",
        },
        callback = function(args)
          vim.b[args.buf].miniindentscope_disable = true
        end,
      })
    end,
  },
}
