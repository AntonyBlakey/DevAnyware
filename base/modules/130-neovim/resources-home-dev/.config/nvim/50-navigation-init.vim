nmap <leader>-  <Plug>(choosewin)
let g:choosewin_overlay_enable = 1

" And add these extra movement assistants
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

map <leader>b :BufstopFast<CR>
map <leader>a :BufstopModeFast<CR>
let g:BufstopAutoSpeedToggle = 1

tnoremap <C-h> <C-\><C-N><C-w>h
tnoremap <C-j> <C-\><C-N><C-w>j
tnoremap <C-k> <C-\><C-N><C-w>k
tnoremap <C-l> <C-\><C-N><C-w>l

let g:ranger_map_keys = 0
map <leader>r :Ranger<CR>
let g:ranger_replace_netrw = 2

let g:rg_command = 'rg --column --line-number --no-heading --fixed-strings --ignore-case --no-ignore --hidden --follow --color "always" -g "!{.git,node_modules,vendor}/*"'
command! -bang -nargs=* F call fzf#vim#grep(g:rg_command .shellescape(<q-args>), 1, <bang>0)