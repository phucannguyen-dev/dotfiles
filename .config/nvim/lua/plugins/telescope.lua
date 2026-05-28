return {
	{
		"nvim-telescope/telescope.nvim",
		tag = "*",
		dependencies = {
			"nvim-lua/plenary.nvim",
			{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
		},
		config = function()
			local wk = require("which-key")
			local builtin = require("telescope.builtin")

			wk.add({
				{ "<C-p>", builtin.find_files, desc = "Find file", mode = "n" },
				{ "<leader>tg", builtin.live_grep, desc = "Live grep", mode = "n" },
			})
			--vim.keymap.set("n", "<leader>fg", builtin.live_grep, {})
		end,
	},

	{
		"nvim-telescope/telescope-ui-select.nvim",
		-- This is your opts table
		config = function()
			require("telescope").setup({
				extensions = {
					["ui-select"] = {
						require("telescope.themes").get_dropdown({}),
					},
				},
			})
			require("telescope").load_extension("ui-select")
		end,
	},
}
