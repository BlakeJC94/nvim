-- INTERFACE.LUA : Changes and enhancements to UX and non-editor functions
M = {}

-- Colorscheme
M["ellisonleao/gruvbox.nvim"] = {
    requires = {"rktjmp/lush.nvim"},
    config = function()
        vim.cmd [[
            augroup gruvbox_overrides
                autocmd!
                autocmd ColorScheme * hi Folded guibg='#282828'
                autocmd ColorScheme * hi ColorColumn guibg='#282828'
                autocmd ColorScheme * hi CursorLine guibg='#282828'
                autocmd ColorScheme * hi CursorLineNr guibg='#282828'
            augroup END
        ]]
        vim.g.gruvbox_italic            = 1
        vim.g.gruvbox_contrast_dark     = 'hard'
        vim.g.gruvbox_italicize_strings = 1
        vim.cmd [[colorscheme gruvbox]]
        vim.cmd("highlight IndentBlanklineContextChar guifg=#a89984 gui=nocombine")
    end,
}

M["numToStr/FTerm.nvim"] = {
    config = function() require('FTerm').setup({}) end
}

-- <C-c><C-c> => Send code snippet to neovim terminal
M['jpalardy/vim-slime'] = {
    config = function()
        vim.g.slime_target = "neovim"
        vim.g.slime_python_ipython = 1
    end
}

-- Toggle undotree
-- M['mbbill/undotree'] = {}

-- :ZenMode => Toggle Focus Mode (:Twilight => Toggle Focus highlights)
M["folke/zen-mode.nvim"] = {
    requires = {"folke/twilight.nvim"},
    config = function() require("zen-mode").setup({
        window = {
            options = {
                number = false,
                relativenumber = false,
            }
        }
    }) end
}

-- Firefox injection
-- M['glacambre/firenvim'] = {
--     run = function() vim.fn['firenvim#install'](0) end,
--     config = function()
--         -- set specific filetypes for websites
--         vim.cmd [[ au BufEnter github.com_*.txt set filetype=markdown ]]

--         vim.g.firenvim_config = {
--             globalSettings = {
--                 alt = 'all',
--             },
--             localSettings = {
--                 ['.*'] = {
--                     cmdline= 'neovim',
--                     content= 'text',
--                     priority= 0,
--                     selector= 'textarea',
--                     takeover= 'never', -- disable until called with firefox hotkey <C-e>
--                 }
--             },
--         }
--         vim.cmd [[
--             if exists('g:started_by_firenvim')
--                 set wrap linebreak colorcolumn=0 breakindent
--                 "autocmd! TextChanged * ++nested write
--                 "autocmd! TextChangedI * ++nested write
--                 autocmd! InsertLeave,TextChanged * write
--                 echo 'TRACE'
--                 "hi Normal guibg='#1d2021'
--             endif
--         ]]
--     end
-- }

-- Better quickfix list format
M['https://gitlab.com/yorickpeterse/nvim-pqf'] = {
    config = function()
        local pqf = require('pqf')
        pqf.setup({
            signs = {
                error = " ",
                warning = " ",
                info = " " ,
                hint = " ",
            }
        })
    end
}

-- :Tetris
M['alec-gibson/nvim-tetris'] = {}

-- Highlight lines during selection in command mode
-- M["winston0410/range-highlight.nvim"] = {
--     config = function() require('range-highlight').setup({}) end,
--     requires = {'winston0410/cmd-parser.nvim'}
-- }

-- Peek buffer lines during selection in command mode
M['nacro90/numb.nvim'] = {
    config = function() require('numb').setup() end,
}

-- Jump to last place when opening a file
M['ethanholz/nvim-lastplace'] = {
    config = function() require('nvim-lastplace').setup{} end,
}

-- Stabilise split creation
M["luukvbaal/stabilize.nvim"] = {
    config = function() require("stabilize").setup() end
}

-- Ping cursor location after jump
M['danilamihailov/beacon.nvim'] = {}

-- Indent guides
M["lukas-reineke/indent-blankline.nvim"] = {
    requires = {"lukas-reineke/virt-column.nvim"},
    config = function()
        require("indent_blankline").setup({
            show_current_context = true,
            show_current_context_start = false,
            filetype_exclude = {
                "help",
                "alpha",
                "lir",
                "packer",
                "man",
            },
            buftype_exclude = {"terminal",},
        })
    end
}

-- Better f/t targets
M["unblevable/quick-scope"] = {
    config = function()
        vim.g.qs_max_chars=800
        vim.g.qs_highlight_on_keys = {'f', 'F', 't', 'T'}
        vim.cmd [[
            function! QSColors()
                highlight QuickScopePrimary guifg='#ff007c' gui=bold ctermfg=198 cterm=bold
                highlight QuickScopeSecondary guifg='#00dfff' gui=bold ctermfg=45 cterm=bold
            endfunction
            call QSColors()
            augroup qs_colors
                autocmd!
                autocmd ColorScheme * call QSColors()
            augroup END
        ]]
    end
}

-- Colors Hex codes
M['norcalli/nvim-colorizer.lua'] = {
    config = function() require("colorizer").setup({'*'}, {names=false}) end
}

-- Subtle highlighting of instances of word under cursor
M["RRethy/vim-illuminate"] = {
    config = function()
        vim.g.Illuminate_ftblacklist = {'lir'}
    end
}

-- Dim inactive splits
-- M['sunjon/Shade.nvim'] = {
--     config = function() require'shade'.setup() end,
-- }

-- Highlighting for kitty config
M["fladson/vim-kitty"] = {}

return M
