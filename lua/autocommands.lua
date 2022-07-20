M = {}
FUNCTIONS = require('functions')

M.BASE = {
    -- resize vim splits
    {
        events = {"VimResized"},
        pattern = {"*"},
        callback = function() vim.cmd("wincmd =") end,
    },
    -- replace tabs with spaces
    {
        events = {"BufWritePre"},
        pattern = "*",
        callback = function() vim.cmd("retab") end,
    },
    -- autoremove whitespace
    {
        events = {"BufWritePre"},
        pattern = "*",
        callback = FUNCTIONS.TrimSpaces,
    },
    -- make new dirs on save
    {
        events = {"BufWritePre", "FileWritePre"},
        pattern = "*",
        callback = FUNCTIONS.CreateDirs,
    },
}

M.STYLE = {
    -- toggle on insert colorcol cursorline
    {
        events = {"InsertEnter"},
        pattern = "*",
        callback = function()
            vim.opt_local.relativenumber = false
            vim.opt_local.colorcolumn = {100, 101}
        end
    },
    -- toggle off insert colorcol cursorline
    {
        events = {"InsertLeave"},
        pattern = "*",
        callback = function()
            vim.opt_local.cursorline = false
            vim.opt_local.relativenumber = true
            vim.opt_local.colorcolumn = {}
        end
    },
    -- echo vimtip on open
    {
        events = {"VimEnter"},
        callback = FUNCTIONS.VimTip,
        pattern = "*",
    },
    -- highlight yanks
    {
        events = {"TextYankPost"},
        pattern = "*",
        callback = function() vim.highlight.on_yank({timeout = 700}) end,
    },
}

M.FT_EXTRA = {
    -- close cmdwin with q
    {
        events = {"CmdWinEnter"},
        pattern = "*",
        callback = function()
            FUNCTIONS.SetQuitWithQ()
            require('cmp').setup.buffer({enabled = false})
        end,
    },
    -- set info buffer opts
    {
        events = {"FileType"},
        pattern = {"qf", "help", "fugitive"},
        callback = function()
            FUNCTIONS.SetQuitWithQ()
            vim.opt_local.spell = false
            vim.opt_local.colorcolumn = {}
            -- restore default K action on help pages
            vim.keymap.set('n', 'K', ":h <C-r>=expand('<cword>')<CR><CR>", {silent=true, buffer=true})
        end,
    },
    -- help vert split
    {
        events = {"FileType"},
        pattern = "help",
        callback = function()
            vim.cmd('wincmd L')
            vim.cmd('vert resize 90')
            vim.opt_local.formatoptions:remove('t')
        end,
    },
    -- md makeprg pandoc
    {
        events = {"FileType"},
        pattern = "Markdown",
        callback = function()
            vim.opt_local.makeprg = "pandoc %:p -o %:p:h/out.pdf"
        end,
    },
}

-- TODO update these targets after refactor
-- M.PACKER_COMPILE = {
--     -- compile on plugins lua write
--     {
--         events = {"BufWritePost"},
--         pattern = "plugins.lua",
--         callback = function(keys) vim.cmd('source ' .. keys.file .. ' | PackerCompile') end
--     },
--     -- compile on configs lua write
--     {
--         events = {"BufWritePost"},
--         pattern = "configs.lua",
--         callback = function(keys) vim.cmd('source ' .. keys.file .. ' | PackerCompile') end
--     },
-- }

return M
