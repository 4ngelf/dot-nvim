return {
  {
    "williamboman/mason-lspconfig.nvim",
    opts = { ensure_installed = { "vale_ls" } },
  },
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        ["vale_ls"] = {
          filetypes = { "text", "plaintex", "typst", "gitcommit", "markdown" },
        },
      },
    },
  },
}
