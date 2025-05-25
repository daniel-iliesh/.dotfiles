return {
  "windwp/nvim-autopairs",
  event = "InsertEnter", -- Load when you enter insert mode, very efficient
  -- Use opts = {} for new versions of nvim-autopairs that support it directly
  -- For older versions or more control, you might use the config function.
  -- Most users can start with just enabling it or using a simple opts table.
  opts = {
    check_ts = true, -- Enable Treesitter integration for smarter pairing
    ts_config = {
      lua = {'string'}, -- Don't add pairs inside lua strings
      -- You can add more language-specific Treesitter configurations here
      -- Example:
      -- javascript = {'template_string'},
      -- java = false, -- Disable for java if it causes issues or you have other handling
    },
    -- Optional: Disable for specific filetypes if needed
    -- disabled_filetypes = { "TelescopePrompt", "vim" },

    -- Optional: Enable fast wrap (e.g., select text and press '(' to wrap it)
    -- fast_wrap = {}, -- Empty table enables default fast wrap behavior
  },
  -- If you need to integrate with nvim-cmp (highly recommended if you use nvim-cmp)
  -- you might need to add this to nvim-autopairs's config or nvim-cmp's config.
  -- The preferred way is often in nvim-cmp's setup.
  -- However, if you want to keep it with autopairs:
  config = function(_, opts) -- The second argument `opts` comes from the `opts` table above
    require("nvim-autopairs").setup(opts)

    -- CMP integration:
    -- This is important if you use nvim-cmp to ensure that when a completion
    -- (especially a snippet) is confirmed, nvim-autopairs handles any
    -- newly inserted pairs correctly.
    local cmp_autopairs = require("nvim-autopairs.completion.cmp")
    local cmp = pcall(require, "cmp") -- Safely require cmp
    if cmp then
      cmp.event:on(
        "confirm_done",
        cmp_autopairs.on_confirm_done()
      )
    end
  end,
}
