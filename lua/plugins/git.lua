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
    end
}

-- The ultimate git plugin for Vim
-- TODO set new keymaps
M['tpope/vim-fugitive'] = {
    requires = 'tpope/vim-rhubarb',
}

-- :GV => Better git log
-- TODO consider if this is still needed
-- M['junegunn/gv.vim'] = {}

return M
