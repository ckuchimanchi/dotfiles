set number
set ignorecase
set smartcase
set hidden
set history=10000
set showmatch
set incsearch
set mouse=a

"Create directory if it doesnt exist
"ToDO: Change it to one variable reference
silent !mkdir -p $HOME/.vim/undo
set undodir=$HOME/.vim/undo 
set undofile

set backspace=indent,eol,start
set splitright

filetype plugin indent on
syntax on

if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  "Note: This would install all plugins and source vimrc again 
  "on opening vim for first time when plug.vim was not found 
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/pack/bundle/start')

Plug 'https://github.com/tpope/vim-unimpaired'
Plug 'https://github.com/tpope/vim-repeat'
Plug 'https://github.com/tpope/vim-surround'
Plug 'https://github.com/tpope/vim-commentary'
Plug 'https://github.com/tpope/vim-characterize'
Plug 'https://github.com/hhvm/vim-hack'
Plug 'https://github.com/junegunn/fzf',{'dir': '~/.fzf' , 'do': './install --all'}
Plug 'https://github.com/junegunn/fzf.vim'
Plug 'https://github.com/sjl/gundo.vim'
Plug 'https://github.com/vim-airline/vim-airline'
Plug 'https://github.com/godlygeek/tabular'
Plug 'https://github.com/MaxMEllon/vim-jsx-pretty'
Plug 'https://github.com/dense-analysis/ale' 
Plug 'https://github.com/machakann/vim-highlightedyank'
Plug 'https://github.com/honza/vim-snippets'
Plug 'https://github.com/SirVer/ultisnips'
" Plug 'https://github.com/prettier/vim-prettier'
Plug 'https://github.com/luochen1990/rainbow'
Plug 'https://github.com/tpope/vim-fugitive'
Plug 'https://github.com/justone/remotecopy', {'dir': '~/.remotecopy', 'rtp' : 'vim'}

" Initialize plugin system
call plug#end()

"custom mappings
let mapleader = " "

"insert mode mappings
inoremap jk <Esc>

"normal mode mappings

"windows movement
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-H> <C-W><C-H>
nnoremap <C-L> <C-W><C-L>

nnoremap <leader>w :write<cr>
nnoremap <leader>v :edit $MYVIMRC<CR>
nnoremap <leader>z :edit ~/.zshrc<CR>
nnoremap <silent> <leader>sv :source $MYVIMRC<CR>

cnoremap %% <C-R>=expand('%:h').'/'<CR>
map <leader>ew :e %%
map <leader>es :sp %%
map <leader>ev :vsp %%
map <leader>et :tabe %%

nnoremap <leader>h :set hlsearch!<cr>
" Easy quickfix navigation
nnoremap <C-n> :cn<CR>
"conflicts with next p -- what to do? :) 
nnoremap <C-p> :cp<CR>

nnoremap <C-p> :<C-u>FZF<cr>

"Search with Rg - project wide grep
"intentionally left out <cr>/enter to review what is being searched
nnoremap <leader>* :Rg <c-r><c-w> 
vnoremap <leader>* y:<c-u>Rg <c-r>"

"remote copy shortcut
noremap <silent> cy :silent RemoteCopy<CR>
vnoremap <silent> cy :<C-u>silent RemoteCopyVisual<CR>
"not sure how to use this yet, so commenting
" noremap cyr :RemoteCopyRegister<CR>

nnoremap <leader>o :Buffers<cr>

"LSP shortcuts
"IMPORTANT: HOW TO MAP IT ONLY IN CASE OF ALE BEING ENABLED and for that
"buffer (using events)
nnoremap <silent> gd :ALEGoToDefinitionInVSplit<cr>
nnoremap <silent> gd :ALEGoToDefinition<cr>
nnoremap <silent> <M-LeftMouse> <LeftMouse>:ALEGoToDefinition<CR>
nnoremap <silent> grf :ALEFindReferences<cr>
nnoremap <silent> gtd :ALEGoToTypeDefinitionInVSplit<cr>
nmap <silent> [g <Plug>(ale_previous_wrap)
nmap <silent> ]g <Plug>(ale_next_wrap)


"command line mappings
cnoremap <C-A> <Home>
cnoremap <C-B> <Left>
cnoremap <C-F> <Right>

set wildignorecase
set wildmode=longest,list

" no mapping yet for :ALEDetail
let g:ale_completion_enabled=1
let g:ale_fix_on_save=0
let g:ale_lint_on_save=1
nnoremap <M-LeftMouse> <LeftMouse>:ALEGoToDefinition<CR>
let g:ale_echo_msg_format = '[%linter%]% [code]% %s'
" Press `K` to view the type in the gutter
nnoremap <silent> K :ALEHover<CR>
if has('balloon_eval_term')
	set balloonevalterm
	let g:ale_set_balloons=1
	let balloondelay = 250
endif

"Ultisnips
let g:UltiSnipsSnippetsDir='~/.snippets'
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<s-tab>"

set suffixesadd+=.js

if filereadable(glob("~/.vimrc.local"))
    source ~/.vimrc.local
endif
