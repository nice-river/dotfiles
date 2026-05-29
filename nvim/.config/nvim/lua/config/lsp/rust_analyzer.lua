return {
  filetypes = {
    "rust",
  },

  root_markers = {
    "Cargo.toml",
    "rust-project.json",
    ".git",
  },

  settings = {
    ["rust-analyzer"] = {
      cargo = {
        allFeatures = true,
      },

      check = {
        command = "clippy",
      },

      diagnostics = {
        enable = true,
      },

      completion = {
        callable = {
          snippets = "add_parentheses",
        },
      },

      imports = {
        granularity = {
          group = "module",
        },
        prefix = "self",
      },
      inlayHints = {
        typeHints = {
          enable = true,
        },
        parameterHints = {
          enable = true,
        },
        chainingHints = {
          enable = true,
        },
        closingBraceHints = {
          enable = true,
        },
      },
    },
  },
}
