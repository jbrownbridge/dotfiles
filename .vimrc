"map!  
map!  
" ---------------------------------------------------------------------------
" first the disabled features due to security concerns
set modelines=0               " no modelines [http://www.guninski.com/vim1.html]
let g:secure_modelines_verbose=0 " securemodelines vimscript
let g:secure_modelines_modelines = 15 " 15 available modelines
let g:SuperTabDefaultCompletionType = "<C-X><C-O>"
" ---------------------------------------------------------------------------
" operational settings
syntax on
set nowrap
set ruler                     " show the line number on the bar
set more                      " use more prompt
set autoread                  " watch for file changes
set number                    " line numbers
set hidden                    " allow edit buffers to be hidden
set noautowrite               " don't automagically write on :next
set lazyredraw                " don't redraw when don't have to
set showmode
set showcmd                   " Show us the command we're typing
set nocompatible              " vim, not vi
set autoindent smartindent    " auto/smart indent
set expandtab                 " expand tabs to spaces
set smarttab                  " tab and backspace are smart
set tabstop=2                 " 6 spaces
set shiftwidth=2
set scrolloff=3               " keep at least 3 lines above/below
set sidescrolloff=5           " keep at least 5 lines left/right
set backspace=indent,eol,start
set showfulltag               " show full completion tags
set noerrorbells              " no error bells please
set linebreak
set tw=500                    " default textwidth is a max of 500
set cmdheight=2               " command line two lines high
set undolevels=1000           " 1000 undos
set updatecount=100           " switch every 100 chars
set complete=.,w,b,u,U,t,i,d  " do lots of scanning on tab completion
set ttyfast                   " we have a fast terminal
filetype on                   " Enable filetype detection
filetype indent on            " Enable filetype-specific indenting
filetype plugin on            " Enable filetype-specific plugins
set wildmode=longest:full
set wildignore+=*.o,*~,.lo    " ignore object files
set wildmenu                  " menu has tab completion
let maplocalleader=','        " all my macros start with ,
set foldmethod=syntax         " fold on syntax automagically, always
set foldcolumn=3              " 3 lines of column for fold showing, always
set whichwrap+=<,>,h,l        " backspaces and cursor keys wrap to
set magic                     " Enable the "magic"
set visualbell t_vb=          " Disable ALL bells
set cursorline                " show the cursor line
set matchpairs+=<:>           " add < and > to match pairs
set tags=tags;/               " search recursively up for tags
set paste                     " turn safe pasting on

" highlight over 80 columns
"highlight OverLength ctermbg=darkred ctermfg=white guibg=#FFD9D9
highlight OverLength cterm=reverse
match OverLength /\%81v.*/

set dictionary=/usr/share/dict/words " more words!

colorscheme ir_black_new

if has("gui_running")
  "set noantialias          " If I use ir_black_new, no antialiasing
  set lines=65
  set columns=140
  "set gfn=Monaco:h9
  set guioptions+=LIRrbT
  set guioptions-=LIRrbT
end

if exists('&t_SI')
  let &t_SI = "\<Esc>]12;lightgoldenrod\x7"
  let &t_EI = "\<Esc>]12;grey80\x7"
endif

" fish fixes
if $SHELL =~ 'bin/fish'
  set shell=/usr/bin/zsh
endif


" Settings for taglist.vim
let Tlist_Use_Right_Window=1
let Tlist_Auto_Open=0
let Tlist_Enable_Fold_Column=0
let Tlist_Show_One_File = 1         " Only show tags for current buffer
let Tlist_Compact_Format=0
let Tlist_WinWidth=28
let Tlist_Exit_OnlyWindow=1
let Tlist_File_Fold_Auto_Close = 1

" Settings for :TOhtml
let html_number_lines=1
let html_use_css=1
let use_xhtml=1

" Settings for ConqueTerm
let g:ConqueTerm_InsertOnEnter    = 1 " Automatically go to insert mode
let g:ConqueTerm_CWInsert         = 1 " Change between windows in insert mode
let g:ConqueTerm_ReadUnfocused    = 1 " Keep updating console
let g:ConqueTerm_SendFunctionKeys = 1 " Send function keys to terminal


