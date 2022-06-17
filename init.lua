----- BLAKEJC94S NEOVIM INIT.LUA ------------------------------------------------------------------
utils = require('utils')
PLUGINS = {
    -- BASE PLUGINS
    __editor__    = true,
    __interface__ = true,
    -- EXTENSIONS
    cmp        = true,
    git        = true,
    lsp        = true,
    lualine    = true,
    telescope  = true,
    treesitter = true,
}
OPTIONS = {
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
    },
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
        foldtext   = 'v:lua.require("utils").my_fold_text()',  -- Custom fold text
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
    },
}
MAPS = {
    [''] = {
        ['<F1>'] = {map=':setl relativenumber!<CR>:setl relativenumber?<CR>', opts={silent=false}},
        ['<F2>'] = {map=':setl number!<CR>:setl number?<CR>', opts={silent=false}},
        ['<F3>'] = {map=':setl wrap!<CR>:setl wrap?<CR>', opts={silent=false}},
        ['<F4>'] = {map=':setl spell!<CR>:setl spell?<CR>', opts={silent=false}},
        ['<F6>'] = {map=':wincmd =<CR>', opts={silent=false}},
        -- Move left and right faster
        ['H'] = {map=[[col('.') == match(getline('.'), '\S') + 1 ? '0' : '^']], opts={expr=true}},
        ['L'] = 'g_',
        -- Prevent x and s from overriding what's in the clipboard
        ['x'] = '"_x',
        ['X'] = '"_X',
        ['s'] = '"_s',
        ['S'] = '"_S',
        -- Open folds when flicking through search matches
        ['n'] = 'nzv',
        ['N'] = 'Nzv',
        -- Remap q and Q to stop polluting registers accidentally!
        ['q'] = 'gq',
        ['Q'] = 'q',
        -- Navigate git changes in file
        [']g'] = {map=[[&diff ? ']g' : '<cmd>Gitsigns next_hunk<CR>']], opts={expr=true}},
        ['[g'] = {map=[[&diff ? '[g' : '<cmd>Gitsigns prev_hunk<CR>']], opts={expr=true}},
        -- Navigate diagnostics
        [']e'] = ':lua vim.diagnostic.goto_next()<CR>',
        ['[e'] = ':lua vim.diagnostic.goto_prev()<CR>',
        -- Navigate quickfix list
        [']c'] = ':cnext<CR>',
        ['[c'] = ':cprev<CR>',
        [']l'] = ':lnext<CR>',
        ['[l'] = ':lprev<CR>',
        -- LSP bindings
        ['gd'] = ':Lsp definition<CR>',
        ['gD'] = ':Lsp declaration<CR>',
        ['gI'] = ':Lsp implementation<CR>',
        ['gr'] = ':Lsp references<CR>',
        ['gy'] = ':Lsp typedefinition<CR>',
        -- <C-z> => Toggle terminal
        ['<C-z>'] = "",
        ['<C-z><C-z>'] = ":lua require('FTerm').toggle()<CR>",
        ['<C-z>_'] = ":lua require('FTerm').toggle(); vim.cmd('wincmd J')<CR>",
        ['<C-z>|'] = ":lua require('FTerm').toggle(); vim.cmd('wincmd L')<CR>",
        -- Pane controls
        ['<Leader>_'] = ':split<CR>',
        ['<Leader>|'] = ':vsplit<CR>',
        -- Window controls maps
        ['<C-Left>']  = ':lua require("tmux").move_left()<CR>',
        ['<C-Down>']  = ':lua require("tmux").move_bottom()<CR>',
        ['<C-Up>']    = ':lua require("tmux").move_top()<CR>',
        ['<C-Right>'] = ':lua require("tmux").move_right()<CR>',
        ['<S-Left>']  = ':lua require("tmux").resize_left(8)<CR>',
        ['<S-Down>']  = ':lua require("tmux").resize_bottom(8)<CR>',
        ['<S-Up>']    = ':lua require("tmux").resize_top(8)<CR>',
        ['<S-Right>'] = ':lua require("tmux").resize_right(8)<CR>',
        ['<Leader><Left>']  = ':wincmd H<CR>',
        ['<Leader><Down>']  = ':wincmd J<CR>',
        ['<Leader><Up>']    = ':wincmd K<CR>',
        ['<Leader><Right>'] = ':wincmd L<CR>',
        -- Tab controls
        ['<Leader>.'] = ":tabnext<CR>",
        ['<Leader>,'] = ":tabprev<CR>",
        ['<Leader>>'] = ":+tabmove<CR>",
        ['<Leader><'] = ":-tabmove<CR>",
        ['<Leader>t'] = ':tabedit %<CR>',
        -- Leader maps
        ['<Leader><CR>']  = ":Telescope file_browser<CR>",
        ['<Leader><BS>']  = ":Telescope find_files<CR>",               -- File finder
        ['<Leader><Tab>'] = "<C-^>",                                   -- Last file
        ['<Leader><Esc>'] = ":Telescope buffers<CR>",                     -- Buffers
        ['<Leader>q'] = ":q<CR>",                            -- Quit
        ['<Leader>w'] = ":w<CR>",                            -- Save
        ['<Leader>n'] = ":enew | echo '[New file]'<CR>",
        ['<Leader>N'] = ":bufdo bdel | enew | echo '[New session]'<CR>",
        ['<Leader>d'] = ":lcd %:p:h | echo 'Changed local dir to ' . getcwd()<CR>",
        ['<Leader>D'] = ":cd %:p:h | echo 'Changed dir to ' . getcwd()<CR>",
        ['<Leader>c'] = ":ToggleQL<CR>",               -- Toggle qflist
        ['<Leader>l'] = ":ToggleLL<CR>",               -- Toggle loclist
        ['<Leader>;'] = ":Settings<CR>",               -- Edit settings
        ['<Leader>:'] = ":luafile $MYVIMRC<CR>",       -- Reload settings
        ['<Leader>z'] = ":Twilight<CR>",               -- Toggle FocusMode
        ['<Leader>Z'] = ":ZenMode<CR>",                -- Toggle ZenMode
        ['<Leader>A'] = ":Neogen<CR>",                 -- Generate docs
        -- Telescope leader maps
        ['<Leader>ff'] = ":Telescope resume<CR>",                     -- Open last telescope
        ['<Leader>fF'] = ":Telescope<CR>",                            -- Find Telescopes
        ['<Leader>fb'] = ":Telescope buffers<CR>",                    -- Switch between buffers
        ['<Leader>fr'] = ":Telescope registers<CR>",                  -- Switch between buffers
        ['<Leader>fo'] = ":Telescope oldfiles<CR>",                   -- Recently changed files
        ['<Leader>f/'] = ":Telescope current_buffer_fuzzy_find<CR>",  -- Jumping with fuzzyfind
        ['<Leader>fG'] = ":Telescope live_grep<CR>",                  -- Jumping with livegrep
        ['<Leader>fh'] = ":Telescope help_tags<CR>",
        ['<Leader>fg'] = ":Telescope git_status<CR>",
        ['<Leader>fc'] = ":Telescope quickfix<CR>",
        ['<Leader>fl'] = ":Telescope loclist<CR>",
        ['<Leader>fs'] = ":Telescope spell_suggest<CR>",
        ['<Leader>fa'] = ":Telescope lsp_code_actions<CR>",
        -- Packer leader maps
        ['<Leader>pp'] = ':PackerSync<CR>',
        ['<Leader>pi'] = ':PackerInstall<CR>',
        ['<Leader>pu'] = ':PackerUpdate<CR>',
        ['<Leader>pc'] = ':PackerCompile<CR>',
        ['<Leader>pr'] = ':PackerClean<CR>',
        ['<Leader>ps'] = ':PackerStatus<CR>',
        -- Git leader maps
        ['<Leader>gg'] = ':Git<CR>',
        ['<Leader>gs'] = ':Git status<CR>',
        ['<Leader>gc'] = ':Git commit | startinsert<CR>',
        ['<Leader>gp'] = ':Gitsigns preview_hunk<CR>',
        ['<Leader>gs'] = ':Gitsigns stage_hunk<CR>',
        ['<Leader>gu'] = ':Gitsigns undo_stage_hunk<CR>',
        ['<Leader>gr'] = ':Gitsigns reset_hunk<CR>',
        ['<Leader>gS'] = ':Gitsigns stage_buffer<CR>',
        ['<Leader>gU'] = ':Gitsigns reset_buffer_index<CR>',
        ['<Leader>gR'] = ':Gitsigns reset_buffer<CR>',
        ['<Leader>gd'] = ':Git difftool<CR>',
        ['<Leader>gm'] = ':Git mergetool<CR>',
        ['<Leader>gb'] = ':lua require("gitsigns").blame_line({full=true})<CR>',
        ['<Leader>g|'] = ':Gvdiffsplit<CR>',
        ['<Leader>g_'] = ':Gdiffsplit<CR>',
        -- LSP Leader bindings
        ['<Leader>e'] = ':lua vim.diagnostic.open_float()<CR>',  -- Show line diagnostics
        ['<Leader>E'] = ':lua vim.diagnostic.setloclist()<CR>',  -- Show buffer diagnostics
        ['<Leader>='] = ':Lsp format<CR>',                       -- Format buffer
        ['<Leader>r'] = ':Lsp rename<CR>',                       -- Rename current symbol
        ['<Leader>k'] = ':Lsp signature<CR>',                    -- Show signature help
        ['<Leader>a'] = ':Lsp codeaction<CR>',                   -- Do code action
    },
    n = {
        -- Make Y behave like D and C
        ['Y']  = 'y$',
        -- Clear last search hl with <ESC> before <ESC> action
        ['<ESC>'] = ':noh | redraw | echon ""<CR><ESC>',
        -- Better jumplist for large line steps (and step through visual lines with j/k)
        ['j'] = {map=[[(v:count > 5 ? 'm`' . v:count : 'g') . 'j']], opts={expr=true}},
        ['k'] = {map=[[(v:count > 5 ? 'm`' . v:count : 'g') . 'k']], opts={expr=true}},
        -- gp: Visually select last pasted block (like gv)
        ['gp'] = '`[v`]',
        -- gF: create new file at filename over cursor
        ['gF'] = ':e <c-r><c-f><CR>',
        -- J doesn't move cursor
        ['J'] = 'mzJ`z',
        -- Make {/} don't change the the jumplist
        ['{'] = ':<C-u>keepjumps norm! {<CR>',
        ['}'] = ':<C-u>keepjumps norm! }<CR>',
        -- Change selected word (forward/backwards), . to repeat
        ['c*'] = "/\\<<C-r>=expand('<cword>')<CR>\\>\\C<CR>``cgn",
        ['c#'] = "?\\<<C-r>=expand('<cword>')<CR>\\>\\C<CR>``cgN",
        -- Delete selected word (forward/backwards), . to repeat
        ['d*'] = "/\\<<C-r>=expand('<cword>')<CR>\\>\\C<CR>``dgn",
        ['d#'] = "?\\<<C-r>=expand('<cword>')<CR>\\>\\C<CR>``dgN",
        -- Make K use lsp.hover, call twice to jump to hoverdoc
        ['K'] = ':Lsp hover<CR>',
        -- Override spellchecker
        ['z='] = {map=[[v:count ? v:count . 'z=' : ':Telescope spell_suggest<CR>']], opts={expr=true}},
    },
    v = {
        -- Maintain Visual Mode after >/</= actions
        ['<'] = '<gv',
        ['>'] = '>gv',
        ['='] = '=gv',
        -- Move visual block up or down
        ['J'] = ":m '>+1<CR>gv",
        ['K'] = ":m '<-2<CR>gv",
        -- Stop p from overriding unnamed register in visual mode
        ['p'] = "pgvy",
        ['P'] = "Pgvy",
        -- Replace spaces in selection with underscores
        ['_']  = ":s/\\%V /_/g<CR>",
        ['g_'] = ":s/\\%V_/ /g<CR>",
    },
    i = {
        -- C-s : Quickly guess correct spelling errors (undoable)
        ['<C-s>'] = '<C-g>u<Esc>[s1z=`]a<c-g>u', -- Currently borked by spellsitter?
        -- Make <C-k> use lsp.hover, call twice to jump to hoverdoc
        ['<C-k>'] = '<C-o>:lua vim.lsp.buf.hover()<CR>',
        -- C-r C-r : See registers with telescope
        ['<C-r><C-r>'] = "<cmd>Telescope registers<CR>",
    },
    t = {
        -- [Ctrl + Arrow] to navigate windows
        ['<C-Left>']  = '<C-\\><C-n>:lua require("tmux").move_left()<CR>',
        ['<C-Down>']  = '<C-\\><C-n>:lua require("tmux").move_bottom()<CR>',
        ['<C-Up>']    = '<C-\\><C-n>:lua require("tmux").move_top()<CR>',
        ['<C-Right>'] = '<C-\\><C-n>:lua require("tmux").move_right()<CR>',
        -- [Shift + Arrow] : resize splits
        ['<S-Left>']  = '<C-\\><C-n>:lua require("tmux").resize_left(8)<CR>',
        ['<S-Down>']  = '<C-\\><C-n>:lua require("tmux").resize_bottom(8)<CR>',
        ['<S-Up>']    = '<C-\\><C-n>:lua require("tmux").resize_top(8)<CR>',
        ['<S-Right>'] = '<C-\\><C-n>:lua require("tmux").resize_right(8)<CR>',
        -- [Leader + Arrow] Move splits
        ['<C-z><Left>']  = '<C-\\><C-n>:wincmd H<CR>',
        ['<C-z><Down>']  = '<C-\\><C-n>:wincmd J<CR>',
        ['<C-z><Up>']    = '<C-\\><C-n>:wincmd K<CR>',
        ['<C-z><Right>'] = '<C-\\><C-n>:wincmd L<CR>',
        -- Tab navigation
        ['<C-z>.'] = "<C-\\><C-n>:tabnext<CR>",
        ['<C-z>,'] = "<C-\\><C-n>:tabprev<CR>",
        ['<C-z><S-.>'] = "<C-\\><C-n>:+tabmove<CR>",
        ['<C-z><S-,>'] = "<C-\\><C-n>:-tabmove<CR>",
        -- <Esc><Esc> => (terminal) go to normal mode
        ['<C-z><Esc>'] = '<C-\\><C-n>',
        -- <Esc>: => (terminal) go to command mode
        ['<C-z>:'] = '<C-\\><C-n>:',
        -- <C-z> => ToggleTerm Hide
        ['<C-z><C-z>'] = "<C-\\><C-n>:lua require('FTerm').toggle()<CR>",
    },
    o = {
        -- Custom text object: "around document"
        ['ad'] = '<Cmd>normal! ggVG<CR>',
        ['id'] = '<Cmd>normal! ggVG<CR>',
    },
    x = {
        -- Custom text object: "around document"
        ['ad'] = 'gg0oG$',
        ['id'] = 'gg0oG$',
    },
}

-- LOAD SELECTED PLUGINS
utils.disable_built_ins()
utils.setup_packer()
local status_ok, packer = pcall(require, "packer")
if status_ok then
    packer.init()
    packer.reset()
    packer.use({'wbthomason/packer.nvim'})
    for module_name, opt in pairs(PLUGINS) do
        if opt == true then
            module = require('plugins.' .. module_name)
            for k, v in pairs(module) do
                repo = vim.tbl_extend("force", {k}, v)
                packer.use(repo)
            end
        end
    end
    packer.install()
end

-- SET OPTIONS
for i, opts in pairs(OPTIONS) do
    for k, v in pairs(opts) do vim.opt[k] = v end
end

-- DEFINE COMMANDS (VIMSCRIPT AND LUA)
vim.cmd [[
    luafile ~/.config/nvim/lua/functions.lua
    source  ~/.config/nvim/vimscript/commands.vim
    source  ~/.config/nvim/vimscript/autogroups.vim
]]

-- DEFINE MAPPINGS
vim.g.mapleader = " "
local mapping_groups = {
    MAPS,
    utils.arrow_maps,
    utils.insert_undo_maps,
}
for _, group in ipairs(mapping_groups) do
    utils.set_mapping_group(group)
end
