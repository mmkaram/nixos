local model = "qwen/qwen3-coder:free"
require("codecompanion").setup({
	strategies = {
		chat = {
			adapter = "openrouter",
		},
		inline = {
			adapter = "openrouter",
		},
	},
	adapters = {
		openrouter = function()
			return require("codecompanion.adapters").extend("openai_compatible", {
				env = {
					url = "https://openrouter.ai/api/v1",
					api_key = "cmd:cat /run/agenix/openrouter",
					chat_url = "/chat/completions",
				},
				schema = {
					model = {
						default = model,
					},
				},
			})
		end,
	},
})