" Settings for VimClojure
let g:clj_highlight_builtins=1      " Highlight Clojure's builtins
let g:clj_paren_rainbow=1           " Rainbow parentheses'!

" Settings for yankring
let g:yankring_histotry_dir="~/.vim/"
let g:yankring_histotry_file="~/.vim/yank.txt"

" Settings for twitvim
let twitvim_login=''                " Requires using ,ts to input your username/password
let g:twitvim_enable_python=1       " Use python for fetchinng the tweets
let g:twitvim_count=30              " Grab 30 tweets
map <LocalLeader>tf :FriendsTwitter<cr>
map <LocalLeader>ts :let twitvim_login=inputdialog('Twitter USER:PASS? ')<cr>
map <LocalLeader>tw :PosttoTwitter<cr>

" Bindings for Narrow/Widen
map <LocalLeader>N :Narrow<cr>
map <LocalLeader>W :Widen<cr>

" PHP settings
let php_sql_query=1
let php_htmlInStrings=1
let php_noShortTags=1
let php_folding=1

inoremap <silent> <m-Left>  <ESC>:wincmd H<CR>
inoremap <silent> <m-Right> <ESC>:wincmd L<CR>
inoremap <silent> <m-Up>    <ESC>:wincmd K<CR>
inoremap <silent> <m-Down>  <ESC>:wincmd J<CR>

nnoremap <silent> <m-Left>  :wincmd H<CR>
nnoremap <silent> <m-Right> :wincmd L<CR>
nnoremap <silent> <m-Up>    :wincmd K<CR>
nnoremap <silent> <m-Down>  :wincmd J<CR>

" Allows us to switch between windows
inoremap <silent> <C-Left>   <ESC>:wincmd h<CR>
inoremap <silent> <C-Right>  <ESC>:wincmd l<CR>
inoremap <silent> <C-Up>     <ESC>:wincmd k<CR>
inoremap <silent> <C-Down>   <ESC>:wincmd j<CR>

nnoremap <silent> <C-Left>   <ESC>:wincmd h<CR>
nnoremap <silent> <C-Right>  <ESC>:wincmd l<CR>
nnoremap <silent> <C-Up>     <ESC>:wincmd k<CR>
nnoremap <silent> <C-Down>   <ESC>:wincmd j<CR>

" Don't navigate in insert mode
"inoremap <Left>   <NOP>
"inoremap <Right>  <NOP>
"inoremap <Up>     <NOP>
"inoremap <Down>   <NOP>

" ---------------------------------------------------------------------------
"  configure autoclose
"  default to off, I'll turn it on if I want to
let g:AutoCloseOn = 0
"  default: {'(': ')', '{': '}', '[': ']', '"': '"', "'": "'"}
"  but completing ' makes typing lisp really suck, so I take it out of the defaults
let g:AutoClosePairs = {'(': ')', '{': '}', '[': ']', '"': '"'}


" ---------------------------------------------------------------------------
"  configuration for fuzzyfinder
" find in buffer is ,fb
nmap <LocalLeader>fb :FuzzyFinderBuffer<CR>
" find in file is ,ff
nmap <LocalLeader>ff :FuzzyFinderFile<CR>
" find in tag is ,ft
nmap <LocalLeader>ft :FuzzyFinderTag<CR>


