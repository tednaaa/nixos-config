require("blink.cmp").setup({
	keymap = { preset = "enter" },
	appearance = { nerd_font_variant = "mono" },
	sources = {
		default = { "lsp", "path", "snippets", "buffer" },
	},
	snippets = { preset = "default" },
	signature = { enabled = true, window = { border = "padded" } },
	completion = {
		documentation = {
			auto_show = true,
			auto_show_delay_ms = 250,
			window = { border = "padded" },
		},
		ghost_text = { enabled = true },
		list = { selection = { preselect = true, auto_insert = false } },
		menu = { border = "padded" },
	},
	fuzzy = { implementation = "prefer_rust_with_warning" },
})
