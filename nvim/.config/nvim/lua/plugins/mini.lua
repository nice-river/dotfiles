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
}
