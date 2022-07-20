M = {}

DEFAULT_MAP_OPTS = {noremap = true, silent = true}
DEFAULT_CMD_OPTS = {force = true}

M.setup_packer = function()
    local install_path = vim.fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
    local packer_url = 'https://github.com/wbthomason/packer.nvim'

    if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
        install_cmd = table.concat({'!git clone', packer_url, install_path}, ' ')
        vim.fn.execute(install_cmd)
    end

    -- Add packer to managed plugins
    vim.cmd("packadd packer.nvim")
end

M.add_plugins = function(plugins, configs, packer)
    packer.init()
    packer.reset()
    packer.use({'wbthomason/packer.nvim'})
    for _name, repos in pairs(plugins) do
        for _, repo in pairs(repos) do
            local repo_config = {repo}
            if configs[repo] ~= nil then
                repo_config = vim.tbl_extend("force", repo_config, configs[repo])
            end
            packer.use(repo_config)
        end
    end
    packer.install()
end

-- -----------------------------
SETTERS = {}
SETTERS.options = function(_, options)
    for k, v in pairs(options) do vim.opt[k] = v end
end

SETTERS.functions = function(_, functions)
    for name, func in pairs(functions) do _G.name = func end
end

SETTERS.autocommands = function(name, autocommands)
    local id = vim.api.nvim_create_augroup(name, {clear = true})
    for _, autocmd in pairs(autocommands) do
        vim.api.nvim_create_autocmd(
            autocmd.events,
            {
                group = id,
                pattern = autocmd.pattern,
                callback = autocmd.callback,
            }
        )
    end
end

SETTERS.commands = function(_, commands)
    for name, command in pairs(commands) do
        if (type(command) == 'table') then
            local opts = vim.tbl_extend('force', DEFAULT_CMD_OPTS, command[2])
            vim.api.nvim_create_user_command(
                name,
                command[1],
                opts
            )
        else
            vim.api.nvim_create_user_command(
                name,
                command,
                DEFAULT_CMD_OPTS
            )
        end
    end
end

SETTERS.mappings = function(_, mappings)
    for mode, mode_mappings in pairs(mappings) do
        for keys, mapping in pairs(mode_mappings) do
            if (type(mapping) == "table") then
                local opts = vim.tbl_extend('force', DEFAULT_MAP_OPTS, mapping.opts)
                vim.keymap.set(mode, keys, mapping.map, opts)
            else
                vim.keymap.set(mode, keys, mapping, DEFAULT_MAP_OPTS)
            end
        end
    end
end

M.load = function(mode, groups)
    -- setter should be a function
    local setter = SETTERS[mode]
    if setter == nil then return end

    -- `groups` should be a table of tables
    -- groups = {group_name: {setter_args}}
    if type(groups) ~= "table" then return end
    for _k, v in pairs(groups) do
        if type(v) ~= "table" then return end
    end

    -- Apply setter to each group
    for name, group in pairs(groups) do
        setter(name, group)
    end
end

return M

