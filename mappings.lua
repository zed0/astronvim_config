-- Mapping data with "desc" stored directly by vim.keymap.set().
--
-- Please use this mappings table to set keyboard mapping since this is the
-- lower level configuration and more robust one. (which-key will
-- automatically pick-up stored data by this setting.)
return {
  -- first key is the mode
  n = {
    -- second key is the lefthand side of the map
    -- mappings seen under group name "Buffer"
    ["<leader>bn"] = { "<cmd>tabnew<cr>", desc = "New tab" },
    ["<leader>bD"] = {
      function()
        require("astronvim.utils.status").heirline.buffer_picker(function(bufnr) require("astronvim.utils.buffer").close(bufnr) end)
      end,
      desc = "Pick to close",
    },
    -- tables with the `name` key will be registered with which-key if it's installed
    -- this is useful for naming menus
    ["<leader>b"] = { name = "Buffers" },
    -- quick save
    -- ["<C-s>"] = { ":w!<cr>", desc = "Save File" },  -- change description but the same command
		["gh"] = { "<cmd>ClangdSwitchSourceHeader<cr>", desc = "Switch between .h and .cpp" },
		["gsh"] = { "<cmd>:sp<cr><cmd>ClangdSwitchSourceHeader<cr>", desc = "Split with .h/.cpp" },
		["]q"] = { "<cmd>cnext<cr>", desc = "Next quickfix result" },
		["[q"] = { "<cmd>cprevious<cr>", desc = "Previous quickfix result" },
		["gS"] = { "<cmd>:TSJSplit<cr><bar>:retab!<cr>", desc = "Split line" },
		["gJ"] = { "<cmd>:TSJJoin<cr><bar>:retab!<cr>", desc = "Join line" },
    ["L"] = { "gt" },
    ["H"] = { "gT" },

    ["<leader>h"] = { function() vim.opt.hlsearch = not(vim.opt.hlsearch:get()) end, desc = "Toggle search highlight"},

    -- LSP hover
    ["<leader>lH"] = { function() vim.lsp.buf.hover() end, desc = "Hover information"},
  },
  t = {
    -- setting a mapping to false will disable it
    -- ["<esc>"] = false,
  },
}
