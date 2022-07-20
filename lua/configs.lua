M = {}

M['inkarkat/vim-ReplaceWithRegister'] = {
    requires = {"inkarkat/vim-ingo-library"},
}

M['thinca/vim-visualstar'] = {
    config = function()
        vim.g['visualstar_extra_commands'] = 'zzzv'
    end
}

M['Julian/vim-textobj-variable-segment'] = {
    requires = {'kana/vim-textobj-user'},
    branch = "main",
}

M['AckslD/nvim-revJ.lua'] = {
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
}

M["ellisonleao/gruvbox.nvim"] = {
    requires = {"rktjmp/lush.nvim"},
    config = function()
        vim.o.background = "dark"
        require("gruvbox").setup({
            undercurl = true,
            underline = true,
            bold = true,
            italic = true, -- will make italic comments and special strings
            invert_selection = false,
            invert_signs = false,
            invert_tabline = false,
            invert_intend_guides = false,
            contrast = "hard", -- can be "hard" or "soft"
            overrides = {
                Folded = {bg = "#282828"},
                ColorColumn = {bg = "#282828"},
                CursorLine = {bg = "#282828"},
                CursorLineNr = {bg = "#282828"},
                IndentBlanklineContextChar = {fg = "#a89984"},
                Search = {fg = "#fabd2f", bg = "#282828"},
                CurSearch = {bg = "#fabd2f", fg = "#282828"},
                IncSearch = {fg = "#fabd2f", bg = "#282828"},
            },
        })
        vim.cmd("colorscheme gruvbox")
    end,
}

M['jpalardy/vim-slime'] = {
    config = function()
        vim.g.slime_target = "neovim"
        vim.g.slime_python_ipython = 1
        -- vim.g.slime_paste_file = vim.fn.tempname()
        -- vim.g.slime_default_config = {socket_name = "default", target_pane = "{last}"}
    end
}

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

M['nacro90/numb.nvim'] = {
    config = function() require('numb').setup() end,
}

M['ethanholz/nvim-lastplace'] = {
    config = function() require('nvim-lastplace').setup{} end,
}

M["luukvbaal/stabilize.nvim"] = {
    config = function() require("stabilize").setup() end
}

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

M['norcalli/nvim-colorizer.lua'] = {
    config = function() require("colorizer").setup({'*'}, {names=false}) end
}

M["RRethy/vim-illuminate"] = {
    config = function() vim.g.Illuminate_ftblacklist = {'lir'} end
}

M['aserowy/tmux.nvim'] = {
    config = function()
        require("tmux").setup({
            copy_sync = {
                enable = false,
            },
            navigation = {
                enable_default_keybindings = false,
            },
            resize = {
                enable_default_keybindings = false,
                resize_step_x = 8,
                resize_step_y = 8,
            }
        })
    end
}

