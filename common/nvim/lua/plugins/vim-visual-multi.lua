return {
  {
    "mg979/vim-visual-multi",
    branch = "master", -- Specify the branch
    -- Optional: Add keys or commands for lazy-loading if desired,
    -- though for vim-visual-multi, it's often loaded on its default mappings
    -- or you might want it available immediately.
    -- keys = {
    --   -- Example: if you want to ensure it loads when you press Ctrl-N in normal mode
    --   -- (assuming Ctrl-N is a primary way you start it)
    --   { "<C-n>", mode = "n", desc = "Visual Multi: Start/Next" },
    -- },
    -- config = function()
    --   -- Optional: vim-visual-multi specific global configurations can go here
    --   -- For example, to customize mappings (though it has its own system):
    --   -- vim.g.VM_leader = '<leader>' -- If you want to change its leader key
    --   -- vim.g.VM_maps = {} -- To clear default maps and define your own
    --   -- vim.g.VM_maps['Find Under'] = '<C-n>'
    --   -- vim.g.VM_maps['Find Subword Under'] = '<C-n>'
    --   -- See vim-visual-multi documentation for its g:VM_maps variable
    -- end,
  },
}
