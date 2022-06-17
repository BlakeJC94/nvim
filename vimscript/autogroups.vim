
augroup base
    autocmd!
    " equally resize windows when terminal is resized
    autocmd VimResized * wincmd =
    " replace tabs with spaces
    autocmd BufWritePre * retab
    " autoremove whitespace
    autocmd BufWritePre * TrimSpaces
    " create nested directories if needed when creating files
    autocmd BufWritePre,FileWritePre * silent! call mkdir(expand('<afile>:p:h'), 'p')
    " Auto instert mode when entering terminal mode
    autocmd WinEnter term://* startinsert
augroup END

augroup style
    autocmd!
    " toggle cursorline and colorcolumn when entering/exiting insert mode
    autocmd InsertEnter * setl cursorline nornu cc=100,101
    autocmd InsertLeave * setl nocursorline rnu cc=
    " toggle numbers when entering/exiting terminal mode
    " autocmd TermEnter * setl nornu nonu
    " autocmd TermLeave * setl rnu nu
    " echo a vimtip when opening vim
    autocmd VimEnter * VimTip
    " highlight yanked regions
    autocmd TextYankPost * silent! lua require'vim.highlight'.on_yank({timeout = 700})
augroup END

augroup ft_extra
    autocmd!
    " Make cmdwindows close with q
    autocmd CmdwinEnter * nnoremap <buffer> q :q<CR>
    autocmd CmdwinEnter * luaeval("require('cmp').setup.buffer({enabled = false})")
    " help/cmd win/qf list: Press q to close and disable spellcheck
    autocmd FileType qf,help,fugitive nnoremap <buffer> q :q<CR>
    autocmd FileType qf,help,fugitive setlocal nospell
    autocmd FileType qf,help,fugitive setlocal colorcolumn=
    " restore default K action on help pages
    autocmd FileType vim,help nnoremap <buffer> K :h <C-r>=expand('<cword>')<CR><CR>
    " Always open help in vertical split
    autocmd FileType help wincmd L | vert resize 90
    autocmd FileType help setl fo-=t
    " Set pandoc as makeprg for markdown files
    autocmd FileType Markdown set makeprg=pandoc\\ %:p\\ -o\\ %:p:h/out.pdf"
augroup END
