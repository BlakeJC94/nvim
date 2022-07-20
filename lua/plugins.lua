M = {}

M.EDITOR = {
    'inkarkat/vim-visualrepeat',  -- Better .-repreat actions for visual mode
    'kana/vim-smartinput',  -- Minimal autopairs (maybe this one will be alright?)
    'tpope/vim-dispatch',  -- Asynchronous job execution (:Make, :Dispatch)
    'tpope/vim-eunuch',  -- Unix commands for vim (:Delete, :Move, :Rename, :Cfind)
    'tpope/vim-rsi',  -- Readline keybindings for insert/command mode (<C-a> <A-b> <A-f> <C-e>)
}

M.OPERATIONS = {
    'tpope/vim-repeat',  -- Better .-repeat actions
    'christoomey/vim-sort-motion',  -- gs<object> ==> Sort operator across object
    'AckslD/nvim-revJ.lua',  -- gJ => Inverse <S-j> operation
    'tpope/vim-abolish',  -- crs => coerce cursor word to snake_case. :Subvert => Case invariant substitution
    'tommcdo/vim-lion',  -- gl<obj><char> => align selection to <char>
    'thinca/vim-visualstar',  -- Star operator for visual mode, search current selections
    'tpope/vim-surround',  -- cs]} => Change surrounding brackets
    'tpope/vim-commentary',  -- gc<motion> => toggle comments
    'inkarkat/vim-ReplaceWithRegister',  -- ["x]gr<motion> ==> Replace motion region with register x

}

M.TEXTOBJS = {
    'wellle/targets.vim',  -- More text objects
    'Julian/vim-textobj-variable-segment',  -- iv/av => Text objects for substrings in snake/camel/kebab case
    'kana/vim-textobj-entire',  -- ae/ie ==> Text objects for around/in everything in file
}

M.TERMINAL = {
    'jpalardy/vim-slime',  -- <C-c><C-c> => Send code snippet to terminal
    '5long/pytest-vim-compiler',
    'numToStr/FTerm.nvim',
    'aserowy/tmux.nvim',
}

M.COLOURS = {
    "ellisonleao/gruvbox.nvim",  -- Colorscheme
    "lukas-reineke/indent-blankline.nvim",  -- Indent guides
    "unblevable/quick-scope",  -- Better f/t targets
    'norcalli/nvim-colorizer.lua',  -- Colors Hex codes
    "RRethy/vim-illuminate",  -- Subtle highlighting of instances of word under cursor
    'danilamihailov/beacon.nvim',  -- Ping cursor location after jump
    "fladson/vim-kitty",  -- Highlighting for kitty config
}

M.INTERFACE = {
    'nvim-lualine/lualine.nvim',
    'https://gitlab.com/yorickpeterse/nvim-pqf',  -- Better quickfix list format
    'nacro90/numb.nvim',  -- Peek buffer lines during selection in command mode
    'ethanholz/nvim-lastplace',  -- Jump to last place when opening a file
    "luukvbaal/stabilize.nvim",  -- Stabilise split creation
    'alec-gibson/nvim-tetris',  -- :Tetris
}

M.COMPLETION = {
    "hrsh7th/nvim-cmp",
}

M.LSP = {
    'neovim/nvim-lspconfig',  -- LSP Engine configuration
    'jose-elias-alvarez/null-ls.nvim',  -- Extra sources for LSP
    'j-hui/fidget.nvim',  -- Loading status for LSP in bottom right
    'Mofiqul/trld.nvim',  -- display diagnostic status in top right
}

M.GIT = {
    'lewis6991/gitsigns.nvim', -- Gitgutter, floating hunks, and virtual text blames
    'tpope/vim-fugitive',  -- The ultimate git plugin for Vim
    'junegunn/gv.vim',  -- :GV => Better git log
}

M.TELESCOPE = {
    'nvim-telescope/telescope-fzf-native.nvim',
    'nvim-telescope/telescope.nvim', -- Extensible Fuzzy finder
}

M.TREESITTER = {
    'nvim-treesitter/nvim-treesitter',  -- TreeSitter plugin configuration
    'lewis6991/spellsitter.nvim',  -- Spellbad highlight groups in comments with TreeSitter
    'lewis6991/nvim-treesitter-context',  -- Show current context at top of window if needed
    "danymat/neogen",  -- :Neogen => Generate annotations for function
}

return M
