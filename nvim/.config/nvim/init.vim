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
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'zchee/deoplete-jedi'

" Multiple cursor
Plug 'terryma/vim-multiple-cursors'

" Visual moves
Plug 'kuc2477/vim-move'

" Surround
Plug 'tpope/vim-surround'

" Colorschemes
Plug 'flazz/vim-colorschemes'

" Ansible support
Plug 'chase/vim-ansible-yaml'

" Ruby
Plug 'vim-ruby/vim-ruby'

" Vue.js syntax
Plug 'posva/vim-vue'

" Latex
Plug 'lervag/vimtex'

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

"DEOPLETE
let g:deoplete#enable_at_startup = 1
if !exists('g:deoplete#omni#input_patterns')
  let g:deoplete#omni#input_patterns = {}
endif
" let g:deoplete#disable_auto_complete = 1
autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif
inoremap <expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"

"DEOPLETE-JEDI
let g:deoplete#sources#jedi#python_path = $HOME.'/.virtualenvs/NVIM3/bin/python3'

"============================General Settings================================"

" Default colorscheme
set background=dark
"colorscheme wombat256mod
colorscheme jellybeans
syntax on

" Python
let g:python_host_prog = $HOME.'/.virtualenvs/NVIM/bin/python2'
let g:python3_host_prog = $HOME.'/.virtualenvs/NVIM3/bin/python3'

" Default encoding - change default encoding as you want
set enc=utf-8

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

set list!
if has('gui_running')
    set listchars=tab:▶\ ,trail:·,extends:\#,nbsp:.
else
    set listchars=tab:>.,trail:.,extends:\#,nbsp:.
endif
hi SpecialKey ctermfg=66 guifg=#649A9A

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
cmap w!! w !sudo tee > /dev/null %
cabbrev w!! w !sudo tee > /dev/null %
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
au! BufRead,BufNewFile *.less setfiletype less

