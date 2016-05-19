set nocompatible              " be iMproved, required
set hidden
filetype off                  " required

"=====================================================
" Vundle settings
"=====================================================
" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'gmarik/Vundle.vim'		" let Vundle manage Vundle, required

"---------=== Code/project navigation ===-------------
Plugin 'porqz/KeyboardLayoutSwitcher'
Plugin 'airblade/vim-gitgutter' 
Plugin 'alvan/vim-closetag'
Plugin 'tomasr/molokai'
Plugin 'ervandew/supertab'
Plugin 'dimasg/vim-mark'
Plugin 'szw/vim-ctrlspace'
Plugin 'Lokaltog/vim-easymotion'
Plugin 'scrooloose/nerdtree' 	    	" Project and file navigation
Plugin 'majutsushi/tagbar'          	" Class/module browser
Plugin 'kien/ctrlp.vim'
Plugin 'vim-scripts/taglist.vim'
Plugin 'sjl/gundo.vim'
Plugin 'vim-scripts/vcscommand.vim'
Plugin 'scrooloose/nerdcommenter'
Plugin 'nathanaelkane/vim-indent-guides'

"------------------=== Other ===----------------------
Plugin 'bling/vim-airline'   	    	" Lean & mean status/tabline for vim
Plugin 'vim-airline/vim-airline-themes'
Plugin 'fisadev/FixedTaskList.vim'  	" Pending tasks list
Plugin 'rosenfeld/conque-term'      	" Consoles as buffers
Plugin 'tpope/vim-surround'	   	" Parentheses, brackets, quotes, XML tags, and more

"--------------=== Snippets support ===---------------
"Plugin 'garbas/vim-snipmate'		" Snippets manager
"Plugin 'MarcWeber/vim-addon-mw-utils'	" dependencies #1
"Plugin 'tomtom/tlib_vim'		" dependencies #2
"Plugin 'honza/vim-snippets'		" snippets repo

"---------------=== Languages support ===-------------
" --- Markup ---
Plugin 'mitsuhiko/vim-rst'		" reStructuredText Syntax support for Vim
Plugin 'digitaltoad/vim-jade'
Plugin 'gkz/vim-ls'
Plugin 'wavded/vim-stylus'

" --- Python ---
" Plugin 'klen/python-mode'	        " Python mode (docs, refactor, lints, highlighting, run and ipdb and more)
Plugin 'davidhalter/jedi-vim' 		" Jedi-vim autocomplete plugin
"Plugin 'Valloric/YouCompleteMe'
"Plugin 'mitsuhiko/vim-jinja'		" Jinja support for vim
Plugin 'mitsuhiko/vim-python-combined'  " Combined Python 2/3 for Vim
"Plugin 'scrooloose/syntastic'           " Online syntax check

"" HTML Bundle
Plugin 'amirh/HTML-AutoCloseTag'
Plugin 'hail2u/vim-css3-syntax'
Plugin 'gorodinskiy/vim-coloresque'
Plugin 'tpope/vim-haml'

call vundle#end()            		" required
filetype on
filetype plugin on
filetype plugin indent on

let g:gitgutter_map_keys = 0

"=====================================================
" General settings
"=====================================================
if version >= 700
    set history=64
    set undolevels=128
    set undodir=~/.vim/undodir/
    set undofile
    set undolevels=1000
    set undoreload=10000
endif

set backspace=indent,eol,start
" This must happen before the syntax system is enabled
let no_buffers_menu=1
set mousemodel=popup

" Activate a permanent ruler and add line highlightng as well as numbers.
" Also disable the sucking pydoc preview window for the omni completion
" and highlight current line and disable the blinking cursor.
set ruler
set completeopt-=preview
set gcr=a:blinkon0
if has("gui_running")
  set cursorline
endif
set ttyfast

" Enable Syntax Colors
" in GUI mode we go with fruity and Monaco 13
" in CLI mode myterm looks better (fruity is GUI only)
syntax on
if has("gui_running")
" GUI? Then maximize windows and set custom color sheme
"  set lines=50 columns=125
  colorscheme molokai
" automatically open at startup
" autocmd vimenter * TagbarToggle
" autocmd vimenter * NERDTree
" autocmd vimenter * if !argc() | NERDTree | endif

  " special settings for vim
  if has("mac")
    "set guifont=Consolas:h13
    "set guifont=Droid\ Sans\ Mono\ 11
    set guifont=Inconsolata\ for\ Powerline:h15
    set guifont=Droid\ Sans\ Mono\ for\ Powerline:h13
    set fuoptions=maxvert,maxhorz
  " does not work properly on os x
  " au GUIEnter * set fullscreen
  else
  " set default font for GUI
  "  set guifont=Ubuntu\ Mono\ derivative\ Powerline\ 10
    set guifont=Droid\ Sans\ Mono\ 11
  endif
