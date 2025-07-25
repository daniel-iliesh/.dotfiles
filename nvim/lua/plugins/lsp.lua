return {
  "neovim/nvim-lspconfig",
  dependencies = {
    "stevearc/conform.nvim",
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",
    "hrsh7th/cmp-cmdline",
    "hrsh7th/nvim-cmp",
    "L3MON4D3/LuaSnip",
    "saadparwaiz1/cmp_luasnip",
    "j-hui/fidget.nvim",
  },

  config = function()
    require("conform").setup({
      formatters_by_ft = {
      }
    })
    local cmp = require('cmp')
    local cmp_lsp = require("cmp_nvim_lsp")
    local capabilities = vim.tbl_deep_extend(
      "force",
      {},
      vim.lsp.protocol.make_client_capabilities(),
      cmp_lsp.default_capabilities())

    require("fidget").setup({})
    require("mason").setup()
    require("mason-lspconfig").setup({
      ensure_installed = {
        "lua_ls",
        "rust_analyzer",
        "vue_ls",
        "ts_ls",
      },
      handlers = {
        function(server_name) -- default handler (optional)
          require("lspconfig")[server_name].setup {
            capabilities = capabilities
          }
        end,

        zls = function()
          local lspconfig = require("lspconfig")
          lspconfig.zls.setup({
            root_dir = lspconfig.util.root_pattern(".git", "build.zig", "zls.json"),
            settings = {
              zls = {
                enable_inlay_hints = true,
                enable_snippets = true,
                warn_style = true,
              },
            },
          })
          vim.g.zig_fmt_parse_errors = 0
          vim.g.zig_fmt_autosave = 0

        end,
        ["lua_ls"] = function()
          local lspconfig = require("lspconfig")
          lspconfig.lua_ls.setup {
            capabilities = capabilities,
            settings = {
              Lua = {
                runtime = { version = "Lua 5.1" },
                diagnostics = {
                  globals = { "bit", "vim", "it", "describe", "before_each", "after_each" },
                }
              }
            }
          }
        end,

        -- --- Add the handler for Vue Language Server (Volar) ---
        -- Use the Mason identifier 'vue_ls' as the key in the handlers table
        vue_ls = function()
          local lspconfig = require("lspconfig")
          -- Configure using lspconfig.vue_ls.setup, as indicated by your Mason output's mapping
          lspconfig.vue_ls.setup({
            capabilities = capabilities, -- Pass common capabilities
            filetypes = { 'typescript', 'javascript', 'javascriptreact', 'typescriptreact', 'vue' },
            init_options = {
              vue = {
                hybridMode = false, -- Recommended for Vue 3, Volar handles TS in .vue
              },
              -- Optional: Specify the path to the TypeScript library if needed.
              -- If Mason installs ts_ls correctly, this might not be needed.
              -- Example path using Mason's default install location (adjust if yours differs):
              -- typescript = {
              --   tsdk = vim.fn.stdpath('data') .. '/mason/packages/ts_ls/node_modules/typescript/lib'
              -- }
            },
            -- root_dir detection is typically handled by Mason
          })
        end,

        -- --- Add the handler for TypeScript Language Server ---
        -- Use the Mason identifier 'ts_ls' as the key in the handlers table
        ts_ls = function()
          local lspconfig = require("lspconfig")
          -- Configure using lspconfig.ts_ls.setup
          lspconfig.ts_ls.setup({
            capabilities = capabilities, -- Pass common capabilities
            -- IMPORTANT: Exclude 'vue' filetype here because vue_ls (Volar)
            -- is configured with hybridMode = false and includes 'vue'
            -- in its own filetypes, taking responsibility for TS in .vue files.
            filetypes = { 'javascript', 'javascriptreact', 'typescript', 'typescriptreact' }, -- Exclude 'vue'
            -- Add any other general ts_ls settings you might need here
          })
        end,
      }
    })

    local cmp_select = { behavior = cmp.SelectBehavior.Select }

    cmp.setup({
      snippet = {
        expand = function(args)
          require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
        end,
      },
      mapping = cmp.mapping.preset.insert({
        ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
        ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
        ['<C-y>'] = cmp.mapping.confirm({ select = true }),
        ["<C-Space>"] = cmp.mapping.complete(),
      }),
      sources = cmp.config.sources({
        { name = "copilot", group_index = 2 },
        { name = 'nvim_lsp' },
        { name = 'luasnip' }, -- For luasnip users.
      }, {
          { name = 'buffer' },
        })
    })

    vim.diagnostic.config({
      -- update_in_insert = true,
      float = {
        focusable = false,
        style = "minimal",
        border = "rounded",
        source = "always",
        header = "",
        prefix = "",
      },
    })
  end
}
