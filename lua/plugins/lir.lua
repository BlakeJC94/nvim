M = {}

-- Better File explorer
M["tamago324/lir.nvim"] = {
    requires = {
        'nvim-lua/plenary.nvim',
        'kyazdani42/nvim-web-devicons',
    },
    config = function()

        local actions = require('lir.actions')
        local mark_actions = require('lir.mark.actions')
        local clipboard_actions = require('lir.clipboard.actions')

        require('lir').setup({
            show_hidden_files = false,
            devicons_enable = true,
            mappings = {
                ['<CR>']  = actions.edit,
                ['_']     = actions.split,
                ['|']     = actions.vsplit,
                ['T']     = actions.tabedit,
                ['<BS>']  = actions.up,
                ['q']     = actions.quit,
                ['<ESC>'] = actions.quit,
                ['F']     = actions.mkdir,
                ['f']     = actions.newfile,
                ['R']     = actions.rename,
                ['@']     = actions.cd,
                ['yy']    = actions.yank_path,
                ['.']     = actions.toggle_show_hidden,
                ['dd']    = actions.delete,
                ['M']     = mark_actions.toggle_mark,
                ['Y']     = clipboard_actions.copy,
                ['C']     = clipboard_actions.cut,
                ['P']     = clipboard_actions.paste,
            },
            float = {
                winblend = 0,
            },
            hide_cursor = true,
        })

        -- Use custom folder icon
        require('nvim-web-devicons').set_icon({
            lir_folder_icon={
                icon="",
                name="LirFolderNode",
                color="#7ebae4",
            }
        })

        vim.cmd([[
            command! Lir edit %:p:h
            augroup lir-settings
                autocmd!
                autocmd Filetype lir set nospell
                autocmd Filetype lir nnoremap <buffer> <silent> <Leader><CR> <C-^>
            augroup END
        ]])

    end,
}

return M