" ---------------------------------------------------------------------------
" status line 
set laststatus=2
if has('statusline')
  " Status line detail: (from Rafael Garcia-Suarez)
  " %f		file path
  " %y		file type between braces (if defined)
  " %([%R%M]%)	read-only, modified and modifiable flags between braces
  " %{'!'[&ff=='default_file_format']}
  "			shows a '!' if the file format is not the platform
  "			default
  " %{'$'[!&list]}	shows a '*' if in list mode
  " %{'~'[&pm=='']}	shows a '~' if in patchmode
  " (%{synIDattr(synID(line('.'),col('.'),0),'name')})
  "			only for debug : display the current syntax item name
  " %=		right-align following items
  " #%n		buffer number
  " %l/%L,%c%V	line number, total number of lines, and column number

  function! SetStatusLineStyle()
    "let &stl="%f %y "                       .
    "\"%([%R%M]%)"                   .
    "\"%#StatusLineNC#%{&ff=='unix'?'':&ff.'\ format'}%*" .
    "\"%{'$'[!&list]}"               .
    "\"%{'~'[&pm=='']}"              .
    "\"%="                           .
    "\"#%n %l/%L,%c%V "              .
    "\""
    "      \"%#StatusLineNC#%{GitBranchInfoString()}%* " .
    let &stl="%F%m%r%h%w\ [%{&ff}]\ [%Y]\ %P\ %=[a=\%03.3b]\ [h=\%02.2B]\ [%l,%v]"
  endfunc
  " Not using it at the moment, using a different one
  call SetStatusLineStyle()

  if has('title')
    set titlestring=%t%(\ [%R%M]%)
  endif

  "highlight StatusLine    ctermfg=White ctermbg=DarkBlue cterm=bold
  "highlight StatusLineNC  ctermfg=White ctermbg=DarkBlue cterm=NONE
endif

" ---------------------------------------------------------------------------
"  searching
set incsearch                 " incremental search
set ignorecase                " search ignoring case
set smartcase                 " Ignore case when searching lowercase
set hlsearch                  " highlight the search
set showmatch                 " show matching bracket
set diffopt=filler,iwhite       " ignore all whitespace and sync

" ---------------------------------------------------------------------------
"  mouse stuffs
set mouse=a                   " mouse support in all modes
set mousehide                 " hide the mouse when typing
" this makes the mouse paste a block of text without formatting it 
" (good for code)
map <MouseMiddle> <esc>"*p

" ---------------------------------------------------------------------------
"  backup options
set backup
set backupdir=~/.backup
set viminfo=%100,'100,/100,h,\"500,:100,n~/.viminfo
set history=200
"set viminfo='100,f1

" ---------------------------------------------------------------------------
" spelling...
if v:version >= 700

  setlocal spell spelllang=en
  nmap <LocalLeader>ss :set spell!<CR>

endif
" default to no spelling
set nospell

" ---------------------------------------------------------------------------
" Turn on omni-completion for the appropriate file types.
au BufNewFile,BufRead SCons* set filetype=scons

autocmd FileType python set omnifunc=pythoncomplete#Complete
autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
autocmd FileType html set omnifunc=htmlcomplete#CompleteTags
autocmd FileType css set omnifunc=csscomplete#CompleteCSS
autocmd FileType xml set omnifunc=xmlcomplete#CompleteTags
autocmd FileType php set omnifunc=phpcomplete#CompletePHP
autocmd FileType c,cu,cc,cpp,h,hpp set omnifunc=ccomplete#Complete ai sw=2 sts=2 et
autocmd FileType ruby,eruby,yaml set omnifunc=rubycomplete#Complete ai sw=2 sts=2 et
autocmd FileType ruby,eruby,yaml let g:rubycomplete_buffer_loading = 1
autocmd FileType ruby,eruby,yaml let g:rubycomplete_rails = 1
autocmd FileType ruby,eruby,yaml let g:rubycomplete_classes_in_global = 1
autocmd BufReadPre SConstruct set filetype=python
autocmd BufReadPre SConscript set filetype=python

"improve autocomplete menu color
"highlight Pmenu ctermbg=238 gui=bold

" ---------------------------------------------------------------------------
" some useful mappings
" Omnicomplete as Ctrl+Space
inoremap <Nul> <C-x><C-o>
" Also map user-defined omnicompletion as Ctrl+k
inoremap <C-k> <C-x><C-u>
" Y yanks from cursor to $
map Y y$
" for yankring to work with previous mapping:
function! YRRunAfterMaps()
  nnoremap Y   :<C-U>YRYankCount 'y$'<CR>
