-- mason.lua
return {
	{
		"williamboman/mason.nvim",
		build = ":MasonUpdate",
		config = function()
			require("mason").setup()
		end,
	},
	{
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		dependencies = { "williamboman/mason.nvim" },
		config = function()
			require("mason-tool-installer").setup({
				ensure_installed = {
					"stylua",
				},
				auto_update = false,
				run_on_start = true,
			})
		end,
	},
	{
		"williamboman/mason-lspconfig.nvim",
		dependencies = {
			"williamboman/mason.nvim",
			"neovim/nvim-lspconfig",
		},
		config = function()
			require("mason-lspconfig").setup({
				ensure_installed = {
					"rust_analyzer",
					"ltex",
					-- "ruff",
				},
				automatic_installation = true,
			})

			local lspconfig = require("lspconfig")

			-- Configure Mason-supported LSPs
			for _, server in ipairs({ "rust_analyzer", "ltex" }) do
				lspconfig[server].setup({})
			end

			-- Configure Ruff LSP manually
			lspconfig.ruff.setup({
				cmd = { "ruff", "server" },
				filetypes = { "python" },
				root_dir = lspconfig.util.root_pattern("pyproject.toml", "ruff.toml", ".git"),
				init_options = {
					settings = {
						args = {},
						lint = {
							enable = true,
							run = "onType",
						},
					},
				},
			})
		end,
	},
}
