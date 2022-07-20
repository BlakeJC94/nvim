----- BLAKEJC94S NEOVIM INIT.LUA ------------------------------------------------------------------
utils = require('utils')

-- DEFINE OPTIONS
BEHAVIOUR_OPTIONS = {
    -- MAIN INPUT/OUTPUT
    clipboard     = "unnamedplus",  -- Allows vim to use "+ for yanks, puts, cuts, and deletes
    timeoutlen    = 1000,           -- Time (ms) between key sequences
    ttimeoutlen   = 10,             -- Time (ms) between key sequences in terminal
    updatetime    = 300,            -- Time (ms) between swapfile writes
    virtualedit   = "block",        -- Allow cursor to move anywhere ('all', 'block', 'insert')
    hidden        = false,          -- Allow buffers to be hidden without saving
    -- TABS AND INDENTS
    smartindent = true,  -- Enable better indenting
    tabstop     = 4,     -- Number of space chars for each tab char
    softtabstop = 4,     -- Number of space chars to insert on pressing tab
    shiftwidth  = 4,     -- Number of space chars used when auto-indenting
    expandtab   = true,  -- Replace tabs with spaces when indenting with </>
    -- SEARCHING
    ignorecase = true,   -- Ignore cases in search patterns
    smartcase  = true,   -- Use case-sensitve search when an uppercase letter is used
    hlsearch   = true,   -- Highlight matches
    incsearch  = true,   -- Highlight matches while typing
    -- BACKUPS AND SPELLING
    swapfile = false,  -- Allow swap files
    backup   = false,  -- Allow creation of backup files
    spell    = true,   -- Built-in spell-checker
    undofile = true,   -- Create global undofile
    undodir  = os.getenv("HOME") .. '/.vim/undodir',
}
LAYOUT_OPTIONS = {
    -- WINDOW DISPLAY
    splitbelow    = true,              -- Open splits below
    splitright    = true,              -- Open vsplits on right
    shortmess     = vim.o.shm .. "I",  -- Disable into message
    termguicolors = true,              -- Wider colorscheme support
    background    = 'dark',            -- Background mode
    -- LINE DISPLAY
    scrolloff      = 8,          -- N lines to keep visible above/below cursor
    sidescrolloff  = 8,          -- N columns to keep visible left/right of cursor
    textwidth      = 99,         -- Margin for text input
    wrap           = false,      -- Soft-wrap long lines and use breakindent opts
    linebreak      = true,       -- Only split/wrap long lines after words
    breakindent    = true,       -- Indent soft-wrapped lines
    breakindentopt = {list=-1},  -- Options for breakindent
    showbreak      = '››› ',     -- Text to print at breakindent
    showmatch      = true,       -- Highlight matching brackets
    -- FOLDS
    foldmethod = 'indent',             -- Auto-create folds by indent levels
    foldlevel  = 0,                    -- Close all folds when opening file
    fillchars  = {fold=' ', eob=' '},  -- Replace dots with spaces in fold head
    foldtext   = 'v:lua.require("functions").CustomFoldText()',
    -- LEFT MARGIN
    number         = true,  -- Show line numbers
    relativenumber = true,  -- Show rel/abs line numbers
    signcolumn     = 'no',  -- Set sign column
    -- BOTTOM MARGIN
    laststatus = 3,     -- Show global status line
    showcmd    = true,  -- Show command in bottom right
    cmdheight  = 2,     -- Set height of command window
    wildignore = {'*.pyc', '**/.git/*', '**/data/*'},
    -- TOP MARGIN
    showtabline = 0,  -- Display tab line (0, never, 1 auto, 2 always)
}


-- LOAD SELECTED PLUGINS  TODO move this into config table
-- TODO:
-- New plugins config structure:
--   plugins.lua
--   packer/
--     - settings.lua
--     - configs.lua
--    * [ ] Create `plugins.lua` that returns a list of ALL plugins in one file
--        * I.e. returns a table {"plugin1", "plugin2", ...}
--    * [ ] Create `packer/settings.lua` that returns a table with additional packer keys
--        * I.e. {["plugin1"] = {requires=...,}}
--        * Create `packer/configs.lua` that returns a table with functions
--          * I.e. {["plugin1"] = function() ... end, ...}
--    * [ ] Write a plugins loader that gets list from `plugins.lua` and checks if "plugin" is in
--        `packer.configs` and extends the packer.use arg if so
--
PLUGINS = {
    "__editor__",
    "__interface__",
    "cmp",
    "git",
    "lsp",
    "lualine",
    "telescope",
    "treesitter",
}
utils.disable_built_ins()
utils.setup_packer()
local status_ok, packer = pcall(require, "packer")
if status_ok then
    packer.init()
    packer.reset()
    packer.use({'wbthomason/packer.nvim'})
    for _, module_name in pairs(PLUGINS) do
        module = require('plugins.' .. module_name)
        for k, v in pairs(module) do
            repo = vim.tbl_extend("force", {k}, v)
            packer.use(repo)
        end
    end
    packer.install()
end


vim.g.mapleader = " "
options = {BEHAVIOUR_OPTIONS, LAYOUT_OPTIONS}
config = {
    {utils._set_options,      options                },
    {utils._set_functions,    require('functions')   },
    {utils._set_autocommands, require('autocommands')},
    {utils._set_commands,     require('commands')    },
    {utils._set_mappings,     require('mappings')    },
}

for _, table in pairs(config) do
    utils.load(table[1], table[2])
end
