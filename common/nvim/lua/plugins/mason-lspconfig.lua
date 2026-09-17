return {
  'williamboman/mason-lspconfig.nvim',
  dependencies = { 'williamboman/mason.nvim' }, -- Ensure mason is a dependency
  config = function()
    require('mason-lspconfig').setup({
      ensure_installed = {
        'lua_ls',
        'pylsp',
        'vue_ls',
        'ts_ls',
      },
    })
  end,
}
