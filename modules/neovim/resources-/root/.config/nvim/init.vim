if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
  silent !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.local/share/nvim/plugged')

  Plug 'junegunn/vim-plug'         " Installed as a plugin so that it's help can be accessed

  for fpath in glob('~/.config/nvim/*-plugins.vim', 0, 1)
    exe 'source' fpath
  endfor

call plug#end()

for fpath in glob('~/.config/nvim/*-init.vim', 0, 1)
  exe 'source' fpath
endfor