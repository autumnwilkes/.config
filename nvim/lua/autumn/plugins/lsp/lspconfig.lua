return {

	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufReadPost", "BufNewFile" },
	dependencies = {
		"hrsh7th/cmp-nvim-lsp",
		{ "antosha417/nvim-lsp-file-operations", config = true },
	},

	config = function()
		-- local lspconfig = require("lspconfig") -- use vim.lsp.config?
		local lspconfig = vim.lsp
		local cmp_nvim_lsp = require("cmp_nvim_lsp")

		local keymap = vim.keymap

		local opts = { noremap = true, silent = true }
		local on_attach = function(client, bufnr)
			opts.buffer = bufnr

			opts.desc = "Show LSP references"
			keymap.set("n", "gR", vim.lsp.buf.references, opts) -- show definition, references

			opts.desc = "Go to declaration"
			keymap.set("n", "gD", vim.lsp.buf.declaration, opts) -- go to declaration

			opts.desc = "Show LSP definitions"
			keymap.set("n", "gd", vim.lsp.buf.definition, opts) -- show lsp definitions

			opts.desc = "Show LSP implementations"
			keymap.set("n", "gi", vim.lsp.buf.implementation, opts) -- show lsp implementations

			opts.desc = "Show LSP type definitions"
			keymap.set("n", "gt", vim.lsp.buf.type_definition, opts) -- show lsp type definitions

			opts.desc = "See available code actions"
			keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts) -- see available code actions, in visual mode will apply to selection

			opts.desc = "Smart rename"
			keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts) -- smart rename

			opts.desc = "Show line diagnostics"
			keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts) -- show diagnostics for line

			opts.desc = "Go to previous diagnostic"
			keymap.set("n", "[d", vim.diagnostic.goto_prev, opts) -- jump to previous diagnostic in buffer

			opts.desc = "Go to next diagnostic"
			keymap.set("n", "]d", vim.diagnostic.goto_next, opts) -- jump to next diagnostic in buffer

			opts.desc = "Show documentation for what is under cursor"
			keymap.set("n", "K", vim.lsp.buf.hover, opts) -- show documentation for what is under cursor

			opts.desc = "Restart LSP"
			keymap.set("n", "<leader>rs", ":LspRestart<CR>", opts) -- mapping to restart lsp if necessary
		end

		local capabilities = vim.lsp.protocol.make_client_capabilities()

		for _, diag in ipairs({ "Error", "Warn", "Info", "Hint" }) do
			vim.fn.sign_define("DiagnosticSign" .. diag, {
				text = "",
				texthl = "DiagnosticSign" .. diag,
				linehl = "",
				numhl = "DiagnosticSign" .. diag,
			})
		end
		lspconfig.config("rust_analyzer", {
			capabilities = capabilities,
			on_attach = on_attach,
		})

		lspconfig.enable("rust_analyzer")

		lspconfig.config("clangd", {
			capabilities = capabilities,
			on_attach = on_attach,
		})

		lspconfig.enable("clangd")

		lspconfig.config("gopls", {
			capabilities = capabilities,
			on_attach = on_attach,
		})

		lspconfig.enable("gopls")

		lspconfig.config("html", {
			capabilities = capabilities,
			on_attach = on_attach,
		})

		lspconfig.enable("html")

		lspconfig.config("ts_ls", {
			capabilities = capabilities,
			on_attach = on_attach,
		})

		lspconfig.enable("ts_ls")

		lspconfig.config("cssls", {
			capabilities = capabilities,
			on_attach = on_attach,
		})

		lspconfig.enable("cssls")

		lspconfig.config("tailwindcss", {
			capabilities = capabilities,
			on_attach = on_attach,
		})

		lspconfig.enable("tailwindcss")

		lspconfig.config("svelte", {
			capabilities = capabilities,
			on_attach = function(client, bufnr)
				on_attach(client, bufnr)

				vim.api.nvim_create_autocmd("BufWritePost", {
					pattern = { "*.js", "*.ts" },
					callback = function(ctx)
						if client.name == "svelte" then
							client.notify("$/onDidChangeTsOrJsFile", { uri = ctx.file })
						end
					end,
				})
			end,
		})

		lspconfig.enable("svelte")

		lspconfig.config("emmet_language_server", {
			capabilities = capabilities,
			on_attach = on_attach,
			filetypes = { "html", "typescriptreact", "javascriptreact", "css", "sass", "scss", "less", "svelte" },
		})

		lspconfig.enable("emmet_language_server")

		lspconfig.config("basedpyright", {
			capabilities = capabilities,
			on_attach = on_attach,
		})

		lspconfig.enable("basedpyright")

		lspconfig.config("lua_ls", {
			capabilities = capabilities,
			on_attach = on_attach,
			settings = {
				Lua = {
					-- make the language server recognize "vim" global
					diagnostics = {
						globals = { "vim" },
					},
					workspace = {
						-- make language server aware of runtime files
						library = {
							[vim.fn.expand("$VIMRUNTIME/lua")] = true,
							[vim.fn.stdpath("config") .. "/lua"] = true,
						},
					},
				},
			},
		})

		lspconfig.enable("lua_ls")
	end,
}
