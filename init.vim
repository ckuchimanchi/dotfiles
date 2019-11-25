" use the same Python 3 as python3-nvim
let g:python3_host_prog='/usr/bin/python3'
" same for Python 2
let g:python_host_prog='/usr/bin/python2'


"using in parallel with vim
"
set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath
source ~/.vimrc
