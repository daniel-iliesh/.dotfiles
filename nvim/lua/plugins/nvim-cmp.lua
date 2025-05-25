return {
  "hrsh7th/nvim-cmp",
  event = "InsertEnter",
  dependencies = {
    "hrsh7th/cmp-nvim-lsp", -- Essential for LSP completions
    "hrsh7th/cmp-buffer",   -- For words from current buffer
    "hrsh7th/cmp-path",     -- For file system paths
    -- Optional: Snippet Engine (highly recommended for a better experience)
    -- "L3MON4D3/LuaSnip",
    -- "saadparwaiz1/cmp_luasnip",
    -- Optional: Icons (if you want them, requires a Nerd Font)
    -- "onsails/lspkind.nvim",
  },
  config = function()
    local cmp = require("cmp")
    -- local luasnip = require("luasnip") -- Uncomment if using LuaSnip
    -- local lspkind = require("lspkind") -- Uncomment if using lspkind

    cmp.setup({
      -- Uncomment if using LuaSnip
      -- snippet = {
      --   expand = function(args)
      --     luasnip.lsp_expand(args.body)
      --   end,
      -- },

      -- Basic mappings: Enter to confirm, Tab/S-Tab to select, Ctrl-Space to complete
      mapping = cmp.mapping.preset.insert({
        ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Confirm with Enter, select = true will select the top item if none is actively selected
        ['<Tab>'] = cmp.mapping.select_next_item(),       -- Select next with Tab
        ['<S-Tab>'] = cmp.mapping.select_prev_item(),     -- Select previous with Shift-Tab
        ['<C-Space>'] = cmp.mapping.complete(),           -- Manually trigger completion
        ['<C-e>'] = cmp.mapping.abort(),                -- Close completion menu
        -- You can add <C-n> and <C-p> if you prefer them over Tab/S-Tab for selection
        -- ['<C-n>'] = cmp.mapping.select_next_item(),
        -- ['<C-p>'] = cmp.mapping.select_prev_item(),
      }),

      -- Essential: Define your completion sources
      sources = cmp.config.sources({
        { name = "nvim_lsp" },
        { name = "buffer", keyword_length = 3 },
        { name = "path" },
        -- { name = "luasnip" }, -- Uncomment if using LuaSnip
      }),

      -- Optional: Add basic bordered windows for completion and docs
      window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
      },

      -- Optional: Formatting with lspkind for icons
      -- formatting = {
      --   format = lspkind.cmp_format({
      --     mode = "symbol_text",
      --     maxwidth = 50,
      --   })
      -- },

      -- Default preselect behavior (nvim-cmp's default is usually PreselectMode.None)
      -- If you want the first item preselected:
      preselect = cmp.PreselectMode.Item,
    })
  end,
}
