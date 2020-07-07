" === Plugins ====================================================== "
call plug#begin($HOME . '/.local/share/nvim/plugged/')
	" Display
	Plug 'flazz/vim-colorschemes'
	Plug 'xolox/vim-misc'
	Plug 'xolox/vim-colorscheme-switcher'
	" Completions
	Plug 'neoclide/coc.nvim', {'branch': 'release'}
	" Linting
	Plug 'dense-analysis/ale'
	" Snippets
	Plug 'SirVer/ultisnips'
	Plug 'honza/vim-snippets'
	" Latex
	Plug 'lervag/vimtex'
	" Elixir
	Plug 'elixir-editors/vim-elixir'
	" Python
	Plug 'tmhedberg/SimpylFold'
	" Writing
	Plug 'reedes/vim-pencil'
	" Coerce to camelcase
	Plug 'tpope/vim-abolish'
	" Golang
	Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
	" Markdown
	Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app & yarn install'  }
	" Ruby
	Plug 'tpope/vim-rails'
	Plug 'tpope/vim-haml'
	" JS
	Plug 'pangloss/vim-javascript'
call plug#end()

function! _PlugLoaded(name)
	"""Return 1 if name is an installed plugin else 0"""
	return (
		\ has_key(g:plugs, a:name) &&
		\ isdirectory(g:plugs[a:name].dir) &&
		\ stridx(&rtp, g:plugs[a:name].dir) >= 0)
endfunction


" == Tabbing ======================================================= "

" Defaults
set shiftwidth=4
set softtabstop=4
set expandtab
set smarttab
set cindent

function TabToggle()
	"""Toggle between tab and space indentation"""
	if &expandtab
		set shiftwidth=8
		set softtabstop=0
		set noexpandtab
	else
		set shiftwidth=4
		set softtabstop=4
		set expandtab
	endif
endfunction
nnoremap <F9> mz:execute TabToggle()<CR>'z

" Tabs not spaces
autocmd Filetype golang setlocal noexpandtab tabstop=4 softtabstop=4 shiftwidth=4
autocmd Filetype vim setlocal noexpandtab tabstop=4 softtabstop=4 shiftwidth=4


" === UI Settings ================================================== "

colorscheme monochrome
" Show line numbers
set number
" Wrap lines
set wrap
" Visible whitespace
set listchars=tab:>.,trail:·,extends:\#,nbsp:.
set list
" Better display for messages
set cmdheight=2
" Show sign column when errors/notfications exist
set signcolumn=auto



" === Folding ====================================================== "

set foldlevel=1
set foldlevelstart=1
set foldnestmax=1
set foldmethod=syntax
augroup foldingbyfiletype
        autocmd!
        autocmd FileType elixir setlocal foldlevel=0 foldlevelstart=0 foldnestmax=1
        autocmd FileType python setlocal foldlevel=0 foldlevelstart=0 foldnestmax=10
        autocmd FileType go setlocal foldlevel=1 foldlevelstart=1 foldnestmax=2
augroup END
if _PlugLoaded('SimpylFold')
        let g:SimpylFold_docstring_preview = 1
endif

" Navigate to next/previous fold with \zj and \zk
function! NextClosedFold(dir)
	let cmd = 'norm!z' . a:dir
	let view = winsaveview()
	let [l0, l, open] = [0, view.lnum, 1]
	while l != l0 && open
		exe cmd
		let [l0, l] = [l, line('.')]
		let open = foldclosed(l) < 0
	endwhile
	if open
		call winrestview(view)
	endif
endfunction

nnoremap Z <Nop>
nnoremap ZZ <Nop>
nnoremap <silent> zz :call NextClosedFold('j')<cr>
nnoremap <silent> ZZ :call NextClosedFold('k')<cr>


" === Language (Latex) ============================================= "

if _PlugLoaded('vimtex')
    autocmd BufReadPre *.tex let b:vimtex_main = 'main.tex'
endif

autocmd FileType javascript setlocal shiftwidth=2 softtabstop=2 expandtab


" === Leader Shortcuts ============================================= "

nnoremap <silent> <leader>R :source ~/.config/nvim/init.vim <cr>
nnoremap <silent> <leader>E :edit ~/.config/nvim/init.vim <cr>

" === COC Completeion ============================================== "

" Hide buffers rather than closing them when a new buffer is opened
set hidden

" Some servers have issues with backup files, see #649
set nobackup
set nowritebackup

" Speeds up receiving diagnostic messages
set updatetime=300

" Don't give |ins-completion-menu| messages.
set shortmess+=c

