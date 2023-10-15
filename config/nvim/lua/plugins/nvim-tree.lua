local function nvim_tree_on_attach(bufnr)
  local api = require "nvim-tree.api"

  -- Default mappings
  api.config.mappings.default_on_attach(bufnr);

  -- Custom mappings (See :help nvim-tree-api)
  -- vim.keymap.set('n', api.tree.*)
end

return {
  'nvim-tree/nvim-tree.lua',
  config = function()
    require("nvim-tree").setup({
      on_attach = nvim_tree_on_attach
    })
  end
}
