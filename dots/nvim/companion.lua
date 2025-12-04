local model = "qwen/qwen3-coder"
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
		http = {
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
							choices = {
								"qwen/qwen3-coder",
								"openai/gpt-5-mini",
								"google/gemini-2.5-flash",
								"google/gemini-3-pro-preview",
								"openai/gpt-4.1",
							},
						},
					},
				})
			end,
		},
	},
})
