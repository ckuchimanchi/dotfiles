set relativenumber
set number
set ignorecase
set smartcase
set hidden
set history=10000
set showmatch
set incsearch
set mouse=a

" set t_Co=256
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
Plug 'https://github.com/luochen1990/rainbow'
Plug 'https://github.com/tpope/vim-fugitive'
Plug 'https://github.com/justone/remotecopy', {'dir': '~/.remotecopy', 'rtp' : 'vim'}
Plug 'https://github.com/tpope/vim-obsession'
Plug 'ayu-theme/ayu-vim' 
Plug 'reasonml-editor/vim-reason-plus'
Plug 'wellle/targets.vim'
" packadd vim-Hg


" Initialize plugin system
call plug#end()

set termguicolors     " enable true colors support
" let ayucolor="light"  " for light version of theme
" let ayucolor="mirage" " for mirage version of theme
let ayucolor="dark"   " for dark version of theme
colorscheme ayu

"custom mappings
let mapleader = " "

"insert mode mappings
inoremap jk <Esc>

"terminal: I often go from open buffers list to ctrl- ;)
""but this is not working for fzf buffer list. :( i mean it's not focused and
" is in escape mode. so will check later
tnoremap <C-p> <C-\><C-N>:q<cr>:FZF<cr>
tnoremap <Esc> <C-\><C-n>

"normal mode mappings

"windows movement
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-H> <C-W><C-H>
nnoremap <C-L> <C-W><C-L>

nnoremap <silent> <leader>w :write<cr>
nnoremap <silent> <leader>v :edit ~/.vimrc<CR>
nnoremap <silent> <leader>z :edit ~/.zshrc<CR>
nnoremap <silent> <leader>sv :source ~/.vimrc<CR>
nnoremap <silent> <leader>d :bdelete<cr>
nnoremap <silent> <leader>q :quit<cr>
nnoremap <silent> <leader>c :cclose<cr>
nnoremap <silent> <leader>t :split <Bar> terminal<cr>


cnoremap %% <C-R>=expand('%:h').'/'<CR>
map <leader>ew :e %%
map <leader>es :sp %%
map <leader>ev :vsp %%
map <leader>et :tabe %%

nnoremap <leader>h :set hlsearch!<cr>

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
"
" copy file name
nnoremap <silent> yf :silent :let @"=expand("%:t:r")<cr>
nnoremap <silent> pf :silent :let @"=expand("%:t:r") <Bar> :normal p <cr>

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

set completeopt+=noinsert "to prevent ale bug "https://github.com/dense-analysis/ale/issues/1700


"Mouse mappings" -- useful when I have to go back after digging through go to
"definitions in different files
map <M-ScrollWheelUp> :bprev <cr>
map <M-ScrollWheelDown> :bnext <cr>

"key mappings
"not sure why they are not working in nvim (research later :-()
if !has('nvim')
set <M-b>=b
set <M-f>=f 
endif

"command line mappings

  " bash like mappings for command line
  cnoremap <C-A> <Home>
  cnoremap <C-B> <Left>
  cnoremap <C-F> <Right>
  cnoremap <M-b> <C-Left>
  cnoremap <M-f> <C-Right>


"custom commands
command! Rtp echo join(split(&rtp,","),"\n")

set wildignorecase
set wildmode=longest,list

" no mapping yet for :ALEDetail
let g:ale_completion_enabled=1
let g:ale_fix_on_save=1
let g:ale_lint_on_save=1
nnoremap <M-LeftMouse> <LeftMouse>:ALEGoToDefinition<CR>
let g:ale_echo_msg_format = '[%linter%]% [code]% %s'
" Press `K` to view the type in the gutter
nnoremap <silent> K :ALEHover<CR>
let g:ale_set_balloons=1
if has('balloon_eval_term')
	set balloonevalterm
	let balloondelay = 250
endif

"Ultisnips
let g:UltiSnipsSnippetDirectories=[$HOME.'/.vim/UltiSnips']
let g:UltiSnipsExpandTrigger="<tab>"
" let g:UltiSnipsJumpForwardTrigger="<C-n>"
" let g:UltiSnipsJumpBackwardTrigger="<C-p>"
let g:UltiSnipsEditSplit="context"
au VimEnter * au! UltiSnips_AutoTrigger


set suffixesadd+=.js

if filereadable(glob("~/.vimrc.local"))
    source ~/.vimrc.local
endif  


"temp
"for stylex
""q   cwstyles.^[lds(ds'df/
