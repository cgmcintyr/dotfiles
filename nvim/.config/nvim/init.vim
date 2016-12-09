" NOT COMPATIBLE TO LEGACY VI VERSIONS
set nocompatible


"==============================Plugin List==================================="

filetype off
call plug#begin('~/.vim/plugged')

" Git interface
Plug 'tpope/vim-fugitive'

" File system navigation
Plug 'scrooloose/nerdtree'
Plug 'jistr/vim-nerdtree-tabs'

" Easy commenting
Plug 'scrooloose/nerdcommenter'

" Fuzzy search
Plug 'kien/ctrlp.vim'
Plug 'Lokaltog/vim-easymotion'

" Smooth scroll
Plug 'terryma/vim-smooth-scroll'

" Auto completion
Plug 'ervandew/supertab'

" Multiple cursor
Plug 'terryma/vim-multiple-cursors'

" Visual moves
Plug 'kuc2477/vim-move'

" Surround
Plug 'tpope/vim-surround'

" Colorschemes
Plug 'flazz/vim-colorschemes'

call plug#end()
filetype plugin indent on


"=============================Plugin Settings================================="

"THE-NERD-TREE
let g:nerdtree_tabs_open_on_console_startup = 0
let g:nerdtree_tabs_autoclose = 1
let g:NERDTreeDirArrows = 0
map <C-u> :NERDTreeTabsToggle<CR>

"EASY-MOTION
let g:EasyMotion_smartcase = 1
nmap <C-f> <Plug>(easymotion-sn)

"VIM-SMOOTH-SCROLL
noremap <silent> gk :call smooth_scroll#up(&scroll, 0, 6)<CR>
noremap <silent> gj :call smooth_scroll#down(&scroll, 0, 6)<CR>

"VIM-MOVE
let g:move_key_modifier = 'C'

"CTRLP
let g:ctrlp_cmd = 'CtrlPMixed'
let g:ctrlp_working_path_mode = 0


"============================General Settings================================"

" Default colorscheme
set background=dark
"colorscheme wombat256mod
colorscheme jellybeans
syntax on

" Default encoding - change default encoding as you want
set enc=utf-8

" Terminal
"if has('gui_running')
"else
"    set term=xterm-256color
"    if &term =~ '256color'
"        " disable Background Color Erase (BCE) so that color schemes
"        " render properly when inside 256-color tmux and GNU screen.
"        " see also http://snk.tuxfamily.org/log/vim-256color-bce.html
"        set t_ut=
"    endif
"endif

" Font
if has('gui_running')
    if has('gui_gtk2')
        set guifont=Inconsolata
    elseif has ('gui_macvim')
        set guifont=Menlo
    elseif has('gui_win32')
        set guifont=Consolas
    endif
endif

" Keystroke timeout
set timeoutlen=200
au InsertEnter * set timeoutlen=90
au InsertLeave * set timeoutlen=200

" Indentations to fallback
set expandtab
set smarttab
set smartindent
set shiftwidth=4
set tabstop=4

" Search behaviour
set hlsearch
set incsearch
set magic

" UI
set nu
set colorcolumn=79
highlight ColorColumn ctermbg=235

" Don't have to press shift when typing commands
map ; :

" Don't make your finger busy
inoremap jk <ESC>
vnoremap jk <ESC>

" Split navigation
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l

" Key mappings
map <F9> :tabnew<CR>
map <F10> :tabclose<CR>
nnoremap <tab> :tabnext<CR>
nnoremap <S-tab> :tabprevious<CR>
nnoremap - :vertical res -10<CR>
nnoremap = :vertical res +10<CR>
nnoremap <leader>- :res -20<CR>
nnoremap <leader>= :res +20<CR>

" Lang specific indentations
au FileType sh setl ts=2 sw=2 sts=2
au FileType bash setl ts=2 sw=2 sts=2
au FileType haskell setl sw=2
au FileType javascript setl ts=2 sw=2 sts=2
au FileType html setl ts=2 sw=2 sts=2
au FileType css setl ts=2 sw=2 sts=2
au FileType scss setl ts=2 sw=2 sts=2
au FileType sass setl ts=2 sw=2 sts=2
au FileType less setl ts=2 sw=2 sts=2

" Filetype miscs
au! BufRead,BufNewFile *.wsgi setfiletype python
au! BufRead,BufNewFile *.less setfiletype less
