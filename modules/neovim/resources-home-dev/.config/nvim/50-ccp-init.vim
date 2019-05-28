set clipboard=unnamed,unnamedplus

" Movement of text i.e. cut
nnoremap m d
xnoremap m d
nnoremap mm dd
nnoremap M D

" Substitute - like a select then paste
nmap s <plug>(SubversiveSubstitute)
nmap ss <plug>(SubversiveSubstituteLine)
nmap S <plug>(SubversiveSubstituteToEndOfLine)

" Taking two motions - first the unit to replace, then the line range
nmap <leader>s <plug>(SubversiveSubstituteRange)
xmap <leader>s <plug>(SubversiveSubstituteRange)
nmap <leader>ss <plug>(SubversiveSubstituteWordRange)

" Using Abolish, to preserve case when substituting
nmap <leader><leader>s <plug>(SubversiveSubvertRange)
xmap <leader><leader>s <plug>(SubversiveSubvertRange)
nmap <leader><leader>ss <plug>(SubversiveSubvertWordRange)

" Substitute/Paste, but allowing repeated p to cycle the paste ring
xmap s <plug>(SubversiveSubstitute)
xmap p <plug>(SubversiveSubstitute)
xmap P <plug>(SubversiveSubstitute)

" c-n and c-p will move back and forwards in the past ring
nmap <C-n> <plug>(YoinkPostPasteSwapBack)
nmap <C-p> <plug>(YoinkPostPasteSwapForward)
nmap p <plug>(YoinkPaste_p)
nmap P <plug>(YoinkPaste_P)

nmap <C-=> <plug>(YoinkPostPasteToggleFormat)

let g:yoinkIncludeDeleteOperations = 1
let g:yoinkSavePersistently = 1