return {
  -- This setup assumes nvim-lspconfig is already required and configured elsewhere,
  -- and that mason.nvim and mason-lspconfig.nvim are installing 'vue_ls' and
  -- 'ts_ls'.

  config = function()
    local lspconfig = require('lspconfig')

    -- Configure Volar Language Server using the 'volar' key in lspconfig.
    -- Although Mason installs it as 'vue_ls', lspconfig uses 'volar'
    -- as the server name for its configuration.
    lspconfig.volar.setup({
      filetypes = { 'typescript', 'javascript', 'javascriptreact', 'typescriptreact', 'vue' },
      init_options = {
        vue = {
          hybridMode = false, -- Disable hybrid mode (recommended for Vue 3)
        },
        -- Optional: Specify the path to the TypeScript library if needed.
        -- If Mason installs typescript-language-server correctly, this might not be needed.
        -- Example path using Mason's default install location:
        -- typescript = {
        --   tsdk = vim.fn.stdpath('data') .. '/mason/packages/typescript-language-server/node_modules/typescript/lib'
        -- }
      },
      -- Mason handles the server command and root_dir detection for 'vue_ls'.
    })

    -- IMPORTANT: If using volar in 'No Hybrid Mode' (hybridMode = false) and its
    -- filetypes include 'vue', ensure your separate ts_ls setup (e.g., in lsp.lua)
    -- does *not* include 'vue' in its filetypes.
    -- Example (in your lsp.lua) for ts_ls:
    -- lspconfig.ts_ls.setup({
    --   filetypes = { 'javascript', 'javascriptreact', 'typescript', 'typescriptreact' }, -- Exclude 'vue'
    --   -- ... other ts_ls settings
    -- })

  end,
}

