-- Set <space> as the leader key
--  NOTE: Must happen before plugins are loaded (otherwise wrong leader will be used)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Set to true if you have a Nerd Font installed and selected in the terminal
vim.g.have_nerd_font = false

-- Sync clipboard between OS and Neovim.
-- Schedule the setting after `UiEnter` because it can increase startup-time.
-- Remove this option if you want your OS clipboard to remain independent.
-- See `:help 'clipboard'`
vim.schedule(function()
  vim.opt.clipboard = "unnamedplus"
end)

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.hl.on_yank()`
vim.api.nvim_create_autocmd("TextYankPost", {
  desc = "Highlight when yanking (copying) text",
  group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
  callback = function()
    vim.hl.on_yank({ timeout = 300 })
  end,
})

-- Remove '\r'(^M) when paste(shift + insert)
vim.paste = (function(overridden)
  return function(lines, phase)
    print("paste hook")
    for i, line in ipairs(lines) do
      lines[i] = line:gsub("\r", "")
    end
    return overridden(lines, phase)
  end
end)(vim.paste)

-- Make line numbers default
vim.opt.number = true
--  Add relative line numbers, to help with jumping
vim.opt.relativenumber = true

-- Every wrapped line will continue visually indented (same amount of
-- space as the beginning of that line), thus preserving horizontal
-- blocks of text.
vim.opt.breakindent = true

-- Enable undo/redo changes even after closing and reopening a file
vim.opt.undofile = true
-- Increase this if you want
-- vim.opt.undolevel = 10000

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Keep signcolumn on by default
vim.opt.signcolumn = "yes"

-- If this many milliseconds nothing is typed the swap file will be written to disk
vim.opt.updatetime = 200

-- Time in milliseconds to wait for a mapped sequence to complete.
vim.opt.timeoutlen = 800

-- Configure how new splits should be opened
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Sets how neovim will display certain whitespace characters in the editor.
--  See `:help 'list'`
--  and `:help 'listchars'`
--
--  Notice listchars is set using `vim.opt` instead of `vim.o`.
--  It is very similar to `vim.o` but offers an interface for conveniently interacting with tables.
--   See `:help lua-options`
--   and `:help lua-guide-options`
vim.opt.list = true
vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }

-- Preview substitutions live, as you type!
vim.opt.inccommand = "split"

-- Show which line your cursor is on
vim.opt.cursorline = true

-- Minimal number of screen lines to keep above and below the cursor.
vim.opt.scrolloff = 12

-- if performing an operation that would fail due to unsaved changes in the buffer (like `:q`),
-- instead raise a dialog asking if you wish to save the current file(s)
-- See `:help 'confirm'`
vim.opt.confirm = true

-- unix <EOL> format
vim.opt.fileformats = { "unix", "dos" }
vim.opt.fileformat = "unix"
