return {
	"neovim/nvim-lspconfig",
	dependencies = {
		{ "antosha417/nvim-lsp-file-operations", config = true },
		{ "williamboman/mason.nvim" },
		{ "williamboman/mason-lspconfig.nvim" },
		{ "WhoIsSethDaniel/mason-tool-installer.nvim" },
	},
	config = function()
		require("mason").setup()
		require("mason-tool-installer").setup({
			ensure_installed = {
				"editorconfig-checker",

				"dockerfile-language-server",
				"docker-compose-language-service",
				"hadolint",

				"lua-language-server",
				"stylua",

				"taplo",

				"gopls",
				"gofumpt",
				"golines",
				"gomodifytags",
				"gotests",
				"golangci-lint",

				"vtsls",
				"volar",
				"astro",
				"html",
				"cssls",
				"emmet_ls",
				"tailwindcss",
				"prisma-language-server",

				"js-debug-adapter",
				"eslint-lsp",
				"eslint_d",
				"prettierd",
			},

			auto_update = true,
			run_on_start = true,
		})

		vim.api.nvim_create_autocmd("LspAttach", {
			group = vim.api.nvim_create_augroup("UserLspConfig", { clear = true }),
			callback = function(event)
				local keymap = function(mode, lhs, rhs)
					vim.keymap.set(mode, lhs, rhs, { buffer = event.buf, noremap = true, silent = true })
				end

				local fzf = require("fzf-lua")

				keymap("n", "gD", fzf.lsp_declarations)
				keymap("n", "gr", fzf.lsp_references)
				keymap("n", "gd", fzf.lsp_definitions)
				keymap("n", "gi", fzf.lsp_implementations)
				keymap("n", "gt", fzf.lsp_typedefs)

				-- keymap({ "n", "v" }, "g.", fzf.lsp_code_actions)
				keymap({ "n", "v" }, "g.", require("fastaction").code_action)

				keymap("n", "]g", vim.diagnostic.goto_next)
				keymap("n", "[g", vim.diagnostic.goto_prev)

				keymap("n", "<leader>d", vim.diagnostic.open_float)
				keymap("n", "<leader>r", vim.lsp.buf.rename)
				keymap("n", "K", vim.lsp.buf.hover)

				keymap("n", "<leader>hh", function()
					local reversed_value = not vim.lsp.inlay_hint.is_enabled({})

					vim.lsp.inlay_hint.enable(reversed_value)
				end)

				keymap("n", "<leader>rs", ":LspRestart<CR>")
			end,
		})

		local signs = { Error = " ", Warn = " ", Hint = "󰠠 ", Info = " " }
		for type, icon in pairs(signs) do
			local hl = "DiagnosticSign" .. type
			vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
		end

		local servers = {
			lua_ls = {
				settings = {
					Lua = {
						diagnostics = { globals = { "vim" } },
						completion = { callSnippet = "Replace" },
					},
				},
			},
			rust_analyzer = { settings = { ["rust-analyzer"] = { checkOnSave = { command = "clippy" } } } },
			docker_compose_language_service = { filetypes = { "yml.docker-compose" } },

			-- Vue take over mode
			-- vtsls = {
			-- 	filetypes = { "typescript", "javascript", "vue" },
			-- 	settings = {
			-- 		vtsls = { tsserver = { globalPlugins = {} } },
			-- 	},
			-- 	before_init = function(params, config)
			-- 		local result = vim
			-- 			.system({ "npm", "query", "#vue" }, { cwd = params.workspaceFolders[1].name, text = true })
			-- 			:wait()
			-- 		if result.stdout ~= "[]" then
			-- 			local vuePluginConfig = {
			-- 				name = "@vue/typescript-plugin",
			-- 				location = require("mason-registry").get_package("vue-language-server"):get_install_path()
			-- 					.. "/node_modules/@vue/language-server",
			-- 				languages = { "vue" },
			-- 				configNamespace = "typescript",
			-- 				enableForWorkspaceTypeScriptVersions = true,
			-- 			}
			-- 			table.insert(config.settings.vtsls.tsserver.globalPlugins, vuePluginConfig)
			-- 		end
			-- 	end,
			-- },
		}
		local capabilities = require("blink.cmp").get_lsp_capabilities()

		require("mason-lspconfig").setup_handlers({
			function(server_name)
				local server = servers[server_name] or {}
				server.capabilities = vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})
				require("lspconfig")[server_name].setup(server)
			end,
		})

		-- TODO: I don't understand why, but this is needed to make the lsp work
		-- Seems mason-lspconfig is not supporting gdscript lsp
		require("lspconfig").gdscript.setup(capabilities)
	end,
}
