if vim.fn.has("win32") == 1 and not vim.g.vscode then
	return {
		"seblj/roslyn.nvim",
		ft = "cs",
		opts = {
			config = {
				settings = {
					["csharp|inlay_hints"] = {
						csharp_enable_inlay_hints_for_implicit_object_creation = true,
						csharp_enable_inlay_hints_for_implicit_variable_types = true,
						csharp_enable_inlay_hints_for_lambda_parameter_types = true,
						csharp_enable_inlay_hints_for_types = true,
						dotnet_enable_inlay_hints_for_literal_parameters = true,
						dotnet_enable_inlay_hints_for_indexer_parameters = true,
					},
				},
			},
		},
	}
end

return {}
