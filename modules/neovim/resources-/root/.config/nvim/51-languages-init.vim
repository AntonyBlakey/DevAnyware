let g:airline#extensions#ale#enabled = 1
let g:ale_linters = {}

set completeopt=noinsert,menuone,noselect

autocmd BufEnter * call ncm2#enable_for_buffer()

let g:LanguageClient_serverCommands = {}
let g:LanguageClient_hasSnippetSupport = 0

nn <silent> xd :call LanguageClient#textDocument_definition()<cr>
nn <silent> xr :call LanguageClient#textDocument_references({'includeDeclaration': v:false})<cr>
nn <silent> xh :call LanguageClient#textDocument_hover()<cr>