M["hrsh7th/nvim-cmp"] = {
    requires = {
        "onsails/lspkind-nvim",
        "windwp/nvim-autopairs",
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
        "kdheepak/cmp-latex-symbols",
        "hrsh7th/cmp-nvim-lsp-signature-help",
        "hrsh7th/cmp-cmdline",
        -- "zbirenbaum/copilot-cmp",
    },
    config = function()
        local cmp = require('cmp')
        local lspkind = require('lspkind')
        local autopairs = require('nvim-autopairs')
        local cmp_autopairs = require('nvim-autopairs.completion.cmp')

        local has_words_before = function()
            local line, col = unpack(vim.api.nvim_win_get_cursor(0))
            return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
        end

        vim.opt.completeopt = 'menu,menuone,noselect'

        cmp.setup({
            formatting = {format = lspkind.cmp_format({with_text = true, maxwidth = 50})},
            mapping = {
                ['<Up>'] = cmp.mapping( cmp.mapping.select_prev_item(), {'i', 'c'}),
                ['<Down>'] = cmp.mapping( cmp.mapping.select_next_item(), {'i', 'c'}),
                ['<S-Up>'] = cmp.mapping.scroll_docs(-4),
                ['<S-Down>'] = cmp.mapping.scroll_docs(4),
                ['<Left>'] = cmp.mapping( cmp.mapping.close(), {'i', 'c'}),
                ['<Right>'] = cmp.mapping( cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Insert, select = true}), {'i', 'c'}),
                ["<CR>"] = cmp.mapping.confirm({
                    behavior = cmp.ConfirmBehavior.Insert,
                    select = true,
                }),
                ["<Tab>"] = cmp.mapping(function(fallback)
                    if cmp.visible() then
                        cmp.select_next_item()
                    elseif has_words_before() then
                        cmp.complete()
                    else
                        fallback()
                    end
                end, { "i", "s", "c" }),
                ["<S-Tab>"] = cmp.mapping(function(fallback)
                    if cmp.visible() then
                        cmp.select_prev_item()
                    else
                        fallback()
                    end
                end, { "i", "s", "c" }),
            },
            sources = {
                -- {name = 'copilot'},
                {name = 'nvim_lsp_signature_help'},
                {name = 'nvim_lsp'},
                {name = 'path'},
                {name = 'buffer'},
                {name = 'latex_symbols'},
            },
            experimental = {
                -- native_menu = false,
                ghost_text = true,
            },
        })

        cmp.setup.cmdline(':', {
            sources = {
                { name = 'cmdline' },
            },
        })
        cmp.setup.cmdline('/', {
            sources = {
                { name = 'buffer' },
            },
        })

        -- Set up autopairs
        -- autopairs.setup({})
        -- cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done({map_char = {tex = ''}}))
    end
}

M['lewis6991/gitsigns.nvim'] = {
    requires = {'nvim-lua/plenary.nvim',},
    config = function()
        require('gitsigns').setup({
            signcolumn = false,
            numhl      = true,
            linehl     = false,
            keymaps    = {}, -- Keymaps set in init.lua
            current_line_blame = true,
            preview_config = {
                border = 'none',
                style = 'minimal',
                relative = 'cursor',
            }
        })
    end
}

M['tpope/vim-fugitive'] = {
    requires = 'tpope/vim-rhubarb',
}

M['nvim-lualine/lualine.nvim'] = {
    requires = {
        'kyazdani42/nvim-web-devicons',
        'arkav/lualine-lsp-progress',
    },
    config = function()
        require("lualine").setup({
            options = {
                icons_enabled = true,
                theme = 'gruvbox',
                component_separators = { left = '', right = ''},
                section_separators = { left = '', right = ''},
                disabled_filetypes = {},
                always_divide_middle = true,
                globalstatus = true,
            },
            sections = {
                lualine_a = {'mode'},
                lualine_b = {'branch', 'diff'},
                lualine_c = {'filename', 'lsp_progress'},
                lualine_x = {'filetype'},
                lualine_y = {'location', 'progress'},
                lualine_z = { { 'tabs', mode = 1, } },
            },
            inactive_sections = {
                lualine_a = {},
                lualine_b = {},
                lualine_c = {'filename'},
                lualine_x = {'location'},
                lualine_y = {},
                lualine_z = {}
            },
            tabline = {},
            extensions = {}
        })
    end
}

M['nvim-telescope/telescope-fzf-native.nvim'] = {
    run = 'make'
}

