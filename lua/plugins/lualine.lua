M = {}

-- Better statusline
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
            },
            sections = {
                lualine_a = {'mode'},
                lualine_b = {'branch', 'diff'},
                lualine_c = {'filename', 'lsp_progress'},
                lualine_x = {'filetype'},
                lualine_y = {'location', 'progress'},
                lualine_z = {'tabs'},
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

return M
