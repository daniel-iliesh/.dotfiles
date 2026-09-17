return {
  "nvim-treesitter/nvim-treesitter-textobjects",
  event = "VeryLazy",  -- or another standard event like "BufReadPost"
  enabled = true,
  config = function()
    local textobject_opts = {
      select = {
        enable = true,
        keymaps = {
          ["af"] = "@function.outer",
          ["if"] = "@function.inner",
          -- add other mappings here
        },
      },
      -- add additional textobjects configuration as needed
    }
    require("nvim-treesitter.configs").setup({ textobjects = textobject_opts })

    -- Optionally, patch the move module as in your original code
    local move = require("nvim-treesitter.textobjects.move")
    local configs = require("nvim-treesitter.configs")
    for name, fn in pairs(move) do
      if name:find("goto") == 1 then
        move[name] = function(q, ...)
          if vim.wo.diff then
            local config = configs.get_module("textobjects.move")[name] or {}
            for key, query in pairs(config) do
              if q == query and key:find("[%]%[][cC]") then
                vim.cmd("normal! " .. key)
                return
              end
            end
          end
          return fn(q, ...)
        end
      end
    end
  end,
}

