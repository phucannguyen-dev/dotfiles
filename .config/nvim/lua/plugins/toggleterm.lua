return {
  "akinsho/toggleterm.nvim",
  name = "toggleterm",
  version = "*",
  config = function()
    require('toggleterm').setup({
      size = function(term)
        if term.direction == 'horizontal' then
          return 15
        elseif term.direction == 'vertical' then
          return vim.o.columns * 0.4
        end
      end,
      open_mapping = [[<C-\>]], -- Ctrl+\ để toggle
      direction = 'float',      -- horizontal | vertical | float | tab
      close_on_exit = true,
      shell = vim.o.shell,
      float_opts = {
        border = 'curved',
      },
    })
  end
}
