M = {}

M.MAPS = {
    [''] = {
        -- Move left faster with `gh`
        ['gh'] = {map=[[col('.') == match(getline('.'), '\S') + 1 ? '0' : '^']], opts={expr=true}},
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
        -- Clear last search hl with <C-l> before <C-l> action
        ['<C-l>'] = ':noh | redraw | echon ""<CR><C-l>',
    },
    n = {
        -- Make Y behave like D and C
        ['Y']  = 'y$',
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
    },
    v = {
        -- Maintain Visual Mode after >/</= actions
        ['<'] = '<gv',
        ['>'] = '>gv',
        ['='] = '=gv',
        -- Move visual block up or down
        ['J'] = ":m '>+1<CR>gv",
        ['K'] = ":m '<-2<CR>gv",
        -- Replace spaces in selection with underscores
        ['_']  = ":s/\\%V /_/g<CR>",
        ['g_'] = ":s/\\%V_/ /g<CR>",
    },
    i = {
        -- C-s : Quickly guess correct spelling errors (undoable)
        ['<C-s>'] = '<C-g>u<Esc>[s1z=`]a<c-g>u', -- Currently borked by spellsitter?
    },
    t = {
        -- <C-l> => Do C-l action in vim as well
        ['<C-l>'] = '<C-l><C-\\><C-n>:noh | redraw | echon ""<CR>i',
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

M.LEADER_MAPS = {
    ['']= {
        ['<Leader><CR>']  = ":Telescope file_browser<CR>",  -- File browser
        ['<Leader><BS>']  = ":Telescope find_files<CR>",    -- File finder
        ['<Leader><Tab>'] = "<C-^>",                        -- Last file
        ['<Leader><Esc>'] = ":Telescope buffers<CR>",       -- Buffers
        ['<Leader>q'] = ":q<CR>",                           -- Quit
        ['<Leader>n'] = ":NewFile<CR>",
        ['<Leader>N'] = ":NewSession<CR>",
        ['<Leader>d'] = ":ChangeLocalDir<CR>",
        ['<Leader>D'] = ":ChangeDir<CR>",
        ['<Leader>c'] = ":ToggleQL<CR>",               -- Toggle qflist
        ['<Leader>l'] = ":ToggleLL<CR>",               -- Toggle loclist
        ['<Leader>;'] = ":Settings<CR>",               -- Edit settings
        ['<Leader>:'] = ":luafile $MYVIMRC<CR>",       -- Reload settings
        ['<Leader>z'] = ":Twilight<CR>",               -- Toggle FocusMode
        ['<Leader>Z'] = ":ZenMode<CR>",                -- Toggle ZenMode
        ['<Leader>A'] = ":Neogen<CR>",                 -- Generate docs
    }
}

M.NAVIGATION_MAPS = {
    [''] = {
        -- Vim split controls
        ['<Leader>_'] = ':split<CR>',
        ['<Leader>|'] = ':vsplit<CR>',
        -- Vim Tab controls
        ['<Leader>t'] = ':tabedit %<CR>',
        ['<Leader>.'] = ":tabnext<CR>",
        ['<Leader>,'] = ":tabprev<CR>",
        ['<Leader>>'] = ":+tabmove<CR>",
        ['<Leader><'] = ":-tabmove<CR>",
        -- <Leader><S-Arrow> => Move split to direction
        ['<Leader>H'] = '<C-w>H',
        ['<Leader>J'] = '<C-w>J',
        ['<Leader>K'] = '<C-w>K',
        ['<Leader>L'] = '<C-w>L',
        ['<Leader><S-Left>'] =  '<C-w>H',
        ['<Leader><S-Down>'] =  '<C-w>J',
        ['<Leader><S-Up>'] =    '<C-w>K',
        ['<Leader><S-Right>'] = '<C-w>L',
        -- <A-Arrow> => Resize split
        ['<A-h>'] = function() require("tmux").resize_left(8)   end,
        ['<A-j>'] = function() require("tmux").resize_bottom(4) end,
        ['<A-k>'] = function() require("tmux").resize_top(4)    end,
        ['<A-l>'] = function() require("tmux").resize_right(8)  end,
        ['<A-Left>'] =  function() require("tmux").resize_left(8)   end,
        ['<A-Down>'] =  function() require("tmux").resize_bottom(4) end,
        ['<A-Up>'] =    function() require("tmux").resize_top(4)    end,
        ['<A-Right>'] = function() require("tmux").resize_right(8)  end,
        -- <C-Space> => Terminal "leader"
        --   <C-Space><C-Space> => Toggle floating terminal
        --   <C-Space>_ => Toggle split terminal
        --   <C-Space>| => Toggle vertical split terminal
        ['<C-Space>'] = "",
        ['<C-Space><C-Space>'] = function() require('FTerm').toggle() end,
        ['<C-Space>_'] = function() require('FTerm').toggle(); vim.cmd('wincmd J') end,
        ['<C-Space>|'] = function() require('FTerm').toggle(); vim.cmd('wincmd L') end,
        -- <C-z> => map to <C-w> wincmds (useful when not using tmux)
        ['<C-z>'] = {map='<C-w>', opts={noremap=false}},
        -- <C-w><Arrow> => Mave to tmux/vim splits
        ['<C-w><Left>'] =  {map=function() require("tmux").move_left()   end, opts={noremap=false}},
        ['<C-w>h'] =       {map=function() require("tmux").move_left()   end, opts={noremap=false}},
        ['<C-w><Down>'] =  {map=function() require("tmux").move_bottom() end, opts={noremap=false}},
        ['<C-w>j'] =       {map=function() require("tmux").move_bottom() end, opts={noremap=false}},
        ['<C-w><Up>'] =    {map=function() require("tmux").move_top()    end, opts={noremap=false}},
        ['<C-w>k'] =       {map=function() require("tmux").move_top()    end, opts={noremap=false}},
        ['<C-w><Right>'] = {map=function() require("tmux").move_right()  end, opts={noremap=false}},
        ['<C-w>l'] =       {map=function() require("tmux").move_right()  end, opts={noremap=false}},
    },
    t = {
        -- <C-Space> => ToggleTerm Hide
        ['<C-Space><C-Space>'] = function() require('FTerm').toggle() end,
        -- Tab navigation
        ['<C-Space>.'] = function() vim.cmd('tabnext') end,
        ['<C-Space>,'] = function() vim.cmd('tabprev') end,
        ['<C-Space><S-.>'] = function() vim.cmd('+tabmove') end,
        ['<C-Space><S-,>'] = function() vim.cmd('-tabmove') end,
        -- <Esc><Esc> => (terminal) go to normal mode
        ['<C-Space><Esc>'] = '<C-\\><C-n>',
        -- <Esc>: => (terminal) go to command mode
        ['<C-Space>:'] = '<C-\\><C-n>:',
        -- <C-z> => Tmux bindkey passthrough
        ['<C-z>'] = {map="<C-\\><C-n><C-w>", opts={noremap=false}},
    },
}

M.FKEY_MAPS = {
    [''] = {
        ['<F1>'] = {map=':setl relativenumber!<CR>:setl relativenumber?<CR>', opts={silent=false}},
        ['<F2>'] = {map=':setl number!<CR>:setl number?<CR>', opts={silent=false}},
        ['<F3>'] = {map=':setl wrap!<CR>:setl wrap?<CR>', opts={silent=false}},
        ['<F4>'] = {map=':setl spell!<CR>:setl spell?<CR>', opts={silent=false}},
        ['<F6>'] = {map=':wincmd =<CR>', opts={silent=false}},
    },
}

M.QFLIST_MAPS = {
    [''] = {
        -- Navigate quickfix list
        [']c'] = ':cnext<CR>',
        ['[c'] = ':cprev<CR>',
        [']l'] = ':lnext<CR>',
        ['[l'] = ':lprev<CR>',
    },
}

M.LSP_MAPS = {
    [''] = {
        -- Navigate diagnostics
        [']e'] = function() vim.diagnostic.goto_next() end,
        ['[e'] = function() vim.diagnostic.goto_prev() end,
        -- LSP bindings
        ['gd'] = function() vim.lsp.buf.definition() end,
        ['gD'] = function() vim.lsp.buf.declaration() end,
        ['gI'] = function() vim.lsp.buf.implementation() end,
        ['gR'] = function() vim.lsp.buf.references() end,
        ['gy'] = function() vim.lsp.buf.type_definition() end,
        ['gw'] = function() vim.lsp.buf.document_symbol() end,
        -- LSP Leader bindings
        ['<Leader>e'] = function() vim.diagnostic.open_float() end,        -- Show line diagnostics
        ['<Leader>E'] = function() vim.diagnostic.setloclist() end,        -- Show buffer diagnostics
        ['<Leader>='] = function() vim.lsp.buf.formatting_seq_sync() end,  -- Format buffer
        ['<Leader>r'] = function() vim.lsp.buf.rename() end,               -- Rename current symbol
        ['<Leader>k'] = function() vim.lsp.buf.signature_help() end,       -- Show signature help
        ['<Leader>a'] = function() vim.lsp.buf.code_action() end,          -- Do code action
    },
    ['n'] = {
        -- Make K use lsp.hover, call twice to jump to hoverdoc
        ['K'] = function() vim.lsp.buf.hover() end,
    },
    ['i'] = {
        -- Make <C-k> use lsp.hover, call twice to jump to hoverdoc
        ['<C-k>'] = function() vim.lsp.buf.hover() end,
    },
}

M.GIT_MAPS = {
    [''] = {
        -- Navigate git changes in file
        [']g'] = {map=[[&diff ? ']g' : '<cmd>Gitsigns next_hunk<CR>']], opts={expr=true}},
        ['[g'] = {map=[[&diff ? '[g' : '<cmd>Gitsigns prev_hunk<CR>']], opts={expr=true}},
        -- Leader maps
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
        ['<Leader>gb'] = function() require("gitsigns").blame_line({full=true}) end,
        ['<Leader>g|'] = ':Gvdiffsplit<CR>',
        ['<Leader>g_'] = ':Gdiffsplit<CR>',
    },
}

M.TELESCOPE_MAPS = {
    [''] = {
        ['<Leader>ff'] = ":Telescope resume<CR>",                     -- Open last telescope
        ['<Leader>fF'] = ":Telescope<CR>",                            -- Find Telescopes
        ['<Leader>fb'] = ":Telescope buffers<CR>",                    -- Switch between buffers
        ['<Leader>fr'] = ":Telescope registers<CR>",                  -- Switch between buffers
        ['<Leader>fo'] = ":Telescope oldfiles<CR>",                   -- Recently changed files
        ['<Leader>f/'] = ":Telescope current_buffer_fuzzy_find<CR>",  -- Jumping with fuzzyfind
        ['<Leader>fg'] = ":Telescope live_grep<CR>",                  -- Jumping with livegrep
        ['<Leader>fh'] = ":Telescope help_tags<CR>",
        ['<Leader>fG'] = ":Telescope git_status<CR>",
        ['<Leader>fc'] = ":Telescope quickfix<CR>",
        ['<Leader>fl'] = ":Telescope loclist<CR>",
        ['<Leader>fs'] = ":Telescope spell_suggest<CR>",
        ['<Leader>fa'] = ":Telescope lsp_code_actions<CR>",
    },
    ['n'] = {
        -- Override spellchecker
        ['z='] = {map=[[v:count ? v:count . 'z=' : ':Telescope spell_suggest<CR>']], opts={expr=true}},
    },
    ['i'] = {
        -- C-r C-r : See registers with telescope
        ['<C-r><C-r>'] = "<cmd>Telescope registers<CR>",
    },
}

M.PACKER_MAPS = {
    [''] = {
        ['<Leader>pp'] = ':PackerSync<CR>',
        ['<Leader>pi'] = ':PackerInstall<CR>',
        ['<Leader>pu'] = ':PackerUpdate<CR>',
        ['<Leader>pc'] = ':PackerCompile<CR>',
        ['<Leader>pr'] = ':PackerClean<CR>',
        ['<Leader>ps'] = ':PackerStatus<CR>',
    },
}

M.DISABLE_ARROW_MAPS = {
    [''] = {
        -- Disable arrow keys, git gud with hjkl! (and bwe)
        ['<Left>']  = '',
        ['<Down>']  = '',
        ['<Up>']    = '',
        ['<Right>'] = '',
        ['<C-Left>']  = '',
        ['<C-Down>']  = '',
        ['<C-Up>']    = '',
        ['<C-Right>'] = '',
        ['<S-Left>']  = '',
        ['<S-Down>']  = '',
        ['<S-Up>']    = '',
        ['<S-Right>'] = '',
    },
    c = {
        -- Intuitive vertical wildmenu controls
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

M.INSERT_UNDO_MAPS = {
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

return M