endfunction
" toggle list mode
nmap <LocalLeader>tl :set list!<cr>
" toggle paste mode
nmap <LocalLeader>pp :set paste!<cr>
" change directory to that of current file
nmap <LocalLeader>cd :cd%:p:h<cr>
" change local directory to that of current file
nmap <LocalLeader>lcd :lcd%:p:h<cr>
" correct type-o's on exit
nmap q: :q
" save and build
nmap <LocalLeader>wm  :w<cr>:make<cr>
" open all folds
nmap <LocalLeader>fo  :%foldopen!<cr>
" close all folds
nmap <LocalLeader>fc  :%foldclose!<cr>
" ,tt will toggle taglist on and off
nmap <LocalLeader>t :Tlist<cr>
" ,nn will toggle NERDTree on and off
nmap <LocalLeader>n :execute 'NERDTreeToggle ' . getcwd()<cr>
" auto indent file
nmap <LocalLeader>i gg=G
" When I'm pretty sure that the first suggestion is correct
map <LocalLeader>r 1z=
" q: sucks
nmap q: :q
" map next error to CTRL-n
nmap <C-n> :cn<CR>
" map previous error to CTRL-p
nmap <C-p> :cp<CR>
" map open error windo to CTRL-e
nmap <C-e> :copen 8<CR>
" If I forgot to sudo vim a file, do that with :w!!
cmap w!! %!sudo tee > /dev/null %
" Fix the # at the start of the line
inoremap # X<BS>#
" When I forget I'm in Insert mode, how often do you type 'jj' anyway?:
inoremap jj <Esc>
inoremap jk <Esc>

" Map copy and paste shortcuts to the usual
nmap <C-V> "+gP
imap <C-V> <ESC><C-V>i
vmap <C-C> "+y
" ruby helpers
iab rbang #!/usr/bin/env ruby<cr>
iab idef def initialize

nnoremap <LocalLeader>h :set invhls hls?<CR>


" refresh - redraw window
" <F5>
nnoremap <silent><F5> :redraw!<CR>

" easy indentation in visual mode
" This keeps the visual selection active after indenting.
" Usually the visual selection is lost after you indent it.
vmap > >gv
vmap < <gv

" <F4>
" toggle mouse mode between VIM and xterm
function ShowMouseMode()
  if (&mouse == 'a')
    echo "MOUSE VIM"
  else
    echo "MOUSE X11"
  endif
endfunction
nnoremap <silent><F4> :let &mouse=(&mouse == "a"?"":"a")<CR>:call ShowMouseMode()<CR>

" Toggle line numbers
nnoremap <silent><F3> :set number!<CR>

