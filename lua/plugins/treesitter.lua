M = {}

-- TreeSitter plugin configuration
M['nvim-treesitter/nvim-treesitter'] = {
    requires = {
        'nvim-treesitter/playground',
        'nvim-treesitter/nvim-treesitter-textobjects',
    },
    run = ':TSUpdate',
    config = function()
        local default_parsers = {
            "comment",
            "markdown",
            "python",
            "bash",
            "lua",
            "regex",
            "julia",
            "r",
            "rst",
        }
        require('nvim-treesitter.configs').setup({
            ensure_installed = default_parsers,
            sync_install = false,
            highlight = {
                enable = true,
            },
            indent = {
                enable = true,
                -- disable = {"python", },
            },
            playground = {
                enable = true,
                disable = {},
                updatetime = 25, -- Debounced time for highlighting nodes in the playground from source code
                persist_queries = false, -- Whether the query persists across vim sessions
                keybindings = {
                    toggle_query_editor = 'o',
                    toggle_hl_groups = 'i',
                    toggle_injected_languages = 't',
                    toggle_anonymous_nodes = 'a',
                    toggle_language_display = 'I',
                    focus_language = 'f',
                    unfocus_language = 'F',
                    update = 'R',
                    goto_node = '<cr>',
                    show_help = '?',
                },
            },
            textobjects = {
                select = {
                    enable = true,
                }
            },
        })
    end,
}

-- Spellbad highlight groups in comments with TreeSitter
M['lewis6991/spellsitter.nvim'] = {
    -- after = {'nvim-treesitter/nvim-treesitter'},
    config = function() require('spellsitter').setup() end,
}

-- Show current context at top of window if needed
M['romgrk/nvim-treesitter-context'] = {
    -- after = {'nvim-treesitter/nvim-treesitter'},
    config = function()
        require('treesitter-context').setup({
            enable = true, -- Enable this plugin (Can be enabled/disabled later via commands)
            throttle = true, -- Throttles plugin updates (may improve performance)
            max_lines = 0, -- How many lines the window should span. Values <= 0 mean no limit.
            patterns = { -- Match patterns for TS nodes. These get wrapped to match at word boundaries.
                -- For all filetypes
                -- Note that setting an entry here replaces all other patterns for this entry.
                -- By setting the 'default' entry below, you can control which nodes you want to
                -- appear in the context window.
                default = {
                    'class',
                    'function',
                    'method',
                    -- 'for', -- These won't appear in the context
                    -- 'while',
                    -- 'if',
                    -- 'switch',
                    -- 'case',
                },
                -- Example for a specific filetype.
                -- If a pattern is missing, *open a PR* so everyone can benefit.
                --   rust = {
                --       'impl_item',
                --   },
            },
        })
    end,
}

-- :Neogen => Generate annotations for function
M["danymat/neogen"] = {
    requires = "nvim-treesitter/nvim-treesitter",
    config = function() require('neogen').setup({enabled = true}) end,
}

-- :Cheatsheet => Show a cheatsheet
M['RishabhRD/nvim-cheat.sh'] = {
    requires = 'RishabhRD/popfix'
}

-- Fix for Python auto-indent in Treesitter
M['Vimjas/vim-python-pep8-indent'] = {}

-- Language pack to use if TS not present
-- M['sheerun/vim-polyglot'] = {}

return M
