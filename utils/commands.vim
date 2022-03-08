
" Edit settings
command! Settings edit $MYVIMRC | lcd %:p:h | echo 'Editing settings: ' . expand('%')

" Trim trailing spaces without upsetting changelist
command! TrimSpaces let g:tmp = winsaveview() | keeppatterns %s/\s\+$//e | call winrestview(g:tmp)

" Toggle display of quickfix/location list
command! ToggleQL exec empty(filter(getwininfo(), 'v:val.quickfix')) ? "copen" : "cclose"
command! ToggleLL exec empty(filter(getwininfo(), 'v:val.loclist')) ? "lopen" : "lclose"

" Open notes buffer
command! Notes split ~/Dropbox/Journals | silent lcd %:p:h | echo 'Opening notes: ' . expand('%')
command! -nargs=? Note lua NewNote(<f-args>)

" Debug syntax highlights
function! ShowSyntaxGroup()
    let l:s = synID(line('.'), col('.'), 1)
    echo synIDattr(l:s, 'name') . ' -> ' . synIDattr(synIDtrans(l:s), 'name')
    echo 'TRACE'
endfun
command! Syn call ShowSyntaxGroup()

" Debug long vimscript file
function! DebugScript(script)
    redir @a
        exec printf('silent %s', script)
    redir END
    tabnew
    norm "ap
endfun
command! -nargs=1 DebugScript call DebugScript(<args>)

" Typos
command! -bang -nargs=* -complete=file E e<bang> <args>
command! -bang -nargs=* -complete=file W w<bang> <args>
command! -bang -nargs=* -complete=file Wq wq<bang> <args>
command! -bang -nargs=* -complete=file WQ wq<bang> <args>
command! -bang -nargs=* Wa wa<bang> <args>
command! -bang -nargs=* WA wa<bang> <args>
command! -bang -nargs=* Q q<bang> <args>
command! -bang -nargs=* Qa qa<bang> <args>
command! -bang -nargs=* QA qa<bang> <args>
