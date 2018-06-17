" NOT COMPATIBLE TO LEGACY VI VERSIONS
set nocompatible

"==============================Plugin List==================================="

filetype off
call plug#begin('~/.vim/plugged')

" Elixir
Plug 'slashmili/alchemist.vim'
Plug 'elixir-editors/vim-elixir'

" File system navigation
Plug 'scrooloose/nerdtree'
Plug 'jistr/vim-nerdtree-tabs'

" Auto completion
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }

" Python
Plug 'zchee/deoplete-jedi'

" Ansible support
Plug 'chase/vim-ansible-yaml'

" Vue.js syntax
Plug 'posva/vim-vue'

" Latex
Plug 'lervag/vimtex'

" Javascript
Plug 'pangloss/vim-javascript'
Plug 'posva/vim-vue'

" Elm
Plug 'ElmCast/elm-vim'

call plug#end()
filetype plugin indent on

"=============================Plugin Settings================================"

"THE-NERD-TREE
let g:nerdtree_tabs_open_on_console_startup = 0
let g:nerdtree_tabs_autoclose = 1
let g:NERDTreeDirArrows = 0
map <C-u> :NERDTreeTabsToggle<CR>

"DEOPLETE
let g:deoplete#enable_at_startup = 1
if !exists('g:deoplete#omni#input_patterns')
  let g:deoplete#omni#input_patterns = {}
endif
let g:deoplete#disable_auto_complete = 0
autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif
inoremap <expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"

"DEOPLETE-JEDI
let g:deoplete#sources#jedi#python_path = $HOME.'/.virtualenvs/NVIM3/bin/python3'

" Vimtex
let g:vimtex_view_general_viewer = 'okular'
let g:vimtex_view_general_options = '--unique file:@pdf\#src:@line@tex'
let g:vimtex_view_general_options_latexmk = '--unique'


"============================General Settings================================"

" Colors
syntax on
hi Visual ctermbg=7 ctermfg=0
hi Pmenu ctermfg=7 ctermbg=4
hi SpecialKey ctermfg=66

hi clear SpellBad
hi SpellBad cterm=underline ctermbg=7 ctermfg=0

" UI
set nu
set list!
if has('gui_running')
    set listchars=tab:▶\ ,trail:·,extends:\#,nbsp:.
else
    set listchars=tab:>.,trail:·,extends:\#,nbsp:.
endif

" Python
let g:python_host_prog = $HOME.'/.virtualenvs/NVIM/bin/python2'
let g:python3_host_prog = $HOME.'/.virtualenvs/NVIM3/bin/python3'

" Default encoding
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

" Reverse selection
vnoremap ;rv c<C-O>:set revins<CR><C-R>"<Esc>:set norevins<CR>

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

" Copy to clipboard
vnoremap  <leader>y  "+y
nnoremap  <leader>Y  "+yg_
nnoremap  <leader>y  "+y
nnoremap  <leader>yy  "+yy

" Paste from clipboard
nnoremap <leader>p "+p
nnoremap <leader>P "+P
vnoremap <leader>p "+p
vnoremap <leader>P "+P

" Elixir auto format
autocmd BufWritePost *.exs silent :!mix format %
autocmd BufWritePost *.ex silent :!mix format %

" Spell check
imap <Leader>s <C-o>:setlocal spell spelllang=en_gb<CR>
nmap <Leader>s :setlocal spell spelllang=en_gb<CR>
