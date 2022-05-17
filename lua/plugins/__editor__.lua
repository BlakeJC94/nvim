-- EDITOR.LUA : Extra functions, commands, keybinds for editing functionality
M = {}

-- Better .-repeat actions
M['tpope/vim-repeat'] = {}

-- cs]} => Change surrounding brackets
M['tpope/vim-surround'] = {}

-- gc<motion> => toggle comments
M['tpope/vim-commentary'] = {}

-- crs => coerce cursor word to snake_case. :Subvert => Case invariant substitution
M['tpope/vim-abolish'] = {}

-- Extra motions (e.g. ]q [q to navigate quickfix list)
-- M['tpope/vim-unimpaired'] = {}

-- Asynchronous job execution (:Make, :Dispatch)
-- M['tpope/vim-dispatch'] = {}

-- Unix commands for vim (:Delete, :Move, :Rename, :Cfind)
-- M['tpope/vim-eunuch'] = {}

-- Readline keybindings for insert/command mode (<C-a> <A-b> <A-f> <C-e>)
M['tpope/vim-rsi'] = {}

-- :DB [url] {cmd} => Interactive database console
-- M['tpope/vim-dadbod'] = {}

-- iv/av => Text objects for substrings in snake/camel/kebab case
M['Julian/vim-textobj-variable-segment'] = {
    requires = {'kana/vim-textobj-user'}
}

-- ic/ac => Text objects for columns of code
-- M['coderifous/textobj-word-column.vim'] = {}

-- gJ => Inverse <S-j> operation
-- M['AckslD/nvim-revJ.lua'] = {
--     requires = {'wellle/targets.vim'},
--     config = function()
--         require("revj").setup{
--             brackets = {first = '([{<', last = ')]}>'}, -- brackets to consider surrounding arguments
--             new_line_before_last_bracket = true, -- add new line between last argument and last bracket (only if no last seperator)
--             add_seperator_for_last_parameter = true, -- if a seperator should be added if not present after last parameter
--             enable_default_keymaps = false, -- enables default keymaps without having to set them below
--             keymaps = {
--                 operator = 'gJ', -- for operator (+motion)
--                 line = 'gJJ', -- for formatting current line
--                 visual = 'gJ', -- for formatting visual selection
--             },
--             parameter_mapping = ',', -- specifies what text object selects an arguments (ie a, and i, by default)
--             -- if you're using `vim-textobj-parameter` you can also set this to `vim.g.vim_textobj_parameter_mapping`
--         }
--     end
-- }

-- gl<obj><char> => align selection to <char>
M['tommcdo/vim-lion'] = {}

-- More text objects
M['wellle/targets.vim'] = {}

-- :PasteImg => Link to image in clipboard
-- M['ekickx/clipboard-image.nvim'] = {}

-- + => Expand selection, - => Shrink selection
M['terryma/vim-expand-region'] = {
    config = function()
        vim.cmd [[
            map + <Plug>(expand_region_expand)
            map - <Plug>(expand_region_shrink)
        ]]
    end
}

-- Enhanced <C-a>/<C-x> operations
M['monaqa/dial.nvim'] = {
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
}

return M
