local source_generated_pattern = "^roslyn%-source%-generated://"

local function request_source_generated_content(client, uri, bufnr, handler)
	client:request("workspace/textDocumentContent", {
		uri = uri,
	}, handler, bufnr)
end

local function set_source_generated_content(bufnr, result)
	local content = result and result.text or ""
	if content == vim.NIL then
		content = ""
	end

	local lines = vim.split(content:gsub("\r\n", "\n"), "\n", { plain = true })
	vim.bo[bufnr].modifiable = true
	vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, lines)
	vim.b[bufnr].resultId = result and result.resultId or nil
	vim.bo[bufnr].modifiable = false
	vim.bo[bufnr].modified = false
end

local function load_source_generated_buffer(args)
	vim.bo[args.buf].modifiable = true
	vim.bo[args.buf].swapfile = false
	vim.bo[args.buf].filetype = "cs"

	local client = vim.lsp.get_clients({ name = "roslyn", bufnr = args.buf })[1]
		or vim.lsp.get_clients({ name = "roslyn" })[1]

	if client then
		vim.lsp.buf_attach_client(args.buf, client.id)
	else
		vim.wait(5000, function()
			client = vim.lsp.get_clients({ name = "roslyn", bufnr = args.buf })[1]
				or vim.lsp.get_clients({ name = "roslyn" })[1]
			return client ~= nil
		end)
	end

	if not client then
		vim.notify("roslyn.nvim: source-generated buffer opened without an active Roslyn client", vim.log.levels.ERROR)
		return
	end

	local loaded = false
	request_source_generated_content(client, args.match, args.buf, function(err, result)
		if err then
			vim.notify(err.message or vim.inspect(err), vim.log.levels.ERROR, { title = "roslyn.nvim" })
			loaded = true
			return
		end

		set_source_generated_content(args.buf, result)
		loaded = true
	end)

	vim.wait(5000, function()
		return loaded
	end)
end

local function refresh_roslyn_diagnostics(client)
	for bufnr, _ in pairs(client.attached_buffers) do
		if vim.api.nvim_buf_is_loaded(bufnr) then
			client:request(
				vim.lsp.protocol.Methods.textDocument_diagnostic,
				{ textDocument = vim.lsp.util.make_text_document_params(bufnr) },
				nil,
				bufnr
			)
		end
	end
end

local function configure_source_generated_handlers()
	local handlers = require("roslyn.lsp.handlers")

	handlers["workspace/textDocumentContent/refresh"] = function(_, params, ctx)
		local client = assert(vim.lsp.get_client_by_id(ctx.client_id))
		for _, bufnr in ipairs(vim.api.nvim_list_bufs()) do
			local uri = vim.api.nvim_buf_get_name(bufnr)
			local should_refresh = not params or params == vim.NIL or params.uri == uri
			if should_refresh and vim.api.nvim_buf_is_loaded(bufnr) and uri:match(source_generated_pattern) then
				request_source_generated_content(client, uri, bufnr, function(err, result)
					if err then
						vim.notify(err.message or vim.inspect(err), vim.log.levels.ERROR, { title = "roslyn.nvim" })
						return
					end

					set_source_generated_content(bufnr, result)
				end)
			end
		end
	end

	handlers["workspace/refreshSourceGeneratedDocument"] = handlers["workspace/textDocumentContent/refresh"]
	return handlers
end

local function replace_source_generated_autocmd()
	local ok, roslyn_group = pcall(vim.api.nvim_create_augroup, "roslyn.nvim", { clear = false })
	if ok then
		for _, autocmd in ipairs(vim.api.nvim_get_autocmds({ group = roslyn_group, event = "BufReadCmd" })) do
			if autocmd.pattern == "roslyn-source-generated://*" then
				vim.api.nvim_del_autocmd(autocmd.id)
			end
		end
	end

	vim.api.nvim_create_autocmd("BufReadCmd", {
		group = vim.api.nvim_create_augroup("UserRoslynSourceGenerated", { clear = true }),
		pattern = "roslyn-source-generated://*",
		callback = load_source_generated_buffer,
	})
end

local function choose_solution(targets)
	return vim.iter(targets):find(function(target)
		return vim.endswith(target, "/MonoMario.sln") or vim.endswith(target, "\\MonoMario.sln")
	end) or targets[1]
end

return {
	"seblyng/roslyn.nvim",
	lazy = false,
	opts = {
		filewatching = "off",
		choose_target = choose_solution,
		extensions = {
			razor = {
				enabled = false,
			},
		},
	},
	config = function(_, opts)
		require("roslyn").setup(opts)

		vim.lsp.config("roslyn", {
			capabilities = {
				textDocument = {
					diagnostic = {
						dynamicRegistration = true,
					},
				},
				workspace = {
					didChangeWatchedFiles = {
						dynamicRegistration = true,
						relativePatternSupport = true,
					},
					textDocumentContent = {
						dynamicRegistration = true,
					},
				},
			},
			handlers = configure_source_generated_handlers(),
			on_attach = function(client, bufnr)
				client.server_capabilities.semanticTokensProvider = nil

				vim.api.nvim_create_autocmd("BufWritePost", {
					group = vim.api.nvim_create_augroup("UserRoslynDiagnostics", { clear = false }),
					buffer = bufnr,
					callback = function()
						refresh_roslyn_diagnostics(client)
					end,
					desc = "roslyn.nvim: refresh diagnostics",
				})
			end,
			settings = {
				["csharp|background_analysis"] = {
					dotnet_analyzer_diagnostics_scope = "openFiles",
					dotnet_compiler_diagnostics_scope = "openFiles",
				},
				["csharp|inlay_hints"] = {
					csharp_enable_inlay_hints_for_implicit_object_creation = true,
					csharp_enable_inlay_hints_for_implicit_variable_types = true,
					csharp_enable_inlay_hints_for_lambda_parameter_types = true,
					csharp_enable_inlay_hints_for_types = true,
					dotnet_enable_inlay_hints_for_indexer_parameters = true,
					dotnet_enable_inlay_hints_for_literal_parameters = true,
					dotnet_enable_inlay_hints_for_object_creation_parameters = true,
					dotnet_enable_inlay_hints_for_other_parameters = true,
					dotnet_enable_inlay_hints_for_parameters = true,
					dotnet_suppress_inlay_hints_for_parameters_that_differ_only_by_suffix = true,
					dotnet_suppress_inlay_hints_for_parameters_that_match_argument_name = true,
					dotnet_suppress_inlay_hints_for_parameters_that_match_method_intent = true,
				},
				["csharp|symbol_search"] = {
					dotnet_search_reference_assemblies = true,
				},
				["csharp|completion"] = {
					dotnet_show_name_completion_suggestions = true,
					dotnet_show_completion_items_from_unimported_namespaces = false,
					dotnet_provide_regex_completions = false,
				},
				["csharp|code_lens"] = {
					dotnet_enable_references_code_lens = false,
				},
			},
		})

		replace_source_generated_autocmd()
	end,
}