" Toggle ruby/bash wrapping comments
map <LocalLeader>c :s/^\(.*\)$/# \1/<CR>:nohlsearch<CR>gv
map <LocalLeader>cc :s/^\(# \(.*\)\)$/\2/<CR>:nohlsearch<CR>gv

" Compile code using :comile
map <F9> :w<CR>:make<CR>

" folding using the current /search/ pattern -- very handy!
" \z
" This folds every line that does not contain the search pattern.
" So the end result is that you only see lines with the pattern
" see vimtip #282 and vimtip #108
" map <silent><LocalLeader>z :set foldexpr=getline(v:lnum)!~@/ foldlevel=0 foldcolumn=0 foldmethod=expr<CR>
nnoremap <silent><LocalLeader>z :set foldexpr=(getline(v:lnum)=~@/)?\">1\":\"=\" foldlevel=0 foldcolumn=0 foldmethod=expr foldtext=getline(v:foldstart)<CR>
" space toggles the fold state under the cursor.
nnoremap <silent><space> :exe 'silent! normal! za'.(foldlevel('.')?'':'l')<CR>
" this folds all classes and functions -- mnemonic: think 'function fold'
nnoremap <silent>zff :set foldexpr=UniversalFoldExpression(v:lnum) foldmethod=expr foldlevel=0 foldcolumn=0 foldtext=getline(v:foldstart)<CR><CR>
function UniversalFoldExpression(lnum)
  if a:lnum == 1
    return ">1"
  endif
  return (getline(a:lnum)=~"^\\s*public function\\s\\|^\\s*private function\\s\\|^\\s*function\\s\\|^\\s*class\\s\\|^\\s*def\\s") ? ">1" : "="
endfunction



function! OnlineDoc()
  if $COLORTERM =~ 'gnome-terminal'
    let s:browser = "firefox"
  else
    let s:browser = "links"
  end
  let s:wordUnderCursor = expand("<cword>")
  if &ft == "cpp" || &ft == "c" || &ft == "ruby" || &ft == "php" || &ft == "python"
    let s:url = "http://www.google.com/codesearch?q=".s:wordUnderCursor."+lang:".&ft
  elseif &ft == "vim"
    let s:url = "http://www.google.com/codesearch?q=".s:wordUnderCursor
  else
    return
  endif
  let s:cmd = "silent !" . s:browser . " " . s:url
  "echo  s:cmd
  execute  s:cmd
endfunction

" online doc search
map <LocalLeader>k :call OnlineDoc()<CR>


" Ack helpers
function! Ack(args)
  let grepprg_bak=&grepprg
  set grepprg=ack\ -H\ --nocolor\ --nogroup
  execute "silent! grep " . a:args
  botright copen
  let &grepprg=grepprg_bak
endfunction

command! -nargs=* -complete=file Ack call Ack(<q-args>)

set sr fo=roqm1 tw=80
im <C-B> <C-O>:setl sr! fo<C-R>=strpart("-+",&sr,1)<CR>=tc<CR>_<BS><Right>

" ---------------------------------------------------------------------------
" setup for the visual environment
if $COLORTERM =~ '^gnome-terminal'
  set t_Co=256
elseif $TERM =~ '^xterm'
  set t_Co=256 
elseif $TERM =~ '^screen-bce'
  set t_Co=256            " just guessing
elseif $TERM =~ '^rxvt'
  set t_Co=88
elseif $TERM =~ '^linux'
  set t_Co=8
else
  set t_Co=16
endif

" ---------------------------------------------------------------------------
" tabs
" (LocalLeader is ",")
map <LocalLeader>to :tabnew %<cr>    " create a new tab       
map <LocalLeader>tc :tabclose<cr>    " close a tab
map <LocalLeader>tn :tabnext<cr>     " next tab
"map <silent><m-Right> :tabnext<cr>           " next tab
map <LocalLeader>tp :tabprev<cr>     " previous tab
"map <silent><m-Left> :tabprev<cr>            " previous tab
map <LocalLeader>tm :tabmove         " move a tab to a new location
"map <LocalLeader>n :tabnext<cr>     " next tab
"map <LocalLeader>p :tabprev<cr>     " previous tab

" ---------------------------------------------------------------------------
" auto load extensions for different file types
if has('autocmd')
  filetype plugin indent on
  syntax on

  " jump to last line edited in a given file (based on .viminfo)
  "autocmd BufReadPost *
  "       \ if !&diff && line("'\"") > 0 && line("'\"") <= line("$") |
  "       \       exe "normal g`\"" |
  "       \ endif
  autocmd BufReadPost *
        \ if line("'\"") > 0|
        \       if line("'\"") <= line("$")|
        \               exe("norm '\"")|
        \       else|
        \               exe "norm $"|
        \       endif|
        \ endif

  " improve legibility
  au BufRead quickfix setlocal nobuflisted wrap number

  " configure various extensions
  let git_diff_spawn_mode=2

  " improved formatting for markdown
  " http://plasticboy.com/markdown-vim-mode/
  autocmd BufRead *.mkd  set ai formatoptions=tcroqn2 comments=n:>
endif

" make the popupmenu's colours less ugly (default bright pink is horrible)
"highlight   Pmenu               ctermfg=0 ctermbg=2 gui=NONE
highlight   PmenuSel            ctermfg=0 ctermbg=7 gui=NONE
highlight   PmenuSbar           ctermfg=7 ctermbg=0 gui=NONE
"highlight   PmenuThumb          ctermfg=0 ctermbg=7 gui=NONE
