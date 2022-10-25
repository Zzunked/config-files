"Vim settings"
set number
set rnu
syntax on
filetype plugin indent on
set encoding=utf-8
set tabstop=4
set shiftwidth=4
set expandtab
set smartindent
set nowrap
set smartcase
set noswapfile
set undodir=~/.vim/undodir
set undofile
set incsearch
set hlsearch
set ignorecase
set colorcolumn=80
set scrolloff=7
set cursorline
set splitright
set backspace=indent,eol,start
set path+=**
set wildmenu
set updatetime=60
highlight ColorColumn ctermbg=0 guibg=lightgrey
au BufNewFile,BufRead Jenkinsfile setf groovy

" --------------KeyBindings------------
let mapleader = " "
"  checkout vimrc
nmap <leader>SO :so~/.vimrc<CR>
" turn off line numbers
nmap <leader>nnm :set rnu!<CR>:set nu!<CR>
" turn on line numbers
nmap <leader>nm :set rnu<CR>:set nu<CR>
"  add space
nmap <leader><leader> i<SPACE><ESC>
"  format json via jq
nmap <leader>js v%d:r!echo<SPACE>'<C-r>"' \| jq<CR><CR>

" back to previouse file
nmap <leader>bb :e#<CR>

" format SDP
nmap <leader>sdp v$d:r!echo<SPACE>-e<SPACE>'<C-r>"'<CR><CR>

" Add blank line
nnoremap 1o o<ESC>
nnoremap 1O O<ESC>
nnoremap 2o o<CR>
nnoremap 2O O<CR>

" move down
nnoremap <C-l> i<CR><ESC>

" Cancell searchhighlight
nnoremap <C-h> :noh<CR>

" formatlog
nnoremap <leader>lg :set wrap<CR>:set linebreak<CR>:set nornu<CR>

let g:netrw_winsize = 25

" moving between windows
nnoremap <leader>h :wincmd h<CR>
nnoremap <leader>j :wincmd j<CR>
nnoremap <leader>k :wincmd k<CR>
nnoremap <leader>l :wincmd l<CR>

" resizing windows
nnoremap <Leader>= :vertical resize +5<CR>
nnoremap <Leader>- :vertical resize -5<CR>
nnoremap <Leader>9 :resize +5<CR>
nnoremap <Leader>0 :resize -5<CR>

"-----------------Plugins-------------"
call plug#begin('~/.vim/plugged')

" Theme
Plug 'dracula/vim', { 'as': 'dracula' }

" Async
Plug 'junegunn/fzf', {'do': { -> fzf#install()}}
Plug 'junegunn/fzf.vim'

" Rg aka ripgrep
Plug 'jremmen/vim-ripgrep'

" AutoSave
Plug '907th/vim-auto-save'

" Undoo tree
Plug 'mbbill/undotree'

" Autocomplete from python
Plug 'davidhalter/jedi-vim'

" Tags
Plug 'szw/vim-tags'

" Tagbar for functions and classes
Plug 'preservim/tagbar'

" Tab autocomplete
Plug 'ervandew/supertab'

" Python support
Plug 'python-mode/python-mode', { 'for': 'python', 'branch': 'develop' }

" Support for Html. xml and ect.
Plug 'mitsuhiko/vim-jinja'	

" Multiple cursors
Plug 'terryma/vim-multiple-cursors'

" Multiple line editor
Plug 'dyng/ctrlsf.vim'

" Comments
Plug 'preservim/nerdcommenter'

" project tree
Plug 'preservim/nerdtree'

" bottom line
Plug 'itchyny/lightline.vim'

" Parentheses, brackets, quotes, XML tags, and more
Plug 'tpope/vim-surround'	   	

"git plugs
Plug 'tpope/vim-fugitive'

" git checkout
Plug 'stsewd/fzf-checkout.vim'

call plug#end()

"Plugins Settings"

"Set dracula colorscheme"
colorscheme dracula
hi NonText ctermbg=none
set bg=dark
hi Normal guibg=NONE ctermbg=NONE

" vim-fugitive
nnoremap <C-p> :GFiles<CR>

nnoremap <Leader>* :Rg <C-R><C-W><CR>
nnoremap <Leader>& :RG <C-R><C-W><CR>

command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always --smart-case -- '.shellescape(<q-args>), 1,
  \   fzf#vim#with_preview(), <bang>0)

function! RipgrepFzf(query, fullscreen)
  let command_fmt = 'rg --column --line-number --no-heading --color=always --smart-case -- %s || true'
  let initial_command = printf(command_fmt, shellescape(a:query))
  let reload_command = printf(command_fmt, '{q}')
  let spec = {'options': ['--phony', '--query', a:query, '--bind', 'change:reload:'.reload_command]}
  call fzf#vim#grep(initial_command, 1, fzf#vim#with_preview(spec), a:fullscreen)
endfunction

command! -nargs=* -bang RG call RipgrepFzf(<q-args>, <bang>0)

" undootree
nnoremap <F6> :UndotreeToggle<cr>

if has("persistent_undo")
   let target_path = expand('~/.vim/undodir')

    " create the directory and any parent directories
    " if the location does not exist.
    if !isdirectory(target_path)
        call mkdir(target_path, "p", 0700)
    endif

    let &undodir=target_path
    set undofile
endif

" Autosave
let g:auto_save = 0  " enable AutoSave on Vim startup
let g:auto_save_events = ["CursorHold"]

" vim-tags
let g:vim_tags_auto_generate = 1
let g:vim_tags_use_vim_dispatch = 1
let g:vim_tags_use_language_field = 1
let g:vim_tags_ignore_file_comment_pattern = '^[#"]'

" tagbar
nmap <F8> :TagbarToggle<CR>
let g:tagbar_autofocus = 1
let g:tagbar_sort = 0

" nerdtree
map <F7> :NERDTreeToggle<CR>
"---------jedi-vim----------

" Python-mode settings
let g:pymode = 1
let g:pymode_warnings = 1
let g:pymode_trim_whitespaces = 1
let g:pymode_folding = 0
let g:pymode_motion = 1
let g:pymode_virtualenv = 1
let g:pymode_run = 0
let g:pymode_breakpoint = 0
let g:pymode_lint = 1
 let g:pymode_lint_ignore = ["E501"]
let g:pymode_lint_on_write = 0
let g:pymode_rope = 0
let g:pymode_syntax = 1
let g:pymode_syntax_all = 1
let g:pymode_syntax_indent_errors = g:pymode_syntax_all
let g:pymode_syntax_space_errors = g:pymode_syntax_all

nnoremap <leader>pl :PymodeLint<CR>

" lightline
set laststatus=2
let g:lightline = {
      \ 'colorscheme': 'dracula',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ]
      \ },
      \ 'component_function': {
      \   'gitbranch': 'FugitiveHead'
      \ },
      \ }

" ctags
map <F4> [I:let nr = input("Which one: ")<Bar>exe "normal " . nr ."[\t"<CR>

" git 
nnoremap <leader>gc :GCheckout<CR>
nnoremap <leader>gb :Git blame<CR>
nnoremap <leader>gph :Git push<CR>
nnoremap <leader>gf :Git fetch<CR>
nnoremap <leader>gl :Git log<CR>
nnoremap <leader>gcm :Git commit<CR>
nnoremap <leader>gp :Git pull<CR>
nnoremap <leader>gs :Git status<CR>
nnoremap <leader>gm :Git merge<CR>
nnoremap <leader>ga :Git add .<CR>
nmap <leader>gj :diffget //3<CR>
nmap <leader>gk :diffget //3<CR>

