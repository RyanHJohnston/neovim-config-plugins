" Basic configs using :set attribute
:set number
:set relativenumber
:set autoindent
:set tabstop=4
:set shiftwidth=4 
:set smarttab
:set softtabstop=4
:set mouse=a
:set cursorline
:set cursorcolumn
:set expandtab
:set nobackup
:set scrolloff=10
:set nowrap
:set incsearch
:set ignorecase
:set smartcase
:set showcmd
:set showmode
:set showmatch
:set hlsearch
:set history=1000
:set wildmenu
:set wildmode=list:longest
:set wildignore=*.docx,*.jpg,*.png,*.gif,*.pdf,*.pyc,*.exe,*.flv,*.img,*.xlsx

syntax on
filetype on
filetype plugin on
filetype indent on
call plug#begin()
Plug 'http://github.com/tpope/vim-surround' " Surrounding ysw)
Plug 'https://github.com/preservim/nerdtree' " NerdTree
Plug 'https://github.com/tpope/vim-commentary' " For Commenting gcc & gc
Plug 'https://github.com/vim-airline/vim-airline' " Status bar
Plug 'https://github.com/lifepillar/pgsql.vim' " PSQL Pluging needs :SQLSetType pgsql.vim
Plug 'https://github.com/ap/vim-css-color' " CSS Color Preview
Plug 'https://github.com/rafi/awesome-vim-colorschemes' " Retro Scheme
Plug 'ms-jpq/coq_nvim',{'branch': 'coq'} " Auto Completion pt1, specifically coq_nvim
Plug 'ms-jpq/coq.artifacts', {'branch': 'artifacts'} " Autocompletion pt2
Plug 'neoclide/coc.nvim', {'branch': 'release'} " Autocompletion using coc.nvim
Plug 'ms-jpq/coq.thirdparty', {'branch': '3p'} " Autocompletion pt3
Plug 'https://github.com/ryanoasis/vim-devicons' " Developer Icons
Plug 'https://github.com/tc50cal/vim-terminal' " Vim Terminal
Plug 'https://github.com/preservim/tagbar' " Tagbar for code navigation
Plug 'https://github.com/terryma/vim-multiple-cursors' " CTRL + N for multiple cursors
set encoding=UTF-8
call plug#end()

" VIMSCRIPT
" ----------------------------------------------------------------------------------------
" This will enable code folding.
" Use the market method of folding.
augroup filetype_vim
	autocmd!
	autocmd FileType vim setlocal foldmethod=marker
augroup END
" Quick reference:
" To open a single fold under the cursor: zo
" To close the fold under the cursor: zc
" To open all folds: zR
" To close all folds: zM
" To have more information: :help folding
" ----------------------------------------------------------------------------------------

nnoremap <C-f> :NERDTreeFocus<CR>
nnoremap <C-n> :NERDTree<CR>
nnoremap <C-t> :NERDTreeToggle<CR>
nnoremap <C-l> :call CocActionAsync('jumpDefinition')<CR>

nmap <F8> :TagbarToggle<CR>

:set completeopt-=preview " For No Previews

let g:NERDTreeDirArrowExpandable="+"
let g:NERDTreeDirArrowCollapsible="~"

" --- Just Some Notes ---
" :PlugClean :PlugInstall :UpdateRemotePlugins
"
" :CocInstall coc-python
" :CocInstall coc-clangd
" :CocInstall coc-snippets
" :CocCommand snippets.edit... FOR EACH FILE TYPE

" air-line
let g:airline_powerline_fonts = 1

if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif

" airline symbols
let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''
let g:airline_symbols.branch = ''
let g:airline_symbols.readonly = ''
let g:airline_symbols.linenr = ''

" Splits terminal horizontally or vertically depending on input
command! -nargs=* T belowright split | terminal <args>
command! -nargs=* VT rightbelow vsplit | terminal <args>
command! -nargs=* RVT rightbelow vsplit | terminal <args>
command! -nargs=* LVT vsplit | terminal <args>
command! -nargs=* Tree NERDTreeFocus <args>
" Switches between panes
map <up> <C-w><up>
map <down> <C-w><down>
map <left> <C-w><left>

" inoremap <expr> <Tab> pumvisible() ? coc#_select_confirm() : "<Tab>"

" Exits terminal mode when in split terminal
:tnoremap <Esc> <C-Esc>

" turns off that weird error of illegal arguments in index.js
let b:coc_diagnostic_disable=1

" Uses <Tab> for trigger completion
function! CheckBackSpace() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1] =~# '\s'
endfunction
inoremap <silent><expr> <Tab>
    \ coc#pum#visible() ? coc#pum#next(1) :
    \ CheckBackSpace() ? "\<Tab>" :
    \ coc#refresh()
