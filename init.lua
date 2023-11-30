return {
  -- Configure AstroNvim updates
  updater = {
    remote = "origin", -- remote to use
    channel = "stable", -- "stable" or "nightly"
    version = "latest", -- "latest", tag name, or regex search like "v1.*" to only do updates before v2 (STABLE ONLY)
    branch = "nightly", -- branch name (NIGHTLY ONLY)
    commit = nil, -- commit hash (NIGHTLY ONLY)
    pin_plugins = nil, -- nil, true, false (nil will pin plugins on stable only)
    skip_prompts = false, -- skip prompts about breaking changes
    show_changelog = true, -- show the changelog after performing an update
    auto_quit = false, -- automatically quit the current session after a successful update
    remotes = { -- easily add new remotes to track
      --   ["remote_name"] = "https://remote_url.come/repo.git", -- full remote url
      --   ["remote2"] = "github_user/repo", -- GitHub user/repo shortcut,
      --   ["remote3"] = "github_user", -- GitHub user assume AstroNvim fork
    },
  },

  -- Set colorscheme to use
  colorscheme = "astrodark",

  -- Diagnostics configuration (for vim.diagnostics.config({...})) when diagnostics are on
  diagnostics = {
    virtual_text = true,
    underline = true,
  },

  lsp = {
    -- customize lsp formatting options
    formatting = {
      -- control auto formatting on save
      format_on_save = {
        enabled = false, -- enable or disable format on save globally
        allow_filetypes = { -- enable format on save for specified filetypes only
          -- "go",
        },
        ignore_filetypes = { -- disable format on save for specified filetypes
          -- "python",
        },
      },
      disabled = { -- disable formatting capabilities for the listed language servers
        -- disable lua_ls formatting capability if you want to use StyLua to format your lua code
        -- "lua_ls",
      },
      timeout_ms = 1000, -- default format timeout
      -- filter = function(client) -- fully override the default formatting function
      --   return true
      -- end
    },
    -- enable servers that you already have installed without mason
    servers = {
      -- "pyright"
    },
    config = {
        -- example for addings schemas to yamlls
        -- yamlls = { -- override table for require("lspconfig").yamlls.setup({...})
        --   settings = {
        --     yaml = {
        --       schemas = {
        --         ["http://json.schemastore.org/github-workflow"] = ".github/workflows/*.{yml,yaml}",
        --         ["http://json.schemastore.org/github-action"] = ".github/action.{yml,yaml}",
        --         ["http://json.schemastore.org/ansible-stable-2.9"] = "roles/tasks/*.{yml,yaml}",
        --       },
        --     },
        --   },
        -- },
        clangd = {
            --cmd = { "/home/zed0/src/boron/scripts/dev/clangd" },
            cmd = {
                "clangd",
                "--path-mappings=/home/zed0/src/boron=/usr/share/app",
            },
            capabilities = {
                offsetEncoding = "utf-8" 
            }
        },
        ccls = {
            init_options = {
                cache = {
                    directory = "/tmp/ccls",
                },
                compilationDatabaseDirectory = "build",
                index = {
                    threads = 6,
                },
                clang = {
                    pathMappings = {
                        "/usr/share/app/>/home/zed0/src/boron/",
                    },
                },
                --client = { snippetSupport = true },
                --highlight = { lsRanges = true }
            },
        },
    },
  },

  -- Configure require("lazy").setup() options
  lazy = {
    defaults = { lazy = true },
    performance = {
      rtp = {
        -- customize default disabled vim plugins
        disabled_plugins = { "tohtml", "gzip", "matchit", "zipPlugin", "netrwPlugin", "tarPlugin" },
      },
    },
  },

  -- This function is run last and is a good place to configuring
  -- augroups/autocommands and custom filetypes also this just pure lua so
  -- anything that doesn't fit in the normal config locations above can go here
  polish = function()
    -- Set up custom filetypes
    -- vim.filetype.add {
    --   extension = {
    --     foo = "fooscript",
    --   },
    --   filename = {
    --     ["Foofile"] = "fooscript",
    --   },
    --   pattern = {
    --     ["~/%.config/foo/.*"] = "fooscript",
    --   },
    -- }

    -- Disable search highlights disappearing when navigating
    vim.on_key(nil, vim.api.nvim_get_namespaces()["auto_hlsearch"])

    -- Fix telescope jumping to insert mode when opening a file
    local original_edit = require("telescope.actions.set").edit
    require("telescope.actions.set").edit = function(...)
      original_edit(...)
      vim.cmd.stopinsert()
    end

    local dap = require('dap')
    dap.adapters.cppdbg = {
      id = 'cppdbg',
      type = 'executable',
      command = os.getenv('HOME')..'/.local/share/vscode-cpptools/extension/debugAdapters/bin/OpenDebugAD7',
      -- command = os.getenv('HOME')..'/home/zed0/.local/share/nvim/mason/packages/cpptools/extension/debugAdapters/bin/OpenDebugAD7',
    }
    require('dap.ext.vscode').load_launchjs(nil, { cppdbg = {'c', 'cpp'} })
  end,
}
