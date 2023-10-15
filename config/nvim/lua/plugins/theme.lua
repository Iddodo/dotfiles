return {
  -- Transparent neovim
  'xiyaowong/nvim-transparent',

  -- Use the onedark theme
  {
    'navarasu/onedark.nvim',
    config = function()
      require('onedark').setup {
        style = 'deep',
        transparent = true,
        term_colors = true
      }
      require('onedark').load()
    end
  }
}
