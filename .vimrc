syntax enable
syntax on

set number relativenumber
set tabstop=4
set autoindent
set expandtab
set shiftwidth=4
set showmatch
set clipboard=unnamedplus
set ttimeoutlen=50
set cursorline
set wildmenu
filetype plugin indent on

"Plugin Install"
call plug#begin('~/.vim/autoload')

" Code completion
if has('nvim')
  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
else
  Plug 'Shougo/deoplete.nvim'
  Plug 'roxma/nvim-yarp'
  Plug 'roxma/vim-hug-neovim-rpc'
endif


" Cài đặt với Vim-Plug
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'autozimu/LanguageClient-neovim', {
    \ 'branch': 'next',
    \ 'do': 'bash install.sh',
    \ }

" (Optional) Multi-entry selection UI.
Plug 'junegunn/fzf'

Plug 'dracula/vim', { 'as': 'dracula' }
Plug 'itchyny/lightline.vim'
Plug 'preservim/nerdtree'
Plug 'preservim/nerdcommenter'
Plug 'jiangmiao/auto-pairs'
Plug 'sheerun/vim-polyglot'
Plug 'python-mode/python-mode', { 'for': 'python', 'branch': 'develop' }
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'tpope/vim-surround'

"Autocomplete python"
Plug 'roxma/nvim-yarp'
Plug 'ncm2/ncm2'
Plug 'HansPinckaers/ncm2-jedi'
Plug 'ncm2/ncm2-bufword'
Plug 'ncm2/ncm2-path'

"Tagbar"
Plug 'majutsushi/tagbar'

call plug#end()

"Enable tagbar on startup"
autocmd FileType py call tagbar#autoopen(0)

"Config ncm2"
autocmd BufEnter * call ncm2#enable_for_buffer()
set completeopt=noinsert,menuone,noselect
let ncm2#popup_delay = 5
let ncm2#complete_length = [[1, 1]]
let g:ncm2#matcher = 'substrfuzzy'

set termguicolors
colorscheme dracula

"Map jj to ESC" 
inoremap jj <ESC>

" Use ctrl-[hjkl] to select the active split!
nnoremap <silent> <C-k> <c-w>k<CR>
nnoremap <silent> <C-j> <c-w>j<CR>
nnoremap <silent> <C-h> <c-w>h<CR>
nnoremap <silent> <C-l> <c-w>l<CR>

"NERDTreeToggle 
let NERDTreeMinimalUI = 1
let NERDTreeDirArrows = 1
nnoremap <Leader>f :NERDTreeToggle<Enter>

"Ignore warning python-mode
let g:pymode_lint_ignore = ["C0301", "C0114", "C0115"]
let g:pymode_lint_checkers = ["pylint"]
let g:pymode_rope = 0

" theme 
" Required for operations modifying multiple buffers like rename.
set hidden

let g:LanguageClient_serverCommands = {
    \ 'rust': ['~/.cargo/bin/rustup', 'run', 'stable', 'rls'],
    \ 'javascript': ['/usr/local/bin/javascript-typescript-stdio'],
    \ 'javascript.jsx': ['tcp://127.0.0.1:2089'],
    \ 'python': ['/usr/local/bin/pyls'],
    \ 'ruby': ['~/.rbenv/shims/solargraph', 'stdio'],
    \ }

" note that if you are using Plug mapping you should not use `noremap` mappings.
nmap <F5> <Plug>(lcn-menu)
" Or map each action separately
nmap <silent>K <Plug>(lcn-hover)
nmap <silent> gd <Plug>(lcn-definition)
nmap <silent> <F2> <Plug>(lcn-rename)


let g:airline#extensions#tabline#enabled = 1

let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'
"let g:airline#extensions#tabline#formatter = 'LanguageClient'
"In order to see the powerline fonts, adapt the font of your terminal
"In Gnome Terminal: “use custom font” in the profile. I use Monospace regular.
let g:airline_powerline_fonts = 1

" Enable true color 启用终端24位色
if (has("termguicolors"))
  set termguicolors
endif
