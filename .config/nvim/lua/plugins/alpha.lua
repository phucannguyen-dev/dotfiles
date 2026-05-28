return {
	"goolord/alpha-nvim",
	-- dependencies = { 'nvim-mini/mini.icons' },
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		require("alpha").setup(require("alpha.themes.dashboard").config)
	end,
}
