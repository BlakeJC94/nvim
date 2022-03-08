LEADER = {
    [''] = {
        ['<Leader><CR>']     = ":Lir<CR>",                   -- File explorer TODO telescope?
        ['<Leader><BS>']     = ":Telescope find_files<CR>",  -- File finder
        ['<Leader><Tab>']    = "<C-^>",                      -- Last file
        ['<Leader><Esc>']    = ":q<CR>",                     -- Quit
        ['<Leader><Leader>'] = ":Telescope buffers<CR>",     -- Buffers
        ['<Leader>n'] = ":enew | echo '[New file]'<CR>",
        ['<Leader>N'] = ":bufdo bdel | enew | echo '[New session]'<CR>",
        ['<Leader>d'] = ":lcd %:p:h | echo 'Changed local dir to ' . getcwd()<CR>",
        ['<Leader>D'] = ":cd %:p:h | echo 'Changed dir to ' . getcwd()<CR>",
        ['<Leader>q'] = ":ToggleQL<CR>",               -- Toggle qflist
        ['<Leader>l'] = ":ToggleLL<CR>",               -- Toggle loclist
        ['<Leader>;'] = ":Settings<CR>",               -- Edit settings
        ['<Leader>:'] = ":luafile $MYVIMRC<CR>",       -- Reload settings
        ['<Leader>z'] = ":Twilight<CR>",               -- Toggle FocusMode
        ['<Leader>Z'] = ":ZenMode<CR>",                -- Toggle ZenMode
        ['<Leader>A'] = ":Neogen<CR>",                 -- Generate docs
        ['<Leader>u'] = ":UndotreeToggle<CR>",         -- Toggle undotree
    },
}

return LEADER