" COC extensions to install
let g:coc_global_extensions = [ 'coc-solargraph',
                              \ 'coc-tsserver',
                              \ 'coc-json',
                              \ 'coc-html',
                              \ 'coc-snippets',
                              \ 'coc-python',
                              \ 'coc-css']

" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? coc#_select_confirm() :
      \ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

let g:coc_snippet_next = '<tab>'

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position.
" Coc only does snippet and additional edit on confirm.
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')

" Remap for rename current word
nmap <leader>rn <Plug>(coc-rename)

" Remap for format selected region
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Remap for do codeAction of selected region, ex: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap for do codeAction of current line
nmap <leader>ac  <Plug>(coc-codeaction)
" Fix autofix problem of current line
nmap <leader>qf  <Plug>(coc-fix-current)

" Create mappings for function text object, requires document symbols feature of languageserver.
xmap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap if <Plug>(coc-funcobj-i)
omap af <Plug>(coc-funcobj-a)

" Use <TAB> for select selections ranges, needs server support, like: coc-tsserver, coc-python
nmap <silent> <TAB> <Plug>(coc-range-select)
xmap <silent> <TAB> <Plug>(coc-range-select)

" Use `:Format` to format current buffer
command! -nargs=0 Format :call CocAction('format')

" Use `:Fold` to fold current buffer
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" use `:OR` for organize import of current buffer
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add status line support, for integration with other plugin, checkout `:h coc-status`
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Using CocList
" Show all diagnostics
nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions
nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
" Show commands
nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document
nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols
nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list
nnoremap <silent> <space>p  :<C-u>CocListResume<CR>

" === Linting/Fixing =============================================== "
let g:ale_linters = {
      \   'ruby': ['rubocop'],
      \   'python': ['flake8', 'pylint'],
      \   'javascript': ['standard'],
      \}
let g:ale_fixers = {
      \    'ruby': ['rubocop'],
      \    'javascript': ['standard'],
      \    'python': ['black'],
      \}
let g:ale_enabled = 1
let g:ale_fix_on_save = 1

" === Other ======================================================== "

augroup registerwelcomemessage
	autocmd!
	autocmd VimEnter * echo "Welcome back, " . $USER
augroup END

nnoremap <silent> <leader>N :PrevColorScheme<cr>
nnoremap <silent> <leader>n :NextColorScheme<cr>

" === Status Line ================================================== "

" status bar colors
hi statusline ctermfg=black ctermbg=white
hi User1 ctermfg=black ctermbg=white
hi User2 ctermfg=black ctermbg=white
hi User3 ctermfg=black ctermbg=white
hi User4 ctermfg=black ctermbg=white

" Status line
" default: set statusline=%f\ %h%w%m%r\ %=%(%l,%c%V\ %=\ %P%)

" Status Line Custom
let g:currentmode={
    \ 'n'  : 'Normal',
    \ 'no' : 'Normal·Operator Pending',
    \ 'v'  : 'Visual',
    \ 'V'  : 'V·Line',
    \ '' : 'V·Block',
    \ 's'  : 'Select',
    \ 'S'  : 'S·Line',
    \ '' : 'S·Block',
    \ 'i'  : 'Insert',
    \ 'R'  : 'Replace',
    \ 'Rv' : 'V·Replace',
    \ 'c'  : 'Command',
    \ 'cv' : 'Vim Ex',
    \ 'ce' : 'Ex',
    \ 'r'  : 'Prompt',
    \ 'rm' : 'More',
    \ 'r?' : 'Confirm',
    \ '!'  : 'Shell',
    \ 't'  : 'Terminal'
    \}

set laststatus=2
set noshowmode
set statusline=
set statusline+=%0*\ %n\                                 " Buffer number
set statusline+=%1*\ %<%F%m%r%h%w\                       " File path, modified, readonly, helpfile, preview
set statusline+=%3*│                                     " Separator
set statusline+=%2*\ %Y\                                 " FileType
set statusline+=%3*│                                     " Separator
set statusline+=%2*\ %{''.(&fenc!=''?&fenc:&enc).''}     " Encoding
set statusline+=\ (%{&ff})                               " FileFormat (dos/unix..)
set statusline+=%=                                       " Right Side
set statusline+=%2*\ col:\ %02v\                         " Colomn number
set statusline+=%3*│                                     " Separator
set statusline+=%1*\ ln:\ %02l/%L\ (%3p%%)\              " Line number / total lines, percentage of document
set statusline+=%0*\ %{toupper(g:currentmode[mode()])}\  " The current mode
