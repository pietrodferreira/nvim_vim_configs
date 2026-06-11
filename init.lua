vim.g.mapleader = " "
vim.g.maplocal_leader = " "

vim.opt.termguicolors = true

vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2
vim.opt.expandtab = true

vim.opt.smartindent = true
vim.opt.autoindent = true

vim.opt.clipboard = "unnamedplus"

vim.opt.updatetime = 250

vim.opt.splitbelow = true
vim.opt.splitright = true

vim.opt.scrolloff = 8

vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.opt.wrap = false

vim.opt.signcolumn = "no"

vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

vim.keymap.set("n", "dd", '"_dd')

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not vim.uv.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end

vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",

    config = function()
      require("nvim-autopairs").setup({})
    end,
  },

  { "neovim/nvim-lspconfig" },

  { "stevearc/conform.nvim" },

  { "hrsh7th/nvim-cmp" },

  { "hrsh7th/cmp-nvim-lsp" },

  {
    "nvim-lualine/lualine.nvim",

    config = function()
      require("lualine").setup({
        options = {
          theme = "auto",
          component_separators = "",
          section_separators = "",
          globalstatus = true,
        },
      })
    end,
  },

  {
    "mg979/vim-visual-multi",
    branch = "master",
  },

  {
    "stevearc/oil.nvim",

    opts = {
      skip_confirm_for_simple_edits = true,

      view_options = {
        show_hidden = true,
      },

      delete_to_trash = false,

      keymaps = {
        ["<CR>"] = "actions.select",
        ["<C-v>"] = "actions.select_vsplit",
        ["<C-s>"] = "actions.select_split",
        ["<C-h>"] = "actions.parent",
        ["q"] = "actions.close",
      },
    },

    config = function(_, opts)
      require("oil").setup(opts)

      vim.keymap.set("n", "-", "<CMD>Oil<CR>")
    end,
  },

  {
    "akinsho/toggleterm.nvim",

    version = "*",

    opts = {
      direction = "horizontal",
      size = 15,
      open_mapping = [[<c-\>]],
      start_in_insert = true,
      insert_mappings = true,
    },
  },
})

vim.cmd.colorscheme("retrobox")

local capabilities = require("cmp_nvim_lsp").default_capabilities()

vim.lsp.config("clangd", {
  capabilities = capabilities,
})

vim.lsp.enable("clangd")

vim.lsp.config("basedpyright", {
  capabilities = capabilities,
})

vim.lsp.enable("basedpyright")

local cmp = require("cmp")

cmp.setup({
  preselect = cmp.PreselectMode.None,

  completion = {
    autocomplete = false,
  },

  mapping = cmp.mapping.preset.insert({
    ["<C-Space>"] = cmp.mapping.complete(),

    ["<Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      else
        fallback()
      end
    end, { "i", "s" }),

    ["<S-Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      else
        fallback()
      end
    end, { "i", "s" }),

    ["<C-y>"] = cmp.mapping.confirm({
      select = false,
    }),

    ["<Esc>"] = cmp.mapping.abort(),
  }),

  sources = {
    { name = "nvim_lsp" },
  },
})

vim.keymap.set("n", "gd", vim.lsp.buf.definition)
vim.keymap.set("n", "gD", vim.lsp.buf.declaration)
vim.keymap.set("n", "gr", vim.lsp.buf.references)
vim.keymap.set("n", "K", vim.lsp.buf.hover)
vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename)

vim.diagnostic.config({
  virtual_text = false,
  signs = false,
  underline = false,
  update_in_insert = false,
})

vim.keymap.set("n", "<leader>e", vim.diagnostic.setloclist)

vim.api.nvim_create_autocmd("TextYankPost", {
  callback = function()
    vim.highlight.on_yank({
      higroup = "IncSearch",
      timeout = 200,
    })
  end,
})

require("conform").setup({
  formatters_by_ft = {
    python = { "black" },
    c = { "clang-format" },
    cpp = { "clang-format" },
  },
})

vim.keymap.set("n", "\\f", function()
  require("conform").format({
    async = false,
    lsp_fallback = true,
  })
end)

vim.keymap.set("n", "<C-s>", "<cmd>w<CR>")
vim.keymap.set("i", "<C-s>", "<Esc><cmd>w<CR>")

vim.keymap.set("n", "<leader>t", "<cmd>ToggleTerm<CR>")

vim.api.nvim_set_hl(0, "Normal", { bg = "none", ctermbg = "none" })
vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none", ctermbg = "none" })
vim.api.nvim_set_hl(0, "NonText", { bg = "none", ctermbg = "none" })


vim.api.nvim_create_autocmd("VimEnter", {
callback = function()
io.stdout:write("\027[>1u")
end,
})

vim.api.nvim_create_autocmd("VimLeavePre", {
callback = function()
io.stdout:write("\027[<1u")
end,
})
