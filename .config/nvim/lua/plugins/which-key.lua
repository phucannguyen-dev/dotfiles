return {
	"folke/which-key.nvim",
	event = "VeryLazy",
	init = function()
		vim.o.timeout = true
		vim.o.timeoutlen = 300 -- Thời gian chờ (ms) trước khi popup hiện lên
	end,
	keys = {
		{
			"<leader>?",
			function()
				require("which-key").show({ global = false })
			end,
			desc = "Buffer Local Keymaps (which-key)",
		},
	},
	config = function()
		local wk = require("which-key")
		wk.add({
			{ "<leader>t", group = "Find (Telescope)" },
			{ "<leader>g", group = "Git" },
			{ "<leader>x", group = "Diagnostics (Trouble)" },
			{ "<leader>c", group = "Code (LSP/DAP)" },
		})
	end,
}
