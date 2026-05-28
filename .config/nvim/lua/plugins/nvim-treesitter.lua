return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	lazy = false,
	config = function()
		local config = require("nvim-treesitter")
		config.setup({
			auto_install = true,
			ensure_installed = { "lua", "javascript", "cpp", "python", "html", "css" },
			highlight = { enable = true },
			indent = { enable = true },
		})
	end,
}
