TODO investigate fugitive mappings
TODO write a readme for nvim repo

# RETIRED AUTOGROUPS
```
local term_cmds = {
    name='term_cmds',
    cmds= {
        ['term://*'] = {
            -- Bypass normal mode when changing focus to terminal buffer
            {events='BufWinEnter,WinEnter', cmd='startinsert'},
            -- Disable numbers and spelling in terminals
            {events='TermOpen', cmd='setlocal nonu nornu nospell'},
            -- Immediately close terminal window when process finishes
            {events='TermClose', cmd='quit'},
        }
    }
}
local cursorline_on_active_buffer = {
    name='cursorline_on_active_buffer',
    cmds={
        ['*'] = {
            {events='VimEnter,WinEnter,BufWinEnter,Focusgained', cmd="setlocal cursorline"},
            {events='WinLeave,FocusLost', cmd="setlocal nocursorline"},
        },
        ['term://*'] = {
            {events='VimEnter,WinEnter,BufWinEnter,Focusgained', cmd="setl nocursorline"},
        }
    }
}
```

# OTHER NOTES
```
Changing the cursor in regular vim?
:let &t_EI = "\e[0 q"  " Block cursor in normal mode
:let &t_SI = "\e[5 q"  " Bar cursor on insert mode
" Set bar cursor on command-line mode
:autocmd CmdLineEnter * exec 'silent !echo -ne "' . &t_SI . '"'
:autocmd CmdLineLeave * exec 'silent !echo -ne "' . &t_EI . '"'
" Set block curor on start or resume
:autocmd VimEnter * exec 'silent !echo -ne "' . &t_EI . '"'
:autocmd VimResume * exec 'silent !echo -ne "' . &t_EI . '"'
```

