"for f in split(glob('~/.config/nvim/configs/*.vim'), '\n')
"   exe 'source' f
"endfor

syntax enable
syntax on

set history=1000
set undolevels=1000
set encoding=UTF-8
autocmd BufEnter * :set scroll=10
set incsearch
set hlsearch

set number relativenumber
set tabstop=4
set ignorecase
set autoindent
set smartcase
set expandtab
set shiftwidth=4
set showmatch
set softtabstop=0
set clipboard=unnamedplus
set ttimeoutlen=50
set cursorline
set wildmenu
set lazyredraw
set nobackup
set noerrorbells
set noswapfile
set nowrap
set visualbell

filetype plugin on
filetype plugin indent on

call plug#begin('~/.vim/bundle')
" vimm for go=========
Plug 'jsfaint/coc-neoinclude'

Plug 'dracula/vim', { 'as': 'dracula' }

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
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

Plug 'itchyny/lightline.vim'
Plug 'artur-shaik/vim-javacomplete2' " , { 'for': 'java'}
Plug 'majutsushi/tagbar', { 'on': 'TagbarToggle' }
Plug 'SirVer/ultisnips'
Plug 'scrooloose/nerdtree', { 'on': ['NERDTreeToggle', 'NERDTreeFind'] }
Plug 'scrooloose/nerdcommenter'
Plug 'w0rp/ale'
Plug 'easymotion/vim-easymotion'
Plug 'morhetz/gruvbox'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'tpope/vim-surround'
Plug 'sheerun/vim-polyglot'
Plug 'alvan/vim-closetag'
Plug 'jiangmiao/auto-pairs'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'styled-components/vim-styled-components', { 'branch': 'main' }
Plug 'terryma/vim-multiple-cursors'
Plug 'dyng/ctrlsf.vim'

"typescript
Plug 'ianks/vim-tsx'
Plug 'herringtondarkholme/yats.vim'
Plug 'pangloss/vim-javascript'
Plug 'maxmellon/vim-jsx-pretty'

"Autocomplete python"
"Plug 'Yggdroot/indentLine'
"Plug 'roxma/nvim-yarp'
"Plug 'ncm2/ncm2'
"Plug 'HansPinckaers/ncm2-jedi'
"Plug 'ncm2/ncm2-bufword'
"Plug 'ncm2/ncm2-path'
"Plug 'kangol/vim-pudb'
"Plug 'honza/vim-snippets'


call plug#end()

"Enable tagbar on startup"
autocmd FileType py call tagbar#autoopen(0)

"Ctrlp Settings {{{

let g:ctrlp_map = '<c-p>'

