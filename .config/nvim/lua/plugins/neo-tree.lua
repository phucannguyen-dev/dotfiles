return {
	"nvim-neo-tree/neo-tree.nvim",
	name = "neo-tree",
	branch = "v3.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"MunifTanjim/nui.nvim",
		"nvim-tree/nvim-web-devicons", -- optional, but recommended
	},
	lazy = false, -- neo-tree will lazily load itself
	config = function()
		-- Phím tắt để đóng/mở sidebar_header
		--local wk = require("which-key")
		--wk.add({
		--	{ "<leader>e", ":Neotree toggle<CR>", desc = "Toggle sidebar", mode = "n" },
		--})
		vim.keymap.set("n", "<leader>e", ":Neotree toggle<CR>", { desc = "Toggle Sidebar" })
	end,
}
