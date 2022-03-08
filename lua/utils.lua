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
        -- [Ctrl + Arrow] to navigate windows
        ['<C-Left>']  = ':wincmd h<CR>',
        ['<C-Down>']  = ':wincmd j<CR>',
        ['<C-Up>']    = ':wincmd k<CR>',
        ['<C-Right>'] = ':wincmd l<CR>',
        -- [Shift + Arrow] Move splits (drop <C-\><C-n> if using vim)
        ['<S-Left>']  = ':wincmd H<CR>',
        ['<S-Down>']  = ':wincmd J<CR>',
        ['<S-Up>']    = ':wincmd K<CR>',
        ['<S-Right>'] = ':wincmd L<CR>',
        -- [Alt + Arrow] : resize splits
        ['<A-Left>']  = ':vertical resize -8<CR>',
        ['<A-Down>']  = ':resize -8<CR>',
        ['<A-Up>']    = ':resize +8<CR>',
        ['<A-Right>'] = ':vertical resize +8<CR>',
    },
    t = {
        -- [Ctrl + Arrow] to navigate windows
        ['<C-Left>']  = '<C-\\><C-n>:wincmd h<CR>',
        ['<C-Down>']  = '<C-\\><C-n>:wincmd j<CR>',
        ['<C-Up>']    = '<C-\\><C-n>:wincmd k<CR>',
        ['<C-Right>'] = '<C-\\><C-n>:wincmd l<CR>',
        -- [Shift + Arrow] Move splits
        ['<S-Left>']  = '<C-\\><C-n>:wincmd H<CR>',
        ['<S-Down>']  = '<C-\\><C-n>:wincmd J<CR>',
        ['<S-Up>']    = '<C-\\><C-n>:wincmd K<CR>',
        ['<S-Right>'] = '<C-\\><C-n>:wincmd L<CR>',
        -- [Alt + Arrow] : resize splits
        ['<A-Left>']  = '<C-\\><C-n>:vertical resize -8<CR>',
        ['<A-Down>']  = '<C-\\><C-n>:resize -8<CR>',
        ['<A-Up>']    = '<C-\\><C-n>:resize +8<CR>',
        ['<A-Right>'] = '<C-\\><C-n>:vertical resize +8<CR>',
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

M.packer_maps = {
    [''] = {
        ['<Leader>pp'] = ':PackerSync<CR>',
        ['<Leader>pi'] = ':PackerInstall<CR>',
        ['<Leader>pu'] = ':PackerUpdate<CR>',
        ['<Leader>pc'] = ':PackerCompile<CR>',
        ['<Leader>pr'] = ':PackerClean<CR>',
        ['<Leader>ps'] = ':PackerStatus<CR>',
    }
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

M.set_arrow_mappings = function()
    require('utils').set_mapping_group(ARROW_MAPS)
end

M.set_packer_mappings = function()
    require('utils').set_mapping_group(PACKER_MAPS)
end

M.set_insert_undo_mappings = function()
    require('utils').set_mapping_group(INSERT_UNDO_MAPS)
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

