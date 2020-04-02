" This must be first, because it changes other options as side effect
set nocompatible

"Load Pathogen and enable
execute pathogen#infect()

" change the mapleader from \ to ,
let mapleader=","

" Basic editing and viewing settings
syntax enable		" Syntax highlighting
set number		" Show Linenumbers
set relativenumber	" Make Linenumbers relative
set autoindent		" always set autoindenting on
set copyindent		" copy the previous indentation on autoindentinga
set nowrap		" don't wrap lines

set undolevels=1000	" use many muchos levels of undo

set shiftwidth=2	" Set indent width
set showmatch		" Show matching parenthesis

set visualbell		" Don't ring
set noerrorbells	" don't ring

" Display whitespace characters
set list
" Change tab display for files where they are usual
au FileType html,xml set listchars-=tab:>.

" Enable Shortcut for large Pastes
set pastetoggle=<F2>

" Keybindings

" Quickly edit/reload the vimrc file
:nnoremap <leader>ev :vsplit $MYVIMRC<cr>
:nnoremap <leader>sv :so $MYVIMRC<cr>

" Toggle line numbering
:nnoremap <leader>n :set nu! relativenumber!<cr>

" Toggle show/hide invisible chars
:nnoremap <leader>i :set list!<cr>

" Remap j and k to act as expected when used on long, wrapped, lines except when used with a count
noremap <silent> <expr> j (v:count == 0 ? 'gj' : 'j')
noremap <silent> <expr> k (v:count == 0 ? 'gk' : 'k')

" Easy window navigation
" Without requiring C-w before
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l

" Speed up scrolling of the viewport slightly
nnoremap <C-e> 2<C-e>
nnoremap <C-y> 2<C-y>

" Force sudo on a readony file
cmap w!! w !sudo tee % >/dev/null

" Search options
" Disable vim specific regex
nnoremap / /\v
vnoremap / /\v
set ignorecase
set smartcase
set gdefault
set incsearch
set showmatch
set hlsearch
nnoremap <leader><space> :noh<cr>
nnoremap <tab> %
vnoremap <tab> %

" Strip all trailing whitespace from a file, using ,W
nnoremap <leader>W :%s/\s\+$//<CR>:let @/=''<CR>

" Set background Colors and solarized Theme
set background=dark
colorscheme solarized8_flat
filetype plugin indent on

" Auto reload .vimrc
augroup myvimrc
    au!
    au BufWritePost .vimrc,_vimrc,vimrc,.gvimrc,_gvimrc,gvimrc so $MYVIMRC | if has('gui_running') | so $MYGVIMRC | endif
augroup END

