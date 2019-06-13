" set termguicolors
colorscheme night-owl
let g:airline_theme = 'light'

set noshowmode
set laststatus=2
set showtabline=2

set signcolumn=yes

" set number relativenumber
set number
" augroup numbertoggle
"   autocmd!
"   autocmd BufEnter,FocusGained,InsertLeave * if &filetype !=# 'help' | set relativenumber
"   autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
" augroup END

let g:rainbow_active = 1