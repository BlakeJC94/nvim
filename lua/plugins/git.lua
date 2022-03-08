MAPPINGS = {
    [''] = {
        -- Navigate git changes in file
        [']g'] = {map=[[&diff ? ']g' : '<cmd>Gitsigns next_hunk<CR>']], opts={expr=true}},
        ['[g'] = {map=[[&diff ? '[g' : '<cmd>Gitsigns prev_hunk<CR>']], opts={expr=true}},
        -- Leader maps
        ['<Leader>G']  = ':Git<CR>',
        ['<Leader>gg'] = ':Gitsigns setqflist<CR>',
        ['<Leader>gs'] = ':Gitsigns stage_hunk<CR>',
        ['<Leader>gu'] = ':Gitsigns undo_stage_hunk<CR>',
        ['<Leader>gr'] = ':Gitsigns reset_hunk<CR>',
        ['<Leader>gR'] = ':Gitsigns reset_buffer<CR>',
        ['<Leader>gp'] = ':Gitsigns preview_hunk<CR>',
        ['<Leader>gb'] = ':lua require("gitsigns").blame_line({full=true})<CR>',
        ['<Leader>gS'] = ':Gitsigns stage_buffer<CR>',
        ['<Leader>gU'] = ':Gitsigns reset_buffer_index<CR>',
        ['<Leader>gd'] = ':vert Gdiffsplit<CR>',
        ['<Leader>gc'] = ':GV<CR>',
    },
}

M = {}

-- Gitgutter, floating hunks, and virtual text blames
M['lewis6991/gitsigns.nvim'] = {
    requires = {'nvim-lua/plenary.nvim',},
    config = function()
        require('gitsigns').setup({
            signcolumn = false,
            numhl      = true,
            linehl     = false,
            keymaps    = {}, -- Keymaps set in init.lua
            current_line_blame = true,
            preview_config = {
                border = 'none',
                style = 'minimal',
                relative = 'cursor',
            }
        })
        require('utils').set_mapping_group(MAPPINGS)
    end
}

-- The ultimate git plugin for Vim
-- TODO set new keymaps
M['tpope/vim-fugitive'] = {
    requires = 'tpope/vim-rhubarb',
}

-- :GV => Better git log
-- TODO consider if this is still needed
M['junegunn/gv.vim'] = {}

return M