else
" oh, its terminal... then what we do...
  colorscheme molokai
endif

tab sball
set switchbuf=useopen

" Don't bell and blink
set visualbell t_vb= " turn off error beep/flash
set novisualbell     " turn off visual bell

set enc=utf-8	     " utf-8 default encoding
set ls=2             " always show status bar
set incsearch	     " incremental search
set hlsearch	     " highlighted search results
set nu	             " line numbers
set scrolloff=5	     " keep some more lines for scope
set history=50  " keep 50 lines of command line history
set showcmd     " display incomplete commands
set listchars=precedes:«,extends:»,tab:▶▷,trail:·
set list

" Disable swaps and backups
"set nobackup 	     " no backup files
"set nowritebackup    " only in case you don't want a backup file while editing
"set noswapfile 	     " no swap files
set backup

" Hide some panels
if has("gui_running")
" For Win32 GUI: remove 't' flag from 'guioptions': no tearoff menu entries
" let &guioptions = substitute(&guioptions, "t", "", "g")
    set guioptions-=m
    set guioptions-=T
    set guioptions-=r
    set guioptions-=R
    set guioptions-=l
    set guioptions-=L
endif
"
" Only do this part when compiled with support for autocommands.
if has("autocmd")

  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  filetype plugin indent on

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au!

  " For all text files set 'textwidth' to 78 characters.
  "autocmd FileType text setlocal textwidth=78
  autocmd FileType text setlocal textwidth=80

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  autocmd BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal g`\"" |
    \ endif

  augroup END
else
  set autoindent        " always set autoindenting on
endif " has("autocmd")

" Tab Settings
set autoindent
set tabstop=4
set softtabstop=4
set shiftwidth=4
set smarttab
set expandtab
set wildmode=longest,list,full
set wildmenu
set wildignore+=*/tmp/*,*.so,*.swp,*.zip

if version >= 700
    set history=64
    set undolevels=128
    set undodir=~/.vim/undodir/
    set undofile
    set undolevels=1000
    set undoreload=10000
endif

" Highlight characters past column 80
"augroup vimrc_autocmds
"    autocmd!
"    autocmd FileType ruby,python,javascript,c,cpp highlight Excess ctermbg=DarkGrey guibg=Black
"    autocmd FileType ruby,python,javascript,c,cpp match Excess /\%80v.*/
"    autocmd FileType ruby,python,javascript,c,cpp set nowrap
"augroup END

" SnipMate settings
let g:snippets_dir = "~/.vim/vim-snippets/snippets"

" CTRL-P ignore path
let g:ctrlp_custom_ignore = 'venv'
let g:ctrlp_custom_ignore = 'venv26'

" Vim-Airline settings
set laststatus=2
let g:airline_theme='badwolf'
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline_exclude_preview = 1
"let g:airline#extensions#tabline#formatter = 'unique_tail'

set showmatch
set matchtime=1
vnorem // y/<c-r>"<cr>

" EasyMover settings
"map  / <Plug>(easymotion-sn)
"omap / <Plug>(easymotion-tn)
"map  n <Plug>(easymotion-next)
"map  N <Plug>(easymotion-prev)

map <Left> <Nop>
map <Right> <Nop>
map <Up> <Nop>
map <Down> <Nop>

" nerd tree file sync
nmap ,m :NERDTreeToggle<CR>
nmap ,n :NERDTreeFind<CR>

" move between buffers
imap <C-j> <Esc>:bn<CR>a
nmap <C-j> :bn<CR>
imap <C-k> <Esc>:bp<CR>a
nmap <C-k> :bp<CR>

" move between tabs
imap <C-h> <Esc>:tabprev<CR>a
nmap <C-h> :tabprev<CR>
imap <C-l> <Esc>:tabnext<CR>a
nmap <C-l> :tabnext<CR>

" move between splitted windows
map <M-k> <C-w>k
map <M-j> <C-w>j
map <M-h> <C-w>h
map <M-l> <C-w>l

" resize windows
set cpoptions-=b
map <M--> <C-w>-
map <M-=> <C-w>+
map <M-_> <C-w>_
map <M-,> <C-w><
map <M-.> <C-w>>
map <M-\|> <C-w>\|
map <M-0> <C-w>=

" TaskList settings
map <F1> :TaskList<CR> 	   " show pending tasks list

" save current buffer
imap <F2> <Esc>:w<CR>a
nmap <F2> :w<CR>

" save all buffers
imap <S-F2> <Esc>:wa<CR>a
nmap <S-F2> :wa<CR>

" TagBar settings
map <F4> :TagbarToggle<CR>
let g:tagbar_autofocus = 0 " autofocus on Tagbar open
let g:ctrlp_working_path_mode = 'a'

" NerdTree settings
map <F3> :NERDTreeToggle<CR>
let NERDTreeIgnore=['\~$', '\.pyc$', '\.pyo$', '\.class$', 'pip-log\.txt$', '\.o$']

" open buffer in new tab
imap <S-F3> <Esc>:tabnew<Space>
nmap <S-F3> :tabnew<Space>

map <F9> :TagbarToggle<CR>

nnoremap <M-x> <C-a>
map <C-A> :grep! --include=\*\[a-zA-Z\] --exclude=\*.html -r '<C-R>=expand("<cword>")<CR>' .<CR>:copen<CR>

" MiniBufExplorer settings
map <C-q> :bd<CR> 	   " close current buffer

"=====================================================
" Python-mode settings
"=====================================================
" Python-mode
" Activate rope
" Keys:
" K Show python docs
" <Ctrl-Space> Rope autocomplete
" <Ctrl-c>g Rope goto definition
" <Ctrl-c>d Rope show documentation
" <Ctrl-c>f Rope find occurrences
" <Leader>b Set, unset breakpoint (g:pymode_breakpoint enabled)
" [[ Jump on previous class or function (normal, visual, operator modes)
" ]] Jump on next class or function (normal, visual, operator modes)
" [M Jump on previous class or method (normal, visual, operator modes)
" ]M Jump on next class or method (normal, visual, operator modes)
let g:pymode_rope = 0
let g:pymode_rope_completion = 0
let g:pymode_rope_complete_on_dot = 0

" Documentation
let g:pymode_doc = 0
let g:pymode_doc_key = 'K'
"Linting
let g:pymode_lint = 0
let g:pymode_lint_checker = "pyflakes,pep8"
let g:pymode_lint_ignore="E501,W601,C0110"
" Auto check on save
let g:pymode_lint_write = 0

" Support virtualenv
let g:pymode_virtualenv = 1

" Enable breakpoints plugin
let g:pymode_breakpoint = 0
let g:pymode_breakpoint_key = '<leader>b'

" Syntax highlighting
let g:pymode_syntax = 1
let g:pymode_syntax_all = 1
let g:pymode_syntax_indent_errors = g:pymode_syntax_all
let g:pymode_syntax_space_errors = g:pymode_syntax_all

" Don't autofold code
let g:pymode_folding = 0

" Get possibility to run Python code
let g:pymode_run = 0

"=====================================================
" Jedi-vim
"=====================================================
" Disable choose first function/method at autocomplete"let g:jedi#popup_select_first = 0
let g:jedi#popup_select_first = 0


" Bind <Alt+Up/Down> keys for splitting tabs
nnoremap <M-Up> <C-w>v		" split window horizontally
nnoremap <M-Down> <C-w>s	" split window vertically

" ConqueTerm
" Run Python-scripts at <F5>
" let g:pymode_run_key = '<F5>'
nnoremap <F5> :ConqueTermSplit ipython<CR>
" and debug-mode for <F6>

map <F6> :copen<CR>
map <S-F6> :cclose<CR>

map <S-F7> :cp<CR>
map <F7> :cn<CR>

nnoremap <F8> :exe "ConqueTermSplit ipython " . expand("%")<CR>
let g:ConqueTerm_StartMessages = 0
let g:ConqueTerm_CloseOnEnd = 0
" Python code check on PEP8
"autocmd FileType python map <buffer> <leader>8 :PymodeLint<CR>

" Activate autocomplete at <Ctrl+Space>
inoremap <C-space> <C-x><C-o>
noremap <M-space> :CtrlSpace<CR>

" Easy switching languages
"nnoremap <leader>Th :set ft=htmljinja<CR>
nnoremap <leader>Tp :set ft=python<CR>
nnoremap <leader>Tj :set ft=javascript<CR>
nnoremap <leader>Tr :set ft=rst<CR>
nnoremap <leader>Tc :set ft=css<CR>
nnoremap <leader>Td :set ft=django<CR>

"=====================================================
" Languages support
"=====================================================
" --- C/C++/C# ---
autocmd FileType c setlocal tabstop=4 softtabstop=4 shiftwidth=4 expandtab
autocmd FileType cpp setlocal tabstop=4 softtabstop=4 shiftwidth=4 expandtab
autocmd FileType cs setlocal tabstop=8 softtabstop=4 shiftwidth=4 expandtab

" --- Erlang ---
autocmd FileType erlang setlocal tabstop=4 softtabstop=4 shiftwidth=4 expandtab

" --- Python ---
autocmd FileType python set completeopt-=preview " its need for jedi-vim
"au FileType python set completeopt=menuone,longest,preview

autocmd FileType python setlocal expandtab shiftwidth=4 tabstop=4
\ formatoptions+=croq softtabstop=4 smartindent
\ cinwords=if,elif,else,for,while,try,except,finally,def,class,with
autocmd FileType pyrex setlocal expandtab shiftwidth=4 tabstop=8 softtabstop=4 smartindent cinwords=if,elif,else,for,while,try,except,finally,def,class,with

" --- Ruby ---
autocmd FileType ruby,eruby set omnifunc=rubycomplete#Complete
autocmd FileType ruby,eruby setlocal expandtab shiftwidth=2 tabstop=2 softtabstop=2

" --- JavaScript ---
let javascript_enable_domhtmlcss=1
autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
autocmd BufNewFile,BufRead *.json setlocal ft=javascript

" --- HTML ---
autocmd FileType html set omnifunc=htmlcomplete#CompleteTags

" --- template language support (SGML / XML too) ---
"autocmd FileType html,xhtml,xml,htmldjango,htmljinja,eruby,mako setlocal expandtab shiftwidth=4 tabstop=4 softtabstop=4
autocmd FileType html,xhtml,xml,htmldjango setlocal expandtab shiftwidth=4 tabstop=4 softtabstop=4
autocmd bufnewfile,bufread *.rhtml setlocal ft=eruby
autocmd BufNewFile,BufRead *.mako setlocal ft=mako
autocmd BufNewFile,BufRead *.tmpl setlocal ft=htmljinja
autocmd BufNewFile,BufRead *.jade setlocal ft=jade
autocmd BufNewFile,BufRead *.ls setlocal ft=ls
autocmd BufNewFile,BufRead *.styl setlocal ft=stylus
autocmd BufNewFile,BufRead *.py_tmpl setlocal ft=python
"autocmd BufNewFile,BufRead *.html,*.htm call s:SelectHTML()
let html_no_rendering=1
let g:closetag_default_xml=1
let g:sparkupNextMapping='<c-l>'
autocmd FileType html,htmldjango,htmljinja,eruby,mako let b:closetag_html_style=1
"autocmd FileType html,xhtml,xml,htmldjango,htmljinja,eruby,mako source ~/.vim/scripts/closetag.vim

" --- CSS ---
autocmd FileType css set omnifunc=csscomplete#CompleteCSS
autocmd FileType css setlocal expandtab shiftwidth=4 tabstop=4 softtabstop=4

" --- VIM ---
autocmd FileType vim setlocal expandtab shiftwidth=2 tabstop=2 softtabstop=2

" --- CMake ---
autocmd BufNewFile,BufRead CMakeLists.txt setlocal ft=cmake

" --- RST ---
autocmd BufNewFile,BufRead *.txt setlocal ft=rst
autocmd FileType rst setlocal expandtab shiftwidth=4 tabstop=4 softtabstop=4
\ formatoptions+=nqt textwidth=74

"=====================================================
" User functions
"=====================================================
" Define type of html template engine
" ----------------------------------------
fun! s:SelectHTML()
let n = 1
while n < 50 && n < line("$")
" check for jinja
  if getline(n) =~ '{%\s*\(extends\|block\|macro\|set\|if\|for\|include\|trans\)\>'
    set ft=htmljinja
    return
  endif
" check for mako
    if getline(n) =~ '<%\(def\|inherit\)'
      set ft=mako
      return
    endif
" check for genshi
    if getline(n) =~ 'xmlns:py\|py:\(match\|for\|if\|def\|strip\|xmlns\)'
      set ft=genshi
      return
    endif
    let n = n + 1
  endwhile
" go with html
  set ft=html
endfun

" Function to activate a virtualenv in the embedded interpreter for
" omnicomplete and other things like that.
function LoadVirtualEnv(path)
    let activate_this = a:path . '/bin/activate_this.py'
    if getftype(a:path) == "dir" && filereadable(activate_this)
        python << EOF
import vim
activate_this = vim.eval('l:activate_this')
execfile(activate_this, dict(__file__=activate_this))
EOF
    endif
endfunction

" Load up a 'stable' virtualenv if one exists in ~/.virtualenv
let defaultvirtualenv = $HOME . "/.virtualenvs/stable"

" Only attempt to load this virtualenv if the defaultvirtualenv
" actually exists, and we aren't running with a virtualenv active.
if has("python")
    if empty($VIRTUAL_ENV) && getftype(defaultvirtualenv) == "dir"
        call LoadVirtualEnv(defaultvirtualenv)
    endif
endif

set noeol
set nobackup
set nowritebackup