M['nvim-telescope/telescope.nvim'] = {
    requires = {
        'nvim-lua/plenary.nvim',
        'nvim-telescope/telescope-fzf-native.nvim',
        'nvim-telescope/telescope-file-browser.nvim',
    },
    config = function()
        local telescope = require('telescope')
        local actions = require('telescope.actions')

        -- Use <C-q> to send results to qf
        local telescope_mappings = {
            n = {
                ["q"] = actions.close,
            },
            i = {
                ["<esc>"] = actions.close,
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
                    -- theme = "cursor",
                    -- borderchars = { " ", " ", " ", " ", " ", " ", " ", " " },
                    layout_config = {
                        width = 60,
                    },
                    previewer=false,
                    hijack_netrw = true,
                    path = "%:p:h",
                    grouped = true,
                    hidden = true,
                    display_stat = false,
                    file_ignore_patterns = {"%/.git/", "%/__pycache__/"},
                },
            },
            defaults = {
                borderchars = { " ", " ", " ", " ", " ", " ", " ", " " },
                mappings = telescope_mappings,
                file_ignore_patterns = {"%.git/", "%/__pycache__/", "%/data/"},
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

M['lewis6991/spellsitter.nvim'] = {
    -- after = {'nvim-treesitter/nvim-treesitter'},
    config = function() require('spellsitter').setup() end,
}

M['lewis6991/nvim-treesitter-context'] = {
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

M["danymat/neogen"] = {
    requires = "nvim-treesitter/nvim-treesitter",
    config = function() require('neogen').setup({enabled = true}) end,
}

M['neovim/nvim-lspconfig'] = {
    requires = {
        "hrsh7th/cmp-nvim-lsp",
        "williamboman/nvim-lsp-installer",
        "RRethy/vim-illuminate",
        "ii14/lsp-command",
    },
    config = function()
        local lspconfig = require('lspconfig')
        local cmp_nvim_lsp = require('cmp_nvim_lsp')

        -- Configure diagnostics
        vim.diagnostic.config({
            virtual_text = false,
            signs = false,
            underline = true,
            update_in_insert = false,
            severity_sort = false,
        })
        local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
        for type, icon in pairs(signs) do
            local hl = "DiagnosticSign" .. type
            vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
        end

        -- Specify actions to happen when lsp server starts on a buffer
        local on_attach = function(client)
            -- Enable completion triggered by <c-x><c-o>
            vim.api.nvim_buf_set_option(0, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
        end

        -- Get additional capabilities supported by nvim-cmp
        local capabilities = vim.lsp.protocol.make_client_capabilities()
        capabilities = cmp_nvim_lsp.update_capabilities(capabilities)

        local runtime_path = vim.split(package.path, ';')
        table.insert(runtime_path, "lua/?.lua")
        table.insert(runtime_path, "lua/?/init.lua")

        -- Settings
        local settings = {}
        settings["pyright"] = {
            python = {
                analysis = {
                    autoSearchPaths = true,
                    diagnosticMode = "workspace",
                    useLibraryCodeForTypes = true,
                    typeCheckingMode = "basic",
                    diagnosticSeverityOverrides = {
                        reportGeneralTypeIssues = "warning",
                        reportGeneralTypeIssues = "none",
                        reportOptionalMemberAccess = "none",
                        reportOptionalSubscript = "none",
                        reportPrivateImportUsage = "none",
                    },
                },
            },
        }
        settings["sumneko_lua"] = {
            Lua = {
                runtime = {
                    -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
                    version = 'LuaJIT',
                    -- Setup your lua path
                    path = runtime_path,
                },
                diagnostics = {
                    -- Get the language server to recognize the `vim` global
                    globals = {'vim'},
                },
                workspace = {
                    -- Make the server aware of Neovim runtime files
                    library = vim.api.nvim_get_runtime_file("", true),
                },
                -- Do not send telemetry data containing a randomized but unique identifier
                telemetry = {
                    enable = false,
                },
            },
        }

        -- Pass on_attach, capabilities, and settings to servers
        local servers = {
            "pyright",  -- npm i -g pyright
            "julials",  -- julia --project=~/.julia/environments/nvim-lspconfig -e 'using Pkg; Pkg.add("LanguageServer")'
            -- "bashls",
            -- "sumneko_lua",
        }
        for _, lsp in ipairs(servers) do
            lspconfig[lsp].setup({
                on_attach = on_attach,
                capabilities = capabilities,
                handlers = handlers,
                flags = {
                    debounce_text_changes = 150,
                },
                settings = settings[lsp],
            })
        end
    end
}

M['jose-elias-alvarez/null-ls.nvim'] = {
    config = function()
        local null_ls = require("null-ls")
        null_ls.setup({
            sources = {
                -- null_ls.builtins.formatting.yapf,
                null_ls.builtins.formatting.black,
                null_ls.builtins.diagnostics.pylint,
                null_ls.builtins.formatting.jq,
            },
        })
    end,
}

-- Loading status for LSP in bottom right
M['j-hui/fidget.nvim'] = {
    config = function() require('fidget').setup({}) end,
}

-- display diagnostic status in top right
M['Mofiqul/trld.nvim'] = {
    config = function() require('trld').setup {} end,
}
return M
