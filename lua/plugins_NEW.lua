M = {}

M.EDITOR = {
    -- Better .-repeat actions
    ['tpope/vim-repeat'] = {},
    -- cs]} => Change surrounding brackets
    ['tpope/vim-surround'] = {},
    -- gc<motion> => toggle comments
    ['tpope/vim-commentary'] = {},
    -- crs => coerce cursor word to snake_case. :Subvert => Case invariant substitution
    ['tpope/vim-abolish'] = {},
    -- gs<object> ==> Sort operator across object
    ['christoomey/vim-sort-motion'] = {},
    -- Better .-repreat actions for visual mode
    ['inkarkat/vim-visualrepeat'] = {},
    -- ["x]gr<motion> ==> Replace motion region with register x
    ['inkarkat/vim-ReplaceWithRegister'] = {
        requires = {"inkarkat/vim-ingo-library"},
    },
    -- Minimal autopairs (maybe this one will be alright?)
    ['kana/vim-smartinput'] = {},
    -- ae/ie ==> Text objects for around/in everything in file
    ['kana/vim-textobj-entire'] = {},
    -- Star operator for visual mode, search current selections
    ['thinca/vim-visualstar'] = {
        config = function()
            vim.g['visualstar_extra_commands'] = 'zzzv'
        end
    },
    -- Extra motions (e.g. ]q [q to navigate quickfix list)
    -- ['tpope/vim-unimpaired'] = {},
    -- Asynchronous job execution (:Make, :Dispatch)
    -- ['tpope/vim-dispatch'] = {},
    -- Unix commands for vim (:Delete, :Move, :Rename, :Cfind)
    -- ['tpope/vim-eunuch'] = {},
    -- Readline keybindings for insert/command mode (<C-a> <A-b> <A-f> <C-e>)
    ['tpope/vim-rsi'] = {},
    -- :DB [url] {cmd} => Interactive database console
    -- ['tpope/vim-dadbod'] = {},
    -- iv/av => Text objects for substrings in snake/camel/kebab case
    ['Julian/vim-textobj-variable-segment'] = {
        requires = {'kana/vim-textobj-user'}
    },
    -- ic/ac => Text objects for columns of code
    -- ['coderifous/textobj-word-column.vim'] = {}
    -- gJ => Inverse <S-j> operation
    ['AckslD/nvim-revJ.lua'] = {
        requires = {
            'kana/vim-textobj-user',
            'sgur/vim-textobj-parameter',
        },
        config = function()
            require("revj").setup({
                keymaps = {
                    operator = 'gJ', -- for operator (+motion)
                    line = 'gJJ', -- for formatting current line
                    visual = 'gJ', -- for formatting visual selection
                },
            })
        end
    },
    -- gl<obj><char> => align selection to <char>
    ['tommcdo/vim-lion'] = {},
    -- More text objects
    ['wellle/targets.vim'] = {},
    -- :PasteImg => Link to image in clipboard
    -- ['ekickx/clipboard-image.nvim'] = {}
    -- + => Expand selection, - => Shrink selection
    ['terryma/vim-expand-region'] = {
        config = function()
            vim.cmd [[
                map + <Plug>(expand_region_expand)
                map - <Plug>(expand_region_shrink)
            ]]
        end
    },
    -- Enhanced <C-a>/<C-x> operations
    ['monaqa/dial.nvim'] = {
        config = function()
            vim.cmd [[
                nmap  <C-a>  <Plug>(dial-increment)
                nmap  <C-x>  <Plug>(dial-decrement)
                vmap  <C-a>  <Plug>(dial-increment)
                vmap  <C-x>  <Plug>(dial-decrement)
                vmap g<C-a> g<Plug>(dial-increment)
                vmap g<C-x> g<Plug>(dial-decrement)
            ]]
        end,
    },
}

M.INTERFACE = { }

M.CMP = { }

M.GIT = { }

M.LUALINE = { }

M.TELESCOPE = { }

M.TREESITTER = { }

