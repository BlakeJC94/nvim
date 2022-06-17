
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

" Push/pull changes to config
command! ConfigPush exec "!(cd ~/.dots && git add .config/nvim/. && git commit -m 'updated nvim' && git push)"
command! ConfigPull exec "!(cd ~/.dots && git pull)"

" vim tips
function! VimTip()
    if !exists('g:vimtip')
        let g:vimtip = system('fortune ~/.config/nvim/extras/vim-tips')
        let @v = g:vimtip
    echo g:vimtip
    else
        put =g:vimtip
    endif
endfun
command! VimTip call VimTip()

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

" LSP commands
" command! LspReferences lua vim.lsp.buf.references()
" command! LspSignature lua vim.lsp.buf.signature_help()
" command! LspCodeAction lua vim.lsp.buf.code_action()
" command! LspFormat lua vim.lsp.buf.formatting()
" command! LspLineDiagnostics lua vim.lsp.diagnostic.show_line_diagnostics()
" command! LspIncomingCalls lua vim.lsp.buf.incoming_calls()
" command! LspOutgoingCalls lua vim.lsp.buf.outgoing_calls()
" command! LspListWorkspaceFolders lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
" command! LspDocumentSymbol lua vim.lsp.buf.document_symbol()
" command! LspDefinition lua vim.lsp.buf.definition()
" command! LspTypeDefinition lua vim.lsp.buf.type_definition()
" command! LspDeclaration lua vim.lsp.buf.declaration()
" command! LspImplementation lua vim.lsp.buf.implementation()
" command! LspRename lua vim.lsp.buf.rename()
" command! -nargs=? LspWorkspaceSymbol lua vim.lsp.buf.workspace_symbol(<f-args>)
" command! -nargs=? -complete=dir LspAddWorkspaceFolder lua vim.lsp.buf.add_workspace_folder(<f-args>)
" command! -nargs=? -complete=dir LspRemoveWorkspaceFolder lua vim.lsp.buf.remove_workspace_folder(<f-args>)
