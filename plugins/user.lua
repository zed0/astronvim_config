return {
  -- You can also add new plugins here as well:
  -- Add plugins, the lazy syntax
  -- "andweeb/presence.nvim",
  -- {
  --   "ray-x/lsp_signature.nvim",
  --   event = "BufRead",
  --   config = function()
  --     require("lsp_signature").setup()
  --   end,
  -- },
  {
    "tpope/vim-fugitive",
    lazy = false,
  },
  {
    "simnalamburt/vim-mundo",
    lazy = false,
  },
  {
    "AndrewRadev/linediff.vim",
    lazy = false,
  },
  {
    "gpanders/editorconfig.nvim",
    lazy = false,
  },
  {
    "L3MON4D3/LuaSnip",
    config = function(plugin, opts)
      require "plugins.configs.luasnip"(plugin, opts) -- include the default astronvim config that calls the setup call
      require("luasnip.loaders.from_vscode").lazy_load { paths = { "/home/zed0/.config/nvim/lua/user/snippets" } } -- load snippets paths
    end
  },
}
