MAPPINGS = {
    [''] = {
        ['<Leader>tt'] = ":Telescope<CR>",                            -- Find Telescopes
        ['<Leader>tb'] = ":Telescope buffers<CR>",                    -- Switch between buffers
        ['<Leader>tr'] = ":Telescope registers<CR>",                  -- Switch between buffers
        ['<Leader>to'] = ":Telescope oldfiles<CR>",                   -- Recently changed files
        ['<Leader>tf'] = ":Telescope current_buffer_fuzzy_find<CR>",  -- Jumping with fuzzyfind
        ['<Leader>tF'] = ":Telescope live_grep<CR>",                  -- Jumping with livegrep
        ['<Leader>th'] = ":Telescope help_tags<CR>",
        ['<Leader>tg'] = ":Telescope git_status<CR>",
        ['<Leader>tc'] = ":Telescope quickfix<CR>",
        ['<Leader>tl'] = ":Telescope loclist<CR>",
        ['<Leader>ts'] = ":Telescope spell_suggest<CR>",
        ['<Leader>ta'] = ":Telescope lsp_code_actions<CR>",
    },
    n = {
        -- Override spellchecker
        ['z='] = {map=[[v:count ? v:count . 'z=' : ':Telescope spell_suggest<CR>']], opts={expr=true}},
    },
    i = {
        -- C-r : See registers with telescope
        ['<C-r>'] = "<cmd>Telescope registers<CR>",
    },
}

M = {}

M['nvim-telescope/telescope-fzf-native.nvim'] = {
    run = 'make'
}

-- Extensible Fuzzy finder
M['nvim-telescope/telescope.nvim'] = {
    requires = {
        'nvim-lua/plenary.nvim',
        'nvim-telescope/telescope-fzf-native.nvim',
    },
    config = function()
        local telescope = require('telescope')
        local actions = require('telescope.actions')

        local telescope_mappings = {
            n = {
                ["q"] = actions.close  -- Make q close telescope window
            },
            i = {
                ["<esc>"] = actions.close
            },
        }

        telescope.setup({
            extensions = {
                fzf = {
                    fuzzy = true,
                    override_generic_sorter = true,
                    override_file_sorter = true,
                    case_mode = "smart_case",
                },
            },
            defaults = {
                borderchars = { " ", " ", " ", " ", " ", " ", " ", " " },
                mappings = telescope_mappings,
            },
            pickers = {
                git_status = {
                    git_icons = {
                        added = " ",
                        changed = " ",
                        copied = " ",
                        deleted = " ",
                        renamed = " ",
                        unmerged = " ",
                        untracked = " ",
                    }
                },
                registers = {
                    theme = "ivy",
                    borderchars = { " ", " ", " ", " ", " ", " ", " ", " " },
                },
                spell_suggest = {
                    theme = "ivy",
                    borderchars = { " ", " ", " ", " ", " ", " ", " ", " " },
                },
            }
        })

        telescope.load_extension('fzf')

        -- Load a couple of custom colours
        vim.cmd [[
            highlight TelescopePromptBorder guibg=#282828
            highlight TelescopePromptNormal guibg=#282828

            highlight TelescopeResultsBorder guibg=#3c3836
            highlight TelescopeResultsNormal guibg=#3c3836

            highlight TelescopePreviewBorder guibg=#282828
            highlight TelescopePreviewNormal guibg=#282828
        ]]

        require('utils').set_mapping_group(MAPPINGS)
    end
}

return M
