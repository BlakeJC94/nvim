M = {}

M['nvim-telescope/telescope-fzf-native.nvim'] = {
    run = 'make'
}

-- Extensible Fuzzy finder
M['nvim-telescope/telescope.nvim'] = {
    requires = {
        'nvim-lua/plenary.nvim',
        'nvim-telescope/telescope-fzf-native.nvim',
        'nvim-telescope/telescope-file-browser.nvim',
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
                file_browser = {
                    theme = "ivy",
                    borderchars = { " ", " ", " ", " ", " ", " ", " ", " " },
                    previewer=false,
                    hijack_netrw = true,
                    path = "%:p:h",
                    grouped = true,
                    hidden = true,
                    display_stat=false,
                },
            },
            defaults = {
                borderchars = { " ", " ", " ", " ", " ", " ", " ", " " },
                mappings = telescope_mappings,
            },
            pickers = {
                find_files = {
                    hidden=true,
                },
                git_status = {
                    git_icons = {
                        added = "",
                        changed = "",
                        copied = "",
                        deleted = "",
                        renamed = "",
                        unmerged = "",
                        untracked = "",
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
        telescope.load_extension('file_browser')

        -- Load a couple of custom colours
        vim.cmd [[
            highlight TelescopePromptBorder guibg=#282828
            highlight TelescopePromptNormal guibg=#282828

            highlight TelescopeResultsBorder guibg=#3c3836
            highlight TelescopeResultsNormal guibg=#3c3836

            highlight TelescopePreviewBorder guibg=#282828
            highlight TelescopePreviewNormal guibg=#282828
        ]]
    end
}

return M
