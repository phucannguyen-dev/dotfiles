return {
	{
		"mason-org/mason.nvim",
		config = function()
			require("mason").setup()
		end,
	},

	{
		"mason-org/mason-lspconfig.nvim",
		config = function()
			require("mason-lspconfig").setup({
				ensure_installed = { "lua_ls", "clangd", "pyright", "ts_ls" },
			})
		end,
	},

	{
		"neovim/nvim-lspconfig",
		config = function()
			local wk = require("which-key")
			vim.lsp.config("lua_ls", {
				settings = {
					Lua = {
						diagnostics = {
							-- Giải quyết cảnh báo: Thêm 'vim' vào danh sách biến toàn cục
							globals = { "vim" },
						},
						workspace = {
							-- Giúp server nhận diện các thư viện của Neovim (runtime)
							library = vim.api.nvim_get_runtime_file("", true),
							checkThirdParty = false,
						},
						telemetry = {
							enable = false,
						},
					},
				},
			})
			vim.lsp.enable("pyright")
			vim.lsp.enable("clangd")
			vim.lsp.enable("ts_ls")

			vim.api.nvim_create_autocmd("LspAttach", {
				callback = function(ev)
					local opts = { buffer = ev.buf }
					--vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
					--vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
					--vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
					--vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts)
					--vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)

					wk.add({
						-- Non-leader mappings (Direct triggers)
						{ "gd", vim.lsp.buf.definition, desc = "Go to Definition" },
						{ "gr", vim.lsp.buf.references, desc = "Show References" },
						{ "K", vim.lsp.buf.hover, desc = "Hover Documentation" },

						-- Leader mappings grouped by functionality
						{ "<leader>r", group = "Rename" },
						{ "<leader>rn", vim.lsp.buf.rename, desc = "Rename Symbol" },

						{ "<leader>c", group = "Code" },
						{
							"<leader>ca",
							vim.lsp.buf.code_action,
							desc = "Code Action",
							mode = { "n", "v" }, -- Works in both Normal and Visual mode
						},

						{ "[d", vim.diagnostic.goto_prev, desc = "Previous Diagnostic" },
						{ "]d", vim.diagnostic.goto_next, desc = "Next Diagnostic" },
						{ "<leader>de", vim.diagnostic.open_float, desc = "Show Line Diagnostics" },
					})
				end,
			})

			vim.lsp.config("gopls", {
				root_markers = { "go.mod", ".git" },
			})
			vim.lsp.enable("gopls")
		end,
	},
}