let g:ctrlp_cmd = 'ctrlp'
let g:ctrlp_dont_split = 'nerd'
let g:ctrlp_working_path_mode = 'rw'
set wildignore+=*/.git/*,*/tmp/*,*.swp/*,*/node_modules/*,*/temp/*,*/Builds/*,*/ProjectSettings/*
" Set no max file limit
let g:ctrlp_max_files = 0
" Search from current directory instead of project root

function! ClipboardYank()
    call system('pbcopy',@@)
endfunction

function! ClipboardPaste()
    let @@=system('pbpaste')
endfunction
function! Multiple_cursors_before()
  if deoplete#is_enabled()
    call deoplete#disable()
    let g:deoplete_is_enable_before_multi_cursors = 1
  else
    let g:deoplete_is_enable_before_multi_cursors = 0
  endif
endfunction
function! Multiple_cursors_after()
  if g:deoplete_is_enable_before_multi_cursors
    call deoplete#enable()
  endif
endfunction

function! CtrlPCommand()
  let c = 0
  let wincount = winnr('$')
  " Don't open it here if current buffer is not writable (e.g. NERDTree)
  while !empty(getbufvar(+expand("<abuf>"), "&buftype")) && c < wincount
    exec 'wincmd w'
    let c = c + 1
  endwhile
  exec 'CtrlP'
endfunction
let g:ctrlp_cmd = 'call CtrlPCommand()'

"RipGrep
if executable('rg')
  set grepprg=rg\ --color=never
  let g:ctrlp_user_command = 'rg %s --files --color=never --glob ""'
  let g:ctrlp_use_caching = 0
endif
let g:ctrlp_custom_ignore = {
      \ 'dir':  '',
      \ 'file': '\.so$\|\.dat$|\.DS_Store$|\.meta|\.zip|\.rar|\.ipa|\.apk',
      \ }
" }}}
"Ale Settings {{{

let g:ale_echo_msg_error_str = 'E'
let g:ale_echo_msg_warning_str = 'W'
let g:ale_sign_error = '✘✘'
let g:ale_sign_warning = '⚠⚠'
let g:ale_open_list = 0
let g:ale_loclist = 0
"g:ale_javascript_eslint_use_global = 1
let g:ale_linters = {
      \  'cs':['syntax', 'semantic', 'issues'],
      \  'java': ['javac']
      \ }
" }}}
" Deoplete {{{

let g:deoplete#enable_at_startup = 1

let g:deoplete#auto_complete_start_length = 2
let g:deoplete#sources = {}
let g:deoplete#sources._=['buffer', 'ultisnips', 'file', 'dictionary']
let g:deoplete#sources.javascript = ['tern', 'omni', 'file', 'buffer', 'ultisnips']
let g:deoplete#sources.java = ['jc', 'javacomplete2', 'file', 'buffer', 'ultisnips']


" Use smartcase.
let g:deoplete#enable_smart_case = 1


"set completeopt-=preview

""use TAB as the mapping
inoremap <silent><expr> <TAB>
      \ pumvisible() ?  "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ deoplete#mappings#manual_complete()
function! s:check_back_space() abort "" {{{
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~ '\s'
endfunction "" }}}
" }}}
" UltiSnips {{{

" Trigger configuration. Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.
let g:UltiSnipsExpandTrigger="<c-j>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"

" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"

let g:UltiSnipsSnippetDirectories = ['~/.vim/UltiSnips', 'UltiSnips']
let g:UltiSnipsSnippetsDir="~/.vim/UltiSnips"

" }}}
" Java {{{

" Easy compile java in vim
autocmd FileType java set makeprg=javac\ %
set errorformat=%A%f:%l:\ %m,%-Z%p^,%-C.%#
" Java completion
autocmd FileType java setlocal omnifunc=javacomplete#Complete
autocmd FileType java JCEnable
" }}}

" Open when no files were speficied on vim launch
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

" Toggle nerdtree
map <C-n> :NERDTreeToggle<CR>

"***PYTHON SETUP***
"let g:jedi#completions_enabled = 0
"let g:jedi#use_splits_not_buffers = "right"
"let g:indentLine_enabled = 0

"====== COC-NVIM ======
let g:coc_global_extensions = ['coc-tslint-plugin', 'coc-tsserver', 'coc-css', 'coc-json']
set updatetime=300
set shortmess+=c
set signcolumn=yes

function! s:show_documentation()
  if (index(['nvim','help'], &filetype) >= 0)
    xecute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction
"===== end of Coc-nvim======
"leaderF
let g:Lf_ShortcutF = '<C-P>'
let g:Lf_PreviewInPopup = 1

"ctrslf
let g:ctrlsf_default_view_mode = 'compact'

" Easymotion
let g:EasyMotion_smartcase = 1

" AUTO CLOSE TAGS
let g:closetag_filenames = '*.html,*.jsx,*.tsx,*.js,*.vue'
let g:closetag_xhtml_filenames = '*.xhtml,*.jsx,*.js,*.vue'
let g:closetag_filetypes = 'html,js,xhtml,phtml,jsx,tsx,vue'
let g:closetag_xhtml_filetypes = 'xhtml,jsx,tsx,js,vue'
let g:closetag_emptyTags_caseSensitive = 1
let g:closetag_shortcut = '>'

" theme

set termguicolors
colorscheme dracula
 
" Required for operations modifying multiple buffers like rename.
set hidden

let g:LanguageClient_serverCommands = {
    \ 'javascript': ['/usr/local/bin/javascript-typescript-stdio'],
    \ 'javascript.jsx': ['tcp://127.0.0.1:2089'],
    \ }
    
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
