local TAG = require("overseer.constants").TAG

local function get_project_root(dir)
	return vim.fs.root(dir, function(name, _)
		return name:match("%.slnx?$") ~= nil or name:match("%.csproj$") ~= nil
	end)
end

local function get_content_file(root)
	if not root then
		return nil
	end

	local preferred = vim.fs.joinpath(root, "Content", "Content.mgcb")
	if vim.uv.fs_stat(preferred) then
		return preferred
	end

	return vim.fs.find(function(name, _)
		return name:lower():match("%.mgcb$") ~= nil
	end, { path = root, type = "file", limit = 1 })[1]
end

local function read_file(path)
	local fd = vim.uv.fs_open(path, "r", 438)
	if not fd then
		return nil
	end

	local stat = vim.uv.fs_fstat(fd)
	local content = stat and vim.uv.fs_read(fd, stat.size, 0) or nil
	vim.uv.fs_close(fd)
	return content
end

local function get_target_framework(root)
	local project_file = vim.fs.find(function(name, _)
		return name:match("%.csproj$") ~= nil
	end, { path = root, type = "file", limit = 1 })[1]
	if not project_file then
		return nil
	end

	local project = read_file(project_file)
	return project and project:match("<TargetFramework>(.-)</TargetFramework>") or nil
end

local function get_monogame_platform(content_file)
	local content = read_file(content_file)
	return content and content:match("/platform:([^%s]+)") or "DesktopGL"
end

local function get_content_output_name(content_file)
	return vim.fn.fnamemodify(content_file, ":t:r")
end

local function make_mgcb_build_args(root, content_file)
	local relative_content_file = vim.fs.relpath(root, content_file) or content_file
	local content_root = vim.fs.dirname(relative_content_file)
	local output_name = get_content_output_name(content_file)
	local platform = get_monogame_platform(content_file)
	local target_framework = get_target_framework(root)

	local output_dir = vim.fs.joinpath(content_root, "bin", platform, output_name)
	local intermediate_parts = { content_root, "obj", platform }
	if target_framework then
		table.insert(intermediate_parts, target_framework)
	end
	table.insert(intermediate_parts, output_name)

	return {
		"mgcb",
		"/@:" .. relative_content_file,
		"/platform:" .. platform,
		"/outputDir:" .. output_dir,
		"/intermediateDir:" .. vim.fs.joinpath(unpack(intermediate_parts)),
		"/workingDir:" .. content_root,
	}
end

local function make_dotnet_task(name, args, root, tags)
	return {
		name = name,
		tags = tags,
		builder = function()
			return {
				cmd = vim.list_extend({ "dotnet" }, args),
				cwd = root,
				components = {
					{ "on_output_quickfix", open = false },
					"on_result_diagnostics",
					"default",
				},
			}
		end,
	}
end

return {
	cache_key = function(opts)
		return get_project_root(opts.dir)
	end,
	generator = function(opts)
		if vim.fn.executable("dotnet") == 0 then
			return 'Command "dotnet" not found'
		end

		local root = get_project_root(opts.dir)
		if not root then
			return "No .sln/.slnx/.csproj file found"
		end

		local content_file = get_content_file(root)
		local tasks = {
			make_dotnet_task("dotnet restore", { "restore" }, root),
			make_dotnet_task("dotnet build", { "build" }, root, { TAG.BUILD }),
			make_dotnet_task("dotnet run", { "run" }, root, { TAG.RUN }),
			make_dotnet_task("dotnet test", { "test" }, root, { TAG.TEST }),
			make_dotnet_task("dotnet tool restore", { "tool", "restore" }, root),
		}

		if content_file then
			local relative_content_file = vim.fs.relpath(root, content_file) or content_file
			table.insert(
				tasks,
				make_dotnet_task("MonoGame: open MGCB Editor", { "mgcb-editor", relative_content_file }, root)
			)
			table.insert(
				tasks,
				make_dotnet_task("MonoGame: build content", make_mgcb_build_args(root, content_file), root, {
					TAG.BUILD,
				})
			)
		end

		return tasks
	end,
}
