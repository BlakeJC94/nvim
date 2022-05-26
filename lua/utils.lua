M = {}

DISABLED_BUILT_INS = {
    'netrw',
    'netrwPlugin',
    'gzip',
    'man',
    'shada_plugin',
    'tarPlugin',
    'tar',
    'zipPlugin',
    'zip',
    'netrwPlugin',
    'tutor_mode_plugin',
    'remote_plugins',
    'spellfile_plugin',
    '2html_plugin',
}

DEFAULT_MAP_OPTS = {noremap = true, silent = true}

M.arrow_maps = {
    [''] = {
        -- Disable arrow keys
        ['<Left>']  = '',
        ['<Down>']  = '',
        ['<Up>']    = '',
        ['<Right>'] = '',
        -- ['<C-Left>']  = '',
        -- ['<C-Down>']  = '',
        -- ['<C-Up>']    = '',
        -- ['<C-Right>'] = '',
        -- ['<S-Left>']  = '',
        -- ['<S-Down>']  = '',
        -- ['<S-Up>']    = '',
        -- ['<S-Right>'] = '',
        -- -- [Leader + Arrow] to navigate windows
        -- ['<C-Left>']  = ':wincmd h<CR>',
        -- ['<C-Down>']  = ':wincmd j<CR>',
        -- ['<C-Up>']    = ':wincmd k<CR>',
        -- ['<C-Right>'] = ':wincmd l<CR>',
        -- -- [Leader + Ctrl + Arrow] : resize splits
        -- ['<Leader><C-Left>']  = ':vertical resize -8<CR>',
        -- ['<Leader><C-Down>']  = ':resize -8<CR>',
        -- ['<Leader><C-Up>']    = ':resize +8<CR>',
        -- ['<Leader><C-Right>'] = ':vertical resize +8<CR>',
        -- -- [Leader Shift + Arrow] Move splits (drop <C-\><C-n> if using vim)
        -- ['<Leader><S-Left>']  = ':wincmd h | wincmd x<CR>',
        -- ['<Leader><S-Down>']  = ':wincmd j | wincmd x<CR>',
        -- ['<Leader><S-Up>']    = ':wincmd k | wincmd x<CR>',
        -- ['<Leader><S-Right>'] = ':wincmd l | wincmd x<CR>',
    },
    c = {
        -- Make vertical wildmenu controls behave intuitively
        ['<Down>']  = {
            map  = [[wildmenumode() ? "\<Right>" : "\<Down>"]],
            opts = {expr=true, silent=false},
        },
        ['<Up>']    = {
            map  = [[wildmenumode() ? "\<Left>" : "\<Up>"]],
            opts = {expr=true, silent=false},
        },
        ['<Right>'] = {
            map  = [[wildmenumode() ? "\<Down>" : "\<Right>"]],
            opts = {expr=true, silent=false},
        },
        ['<Left>']  = {
            map  = [[wildmenumode() ? "\<Up>" : "\<Left>"]],
            opts = {expr=true, silent=false},
        },
    },
}

M.insert_undo_maps = {
    i = {
        -- Insert undo breakpoints when typing punctuation
        [','] = ',<C-g>u',
        ['.'] = '.<C-g>u',
        ['!'] = '!<C-g>u',
        ['?'] = '?<C-g>u',
        ['('] = '(<C-g>u',
        [')'] = ')<C-g>u',
        ['['] = '[<C-g>u',
        [']'] = ']<C-g>u',
        ['{'] = '{<C-g>u',
        ['}'] = '}<C-g>u',
        ['<'] = '<<C-g>u',
        ['>'] = '><C-g>u',
        ["'"] = "'<C-g>u",
        ['"'] = '"<C-g>u',
        ['`'] = '`<C-g>u',
    },
}

M.setup_packer = function()
    local install_path = vim.fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
    local packer_url = 'https://github.com/wbthomason/packer.nvim'

    if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
        install_cmd = table.concat({'!git clone', packer_url, install_path}, ' ')
        vim.fn.execute(install_cmd)
    end

    -- Update plugins after saving changes to plugins.lua
    vim.api.nvim_exec([[
        augroup Packer
            autocmd!
            autocmd BufWritePost plugins.lua source <afile> | PackerCompile
            autocmd BufWritePost configs.lua source <afile> | PackerCompile
        augroup end
    ]], false)

    -- Add packer to managed plugins
    vim.cmd("packadd packer.nvim")
end

M.disable_built_ins = function()
    for _, i in pairs(DISABLED_BUILT_INS) do
        vim.g['loaded_' .. i] = 1
    end
end

M.set_mapping_group = function(mapping_group)
    for mode, mappings in pairs(mapping_group) do
        for keys, mapping in pairs(mappings) do
            if (type(mapping) == "table") then
                local opts = vim.tbl_extend('force', DEFAULT_MAP_OPTS, mapping.opts)
                vim.api.nvim_set_keymap(mode, keys, mapping.map, opts)
            else
                vim.api.nvim_set_keymap(mode, keys, mapping, DEFAULT_MAP_OPTS)
            end
        end
    end
end

M.my_fold_text = function()
    local line = vim.fn.getline(vim.v.foldstart)

    local indent_str = string.rep(" ", vim.fn.indent(vim.v.foldstart - 1))
    local fold_str = indent_str .. line .. string.rep(" ", 100)

    local fold_size = vim.v.foldend - vim.v.foldstart + 1
    local fold_size_str = " (" .. fold_size .. ") "

    return string.sub(fold_str, 0, 100 - #fold_size_str) .. fold_size_str
end

M.replace_keycodes = function()
    return vim.api.nvim_replace_termcodes(str, true, true, true)
end

return M

