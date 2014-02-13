" .vimrc
" https://github.com/todashuta/profiles

" Initialize: "{{{
"
if &compatible
  set nocompatible  " Be IMproved.
endif

" Startup time.
" See: https://gist.github.com/thinca/1518874
if has('vim_starting') && has('reltime')
  let s:startuptime = reltime()
  augroup vimrc-startuptime
    autocmd! VimEnter *
          \ echomsg 'startuptime: ' . reltimestr(reltime(s:startuptime))
  augroup END
endif

if exists('+regexpengine')
  " Use old regexp engine.
  "set regexpengine=1
endif

let s:is_term = !has('gui_running')
let s:is_linux = has('unix') && (system('uname') =~? 'linux')
let s:is_windows = has('win16') || has('win32') || has('win64')
let s:is_cygwin = has('win32unix')
let s:is_mac = !s:is_windows && !s:is_cygwin
      \ && (has('mac') || has('macunix') || has('gui_macvim') ||
      \   (!isdirectory('/proc') && executable('sw_vers')))

let s:is_reloading = !has('vim_starting')

" Use English interface.
if s:is_windows
  language message en
else
  language message C
endif

" Use English menu on MacVim.
if has('gui_macvim')
  set langmenu=none
endif

" Define <Leader>, <LocalLeader>
let g:mapleader = '\'
"let g:maplocalleader = ','

" Reset all autocmd defined in this file.
augroup MyAutoCmd
  autocmd!
augroup END

" Delete a vimrc_example's autocmd group.
silent! augroup! vimrcEx

if s:is_windows && exists('+shellslash')
  " Use a forward slash as a path separator.
  set shellslash
endif

if !exists('$MYGVIMRC')
  let $MYGVIMRC = expand('~/.gvimrc')
endif

" Anywhere SID.
function! s:SID()
  return matchstr(expand('<sfile>'), '<SNR>\zs\d\+\ze_SID$')
endfunction

function! s:SID_PREFIX()
  return printf('<SNR>%d_', s:SID())
endfunction

function! s:print_error(msg)
  echohl ErrorMsg
  echomsg a:msg
  echohl None
  "let v:errmsg = a:msg
endfunction

" Set runtimepath.
if has('vim_starting')
  if s:is_windows
    set runtimepath^=~/.vim,~/.vim/after
  endif

  " Load neobundle.
  set runtimepath+=~/.vim/bundle/neobundle.vim
endif

" neobundle log file path.
let g:neobundle#log_filename = expand('~/.neobundle_log')

" Initialize neobundle
call neobundle#rc(expand('~/.vim/bundle'))

" Github repositories.
if has('lua') && (v:version > 703 || v:version == 703 && has('patch885'))
  NeoBundleLazy 'Shougo/neocomplete.vim'
else
  NeoBundleLazy 'Shougo/neocomplcache.vim'
endif
NeoBundleLazy 'Shougo/neosnippet.vim'
NeoBundle 'Shougo/neosnippet-snippets'
NeoBundle 'honza/vim-snippets'
NeoBundleLazy 'Shougo/unite.vim', {
      \   'autoload' : {
      \     'commands' : [
      \         { 'name' : 'Unite',
      \           'complete' : 'customlist,unite#complete#source' },
      \         'UniteWithBufferDir'
      \ ]}}
NeoBundleLazy 'Shougo/vimfiler.vim'
NeoBundleLazy 'Shougo/unite-outline', {
      \   'autoload' : {
      \     'unite_sources' : 'outline'
      \ }}
NeoBundleLazy 'ujihisa/unite-colorscheme', {
      \   'autoload' : {
      \     'unite_sources' : 'colorscheme'
      \ }}
NeoBundleLazy 'ujihisa/unite-font', {
      \   'gui' : 1,
      \   'autoload' : {
      \     'unite_sources' : 'font'
      \ }}
NeoBundleLazy 'Kocha/vim-unite-tig', {
      \   'autoload' : {
      \     'unite_sources' : 'tig'
      \ }}
NeoBundleLazy 'tacroe/unite-mark', {
      \   'autoload' : {
      \     'unite_sources' : 'mark'
      \ }}
NeoBundleLazy 'tsukkee/unite-help', {
      \   'autoload' : {
      \     'unite_sources' : 'help'
      \ }}
NeoBundleLazy 'Shougo/unite-build', {
      \   'autoload' : {
      \     'unite_sources' : 'build'
      \ }}
NeoBundle 'Shougo/vimproc.vim', {
      \   'build' : {
      \     'windows' : 'make -f make_mingw32.mak',
      \     'cygwin' : 'make -f make_cygwin.mak',
      \     'mac' : 'make -f make_mac.mak',
      \     'unix' : 'make -f make_unix.mak',
      \ }}
NeoBundle 'altercation/vim-colors-solarized'
NeoBundleLazy 'othree/eregex.vim'
"NeoBundle 'scrooloose/nerdtree'
NeoBundleLazy 'thinca/vim-quickrun'
NeoBundleLazy 'tyru/open-browser.vim'
NeoBundleLazy 'h1mesuke/vim-alignta', {
      \   'autoload' : {
      \     'commands' : ['Alignta', 'Align']
      \ }}
NeoBundleLazy 'tpope/vim-surround'
"NeoBundle 'troydm/easybuffer.vim'
"NeoBundle 'vim-scripts/DirDo.vim'
NeoBundleLazy 'kana/vim-smartchr', {
      \   'autoload' : {
      \     'insert' : 1,
      \ }}
NeoBundle 'kana/vim-submode'
NeoBundleLazy 'kana/vim-niceblock'
NeoBundleLazy 'glidenote/memolist.vim', {
      \   'autoload' : {
      \     'commands' : ['MemoGrep', 'MemoList', 'MemoNew']
      \ }}
NeoBundleLazy 'hallison/vim-markdown', {
      \   'autoload' : {
      \     'filetypes' : ['markdown']
      \ }}
NeoBundleLazy 'Shougo/vimshell.vim', {
      \   'depends' : ['Shougo/vimproc.vim', 'Shougo/unite.vim'],
      \   'autoload' : {
      \     'commands' : ['VimShell', 'VimShellPop', 'VimShellInteractive']
      \ }}
NeoBundleLazy 'mattn/emmet-vim'
NeoBundleLazy 'thinca/vim-ref'
NeoBundleLazy 'mattn/calendar-vim', {
      \   'autoload' : {
      \     'commands' : ['Calendar', 'CalendarH']
      \ }}
NeoBundleLazy 'nathanaelkane/vim-indent-guides'
NeoBundleLazy 'ap/vim-css-color', {
      \   'autoload' : {
      \     'filetypes' : ['html', 'css', 'sass']
      \ }}
NeoBundleLazy 'lilydjwg/colorizer'
NeoBundleLazy 'koron/nyancat-vim', {
      \   'autoload' : {
      \     'commands' : ['Nyancat', 'Nyancat2']
      \ }}
NeoBundleLazy 'hail2u/vim-css3-syntax', {
      \   'autoload' : {
      \     'filetypes' : ['html', 'css']
      \ }}
NeoBundleLazy 'othree/html5.vim', {
      \   'autoload' : {
      \     'filetypes' : ['html', 'css']
      \ }}
NeoBundleLazy 'kana/vim-smartinput', {
      \   'autoload' : {
      \     'insert' : 1,
      \ }}
"NeoBundle 'kien/ctrlp.vim'
NeoBundleLazy 'basyura/TweetVim', {
      \   'depends' : [
      \       'basyura/twibill.vim', 'tyru/open-browser.vim'
      \   ],
      \   'autoload' : {
      \     'commands' : ['TweetVimHomeTimeline', 'TweetVimSay'],
      \     'unite_sources' : 'tweetvim',
      \ }}
"NeoBundle 'todashuta/vim-powerline', 'develop'
NeoBundle 'bling/vim-airline'
"NeoBundle 'itchyny/lightline.vim'
NeoBundleLazy 'thinca/vim-painter', {
      \   'autoload' : {
      \     'commands' : 'PainterStart'
      \ }}
NeoBundleLazy 'thinca/vim-scouter', {
      \   'autoload' : {
      \     'commands' : [
      \         { 'name' : 'Scouter', 'complete' : 'file' }
      \ ]}}
NeoBundleLazy 'thinca/vim-visualstar'
"NeoBundle 'vim-scripts/ShowMarks'
"NeoBundle 'Lokaltog/vim-easymotion'
NeoBundleLazy 'taku-o/vim-toggle'
NeoBundleLazy 'ujihisa/neco-look', {
      \   'autoload' : {
      \     'insert' : 1
      \ }}
NeoBundle 'mhinz/vim-signify'
NeoBundleLazy 'kchmck/vim-coffee-script', {
      \   'autoload' : {
      \     'filetypes' : ['coffee']
      \ }}
NeoBundleLazy 'vim-scripts/Vim-R-plugin'
NeoBundleLazy 'itchyny/thumbnail.vim', {
      \   'autoload' : {
      \     'commands' : ['Thumbnail'],
      \ }}
NeoBundleLazy 'Shougo/vinarise.vim', {
      \   'autoload' : {
      \     'commands' : [
      \         { 'name' : 'Vinarise',
      \           'complete' : 'customlist,vinarise#complete' },
      \ ]}}
NeoBundleLazy 'mattn/webapi-vim', {
      \   'autoload' : {
      \     'function_prefix' : 'webapi'
      \ }}
NeoBundleLazy 'todashuta/gcalc.vim', 'develop', {
      \   'depends' : 'mattn/webapi-vim',
      \   'autoload' : {
      \     'commands' : [
      \         { 'name' : 'GCalc',
      \           'complete' : 'custom,gcalc#complete' },
      \ ]}}
NeoBundleLazy 'todashuta/unite-transparency', {
      \   'autoload' : {
      \     'unite_sources' : 'transparency'
      \ }}
NeoBundleLazy 'jnwhiteh/vim-golang', {
      \   'autoload' : {
      \     'filetypes' : ['go']
      \ }}
NeoBundleLazy 'terryma/vim-expand-region'
NeoBundleLazy 'mfumi/snake.vim', {
      \   'autoload' : {
      \     'commands' : 'Snake'
      \ }}
NeoBundleLazy 'deris/vim-duzzle', {
      \   'autoload' : {
      \     'commands' : 'DuzzleStart'
      \ }}
NeoBundleLazy 'hrsh7th/vim-neco-calc', {
      \   'autoload' : {
      \     'insert' : 1
      \ }}
NeoBundleLazy 'thinca/vim-unite-history', {
      \   'autoload' : {
      \     'unite_sources' : ['history/command', 'history/search']
      \ }}
NeoBundleLazy 'osyo-manga/unite-filetype', {
      \   'autoload' : {
      \     'unite_sources' : 'filetype'
      \ }}
NeoBundleLazy 'mattn/habatobi-vim', {
      \   'autoload' : {
      \     'commands' : 'Habatobi'
      \ }}
NeoBundleLazy 'thinca/vim-editvar', {
      \   'autoload' : {
      \     'commands' : [
      \         { 'name' : 'Editvar',
      \           'complete' : 'var' }
      \     ],
      \     'unite_sources' : 'variable'
      \ }}
NeoBundle 'rbtnn/vimconsole.vim'
NeoBundle 'tpope/vim-fugitive'
NeoBundle 'vim-jp/vital.vim'
NeoBundleLazy 'kana/vim-textobj-user', {
      \   'autoload' : {
      \     'function_prefix' : 'textobj'
      \ }}
NeoBundleLazy 'kana/vim-textobj-indent', {
      \   'autoload' : {
      \     'mappings' : [
      \       ['xo', 'ai'], ['xo', 'ii'], ['xo', 'aI'], ['xo', 'iI']
      \ ]}}
"NeoBundle 'kana/vim-textobj-jabraces'
NeoBundleLazy 'thinca/vim-textobj-comment', {
      \   'autoload' : {
      \     'mappings' : [['xo', 'ac'], ['xo', 'ic']]
      \ }}
NeoBundleLazy 'saihoooooooo/vim-textobj-space', {
      \   'autoload' : {
      \     'mappings' : [['xo', 'aS'], ['xo', 'iS']]
      \ }}
NeoBundle 'mattn/lisper-vim'
NeoBundleLazy 'rbtnn/puyo.vim', {
      \   'autoload' : {
      \     'commands' : 'Puyo'
      \ }}
NeoBundleLazy 'deris/vim-rengbang', {
      \   'autoload' : {
      \     'function_prefix' : 'rengbang',
      \     'commands' : ['RengBang', 'RengBangUsePrev', 'RengBangConfirm']
      \ }}

if has('python')
  NeoBundleLazy 'gregsexton/VimCalc', {
        \   'autoload' : {
        \     'commands' : 'Calc'
        \ }}
  NeoBundleLazy 'vim-scripts/VOoM', {
        \   'autoload' : {
        \     'commands' : [
        \         { 'name' : 'Voom',
        \           'complete' : 'custom,voom#Complete' },
        \         { 'name' : 'VoomToggle',
        \           'complete' : 'custom,voom#Complete' },
        \         'Voomhelp', 'Voomlog', 'Voomexec'
        \ ]}}
endif

if executable('ag')
  NeoBundle 'rking/ag.vim'
endif

"if executable('mdfind')
"  NeoBundle 'choplin/unite-spotlight',
"        \ { 'depends' : 'Shougo/unite.vim' }
"endif

if has('conceal')
  NeoBundle 'Yggdroot/indentLine', 'f0d6cf942c'
endif

if s:is_windows
  NeoBundle 'istepura/vim-toolbar-icons-silk', {
        \   'gui' : 1
        \ }
endif

" Local plugins directory like pathogen. (For develop plugins, etc.)
"NeoBundleLocal ~/bundle

" Disable netrw.vim
let g:loaded_netrwPlugin = 1
" Disable vimball.vim
let g:loaded_vimballPlugin = 1
" Disable getscript.vim
let g:loaded_getscriptPlugin = 1

filetype plugin indent on    " Required!

" Installation check
"NeoBundleCheck

" Enable syntax color
syntax enable

" }}}

" Encoding: "{{{
"
" Use the UTF-8 encoding inside Vim.
set encoding=utf-8

if s:is_cygwin || (s:is_windows && s:is_term)
  set encoding=cp932 termencoding=
endif

" Must after set of 'encoding'.
scriptencoding utf-8

let s:is_unicode = (&encoding ==# 'utf-8') || (&termencoding ==# 'utf-8')

" fileencodings.
if has('iconv') && !has('kaoriya')
  let s:enc_euc = 'euc-jp'
  let s:enc_jis = 'iso-2022-jp'

  " Does iconv support JIS X 0213 ?
  if iconv("\x87\x64\x87\x6a", 'cp932', 'euc-jisx0213') ==# "\xad\xc5\xad\xcb"
    let s:enc_euc = 'euc-jisx0213,euc-jp'
    let s:enc_jis = 'iso-2022-jp-3'
  endif

  " Make fileencodings.
  let &fileencodings = 'ucs-bom'
  if &encoding !=# 'utf-8'
    let &fileencodings = &fileencodings . ',' . 'ucs-2le'
    let &fileencodings = &fileencodings . ',' . 'ucs-2'
  endif
  let &fileencodings = &fileencodings . ',' . s:enc_jis

  if &encoding ==# 'utf-8'
    let &fileencodings = &fileencodings . ',' . s:enc_euc
    let &fileencodings = &fileencodings . ',' . 'cp932'
  elseif &encoding =~# '^euc-\%(jp\|jisx0213\)$'
    let &encoding = s:enc_euc
    let &fileencodings = &fileencodings . ',' . 'utf-8'
    let &fileencodings = &fileencodings . ',' . 'cp932'
  else  " cp932
    let &fileencodings = &fileencodings . ',' . 'utf-8'
    let &fileencodings = &fileencodings . ',' . s:enc_euc
  endif
  let &fileencodings = &fileencodings . ',' . &encoding

  unlet s:enc_euc
  unlet s:enc_jis
endif

if has('guess_encode') && (&fileencodings !~# 'guess')
  set fileencodings^=guess
endif

" }}}

" General: "{{{
"
" A history of ":" commands, and a history of previous search patterns.
set history=1024
" Enable backspace delete indent and newline.
set backspace=indent,eol,start
" Allow h, l, <Left> and <Right> to move to the previous/next line.
set whichwrap=b,s,h,l,<,>,[,]
" Enable virtualedit in visual block mode.
set virtualedit& virtualedit+=block

" Splitting a window will put the new window below the current one.
set splitbelow
" Splitting a window will put the new window right of the current one.
set splitright

" Use clipboard register. (i.e. Use OS's clipboard.)
set clipboard& clipboard+=unnamed

" Enable modeline.
set modeline

" Use a mouse on terminal.
if has('mouse')
  try
    set ttymouse=sgr
  catch /^Vim\%((\a\+)\)\=:E474/
    silent! set ttymouse=xterm2
  finally
    set mouse=a
  endtry
endif

" Indicates a fast terminal connection.
set ttyfast

" Don't redraw while macro executing.
set lazyredraw

" All windows not same size after split or close.
set noequalalways

" Default end-of-line format.
set fileformat=unix
set fileformats=unix,dos,mac

" }}}

" File,Backup: "{{{
"
" Display another buffer when current buffer isn't saved.
set hidden
" Auto reload if file is changed.
set autoread
" Don't create backup files.
set nobackup noswapfile

" }}}

" Indent,Tab: "{{{
"
" Enable smart indent.
set autoindent smartindent

if has('vim_starting')
  " Number of spaces that a <Tab> in the file counts for.
  set tabstop=4
  " Number of spaces to use for each step of (auto)indent.
  set shiftwidth=4
  " See :help softtabstop
  set softtabstop=4
  " Expand tab to spaces.
  "set expandtab
endif

" Smart insert tab setting.
"set smarttab
" Round indent to multiple of 'shiftwidth'('>'and'<'commands).
set shiftround
" Disable auto wrap.
autocmd MyAutoCmd FileType * setlocal textwidth=0

" }}}

" Search: "{{{
"
" Enable incremental search.
set incsearch
" Searchs wrap around the end of the file.
set wrapscan
" Ignore the case of nornal letters.
set ignorecase
" If the search pattern contains upper case characters, override ignorecase option.
set smartcase

" Highlight search results.
set hlsearch
" Don't (re)highlighting the last search pattern on reloading.
nohlsearch

" Command-line completion operates in an enhanced mode.
set wildmenu wildmode=longest,list,full
silent! set wildignorecase

" These patterns is ignored when completing file or directory names.
"set wildignore& wildignore+=.DS_Store
"set wildignore+=*~,*.swp,*.tmp
"set wildignore+=*.bmp,*.gif,*.ico,*.jpg,*.png
" These extensions get a lower priority when multiple files match a wildcard.
set suffixes& suffixes+=.DS_Store
"set suffixes+=.tmp,.bmp,.gif,.ico,.jpg,.png

" }}}

" Key Mappings: "{{{
"
" timeout.
set timeout timeoutlen=2000 ttimeoutlen=50

inoremap <silent> <Esc>  <Esc>`^
inoremap <silent> <C-[>  <Esc>`^

" Paste.
inoremap <C-r>*  <C-o>:set paste<CR><C-r>*<C-o>:set nopaste<CR>

" Move cursor by display line.
noremap j  gj
noremap k  gk
noremap gj  j
noremap gk  k

" Stop the search highlightings and clear messages on the last line.
nnoremap <Esc><Esc>  :<C-u>nohlsearch<CR>:<BS>

" Move to the first non-blank characters of the screen line.
"noremap <expr> H  search('^\s\s*\%#', 'bcn') ? 'g0' : 'g^'
noremap <expr> H  &wrap ?
      \ (search('^\s\s*\%#', 'bcn') ? 'g0' : 'g^') : 'zH'
" Move to the last characters of the screen line.
"noremap L g$
noremap <expr> L  &wrap ?
      \ 'g$' : 'zL'

" Centering search result and open fold.
nnoremap n  nzzzv
nnoremap N  Nzzzv

" Don't move on *
nnoremap *  *N
" Don't move on #
nnoremap #  #N
" Don't move on g*
nnoremap g*  g*N
" Don't move on g#
nnoremap g#  g#N

" Centering <C-o>, <C-i>
nnoremap <C-o>  <C-o>zz
nnoremap <C-i>  <C-i>zz

" Insert close tags automatically in editing xml and html.
if exists('&omnifunc')
  autocmd MyAutoCmd FileType xml,html inoremap <buffer> </  </<C-x><C-o>
endif

" Next tab, Previous tab.
if has('gui_running')
  nnoremap <C-Tab>    gt
  nnoremap <C-S-Tab>  gT
endif
nnoremap gl  gt
nnoremap gh  gT

" Enter ';' to use command-line (Swap ':' and ';').
noremap ;  :
noremap :  ;

" <Space-CR>: line break.
nnoremap <Space><CR>  i<CR><Esc>

" Visual shifting (does not exit Visual mode)
xnoremap <  <gv
xnoremap >  >gv

" Quick shifting.
nnoremap <  <<
nnoremap >  >>

" Indent
if has('gui_running')
  xnoremap <Tab>    >gv
  xnoremap <S-Tab>  <gv
endif

" Shift + Arrow key: Resize split windows.
nnoremap <silent> <S-Left>   :<C-u>wincmd <<CR>
nnoremap <silent> <S-Right>  :<C-u>wincmd ><CR>
nnoremap <silent> <S-Up>     :<C-u>wincmd +<CR>
nnoremap <silent> <S-Down>   :<C-u>wincmd -<CR>

" <Space-=>: Make all windows equally high and wide.
nnoremap <silent> <Space>=  :<C-u>wincmd =<CR>

" Yank from the cursor to the end of line.
nnoremap Y  y$

" Command-Line mode keymappings (Emacs like)
" <C-a>: move to head.
cnoremap <C-a>    <Home>
" <C-b>: previous char.
cnoremap <C-b>    <Left>
" <C-d>: delete char.
cnoremap <C-d>    <Del>
" <C-e>: move to end.
cnoremap <C-e>    <End>
" <C-f>: next char.
cnoremap <C-f>    <Right>
" <C-n>: next history.
cnoremap <C-n>    <Down>
" <C-p>: previous history.
cnoremap <C-p>    <Up>
" <C-k>: delete to end.
cnoremap <C-k>  <C-\>e getcmdpos() == 1 ?
      \ '' :  getcmdline()[: getcmdpos()-2]<CR>
" <C-y>:  paste.
cnoremap <C-y>    <C-r>*

" Release Space Key for Mappings below. (not required)
nnoremap <Space>  <Nop>

" Quick edit and reload .vimrc/.gvimrc
nnoremap <silent> <Space>..  :<C-u>tabedit $MYVIMRC<CR>
nnoremap <silent> <Space>.g  :<C-u>tabedit $MYGVIMRC<CR>
nnoremap <silent> <Space>R   :<C-u>source $MYVIMRC
                              \ \| if has('gui_running')
                              \ \|   source $MYGVIMRC
                              \ \| endif <CR>

" toggle-option prefix key.
nmap <Space>t  [toggle]
nnoremap [toggle]  <Nop>

" Toggle hlsearch
nnoremap <silent> [toggle]h
      \ :<C-u>call <SID>toggle_option('hlsearch')<CR>
" Toggle wrap
nnoremap <silent> [toggle]w
      \ :<C-u>call <SID>toggle_option('wrap')<CR>
" Toggle cursorline.
nnoremap <silent> [toggle]-
      \ :<C-u>call <SID>toggle_option('cursorline')<CR>
" Toggle cursorcolumn.
nnoremap <silent> [toggle]<Bar>
      \ :<C-u>call <SID>toggle_option('cursorcolumn')<CR>
" Toggle list
nnoremap <silent> [toggle]l
      \ :<C-u>call <SID>toggle_option('list')<CR>
" Toggle wrapscan
nnoremap <silent> [toggle]/
      \ :<C-u>call <SID>toggle_option('wrapscan')<CR>
" Toggle line number.
nnoremap <silent> [toggle]n
      \ :<C-u>call <SID>toggle_line_number()<CR>
" Toggle Paste.
nnoremap <silent> [toggle]p
      \ :<C-u>call <SID>toggle_option('paste')<CR>:set mouse=<CR>
" Toggle mouse.
nnoremap <silent> [toggle]m
      \ :<C-u>exe'set'&mouse=='a'?'mouse=':'mouse=a'<CR>:set mouse?<CR>

" Look see registers.
"nnoremap <silent> <Space>r
"      \ :<C-u>registers<CR>
" Look see marks.
"nnoremap <silent> <Space>m
"      \ :<C-u>marks<CR>

" Lookup help three times more than regular speed.
nnoremap <C-h>  :<C-u>help<Space>

" <Space>c: close current window nimbly.
nnoremap <silent> <Space>c  :<C-u>close<CR>
" <Space>o: close all other windows nimbly.
nnoremap <silent> <Space>o  :<C-u>only<CR>

" Split window.
nnoremap <silent> <Space>s  :<C-u>split<CR>
nnoremap <silent> <Space>v  :<C-u>vsplit<CR>

" buffer operation prefix key.
nmap <Space>b  [buffer]
nnoremap [buffer]  <Nop>

" <Space-bb>: go to the alternate buffer.
nnoremap <silent> [buffer]b  :<C-u>b#<CR>
" <Space-bp>: go to the previous buffer.
nnoremap <silent> [buffer]p  :<C-u>bprevious<CR>
" <Space-bn>: go to the next buffer.
nnoremap <silent> [buffer]n  :<C-u>bnext<CR>
" <Space-bt>: thumbnail-style buffer select.
nnoremap <silent> [buffer]t  :<C-u>Thumbnail -here<CR>
" <Space-BS>: Unload buffer and delete it from the buffer list.
nnoremap <silent> <Space><BS>  :<C-u>bdelete<CR>

nnoremap q  <Nop>
nnoremap Q  q
nnoremap K  <Nop>
"nnoremap qK  K

" Disable dangerous ZZ.
nnoremap ZZ  :<C-u>call <SID>print_error('ZZ is disabled.')<CR>
" Disable dangerous ZQ.
nnoremap ZQ  :<C-u>call <SID>print_error('ZQ is disabled.')<CR>

" Moving cursor to other windows.
nnoremap <silent> <Space>h  :<C-u>wincmd h<CR>
nnoremap <silent> <Space>j  :<C-u>wincmd j<CR>
nnoremap <silent> <Space>k  :<C-u>wincmd k<CR>
nnoremap <silent> <Space>l  :<C-u>wincmd l<CR>

nmap <Space><Space>  [Space2]
nnoremap [Space2]  <Nop>

nnoremap <silent> [Space2]h
      \ :<C-u>wincmd h<CR>:resize<CR>:vertical resize<CR>
nnoremap <silent> [Space2]j
      \ :<C-u>wincmd j<CR>:resize<CR>:vertical resize<CR>
nnoremap <silent> [Space2]k
      \ :<C-u>wincmd k<CR>:resize<CR>:vertical resize<CR>
nnoremap <silent> [Space2]l
      \ :<C-u>wincmd l<CR>:resize<CR>:vertical resize<CR>
nnoremap <silent> [Space2]c
      \ :<C-u>lcd %:p:h<CR>:echo 'lcd ' . expand('%:p:h')<CR>
nnoremap <silent> [Space2]b  :<C-u>Unite buffer<CR>

" (visual mode) p: Paste from the last yank.
xnoremap p  "0p
" (visual mode) P: Original visual mode 'p' behavior.
xnoremap P  p

" x, X: Delete into the blackhole register to not clobber the last yank.
nnoremap x  "_x
nnoremap X  "_X

" c: Change into the blackhole register to not clobber the last yank.
nnoremap c  "_c

" (visual mode) v: Rotate wise of visual mode.
xnoremap <expr> v  <SID>keys_to_rotate_wise_of_visual_mode()
function! s:keys_to_rotate_wise_of_visual_mode()
  let is_loop = get(g:, 'VisualModeRotation_enable_loop', 0)

  if mode() ==# 'v'
    return 'V'
  elseif mode() ==# 'V'
    return "\<C-v>"
  elseif mode() ==# "\<C-v>"
    return is_loop ? 'v' : "\<Esc>"
  endif
endfunction

" Settings for markdown
autocmd MyAutoCmd FileType markdown
      \ call s:on_FileType_markdown()
function! s:on_FileType_markdown()
  " Insert space sensibly after '-', '+', '*', '>'.
  inoremap <buffer><expr> -
        \ search('^\s*\%(-\s\)*\%#', 'bcn') ?
        \   smartchr#one_of('- ', '-') : '-'
  inoremap <buffer><expr> +
        \ search('^\s*\%(+\s\)*\%#', 'bcn') ?
        \   smartchr#one_of('+ ', '+') : '+'
  inoremap <buffer><expr> *
        \ search('^\s*\%(\*\s\)*\%#', 'bcn') ?
        \   smartchr#one_of('* ', '*') : '*'
  inoremap <buffer><expr> >
        \ search('^\s*\%(>\s\)*\%#', 'bcn') ?
        \   smartchr#one_of('> ', '>') : '>'

  " Insert space sensibly after '#', '.'.
  inoremap <buffer><expr> #
        \ search('^\s*\%(##*\s\)\?\%#', 'bcn') ?
        \   smartchr#one_of('# ', '## ') : '#'
  inoremap <buffer><expr> .
        \ search('^\s*[0-9][0-9]*\%(\.\s\)\?\%#', 'bcn') ?
        \   smartchr#one_of('. ', '.') : '.'
endfunction

" <C-f>, <C-b>: page move.
"inoremap <expr> <C-f>  pumvisible() ? "\<PageDown>" : "\<Right>"
inoremap <C-f>  <Right>
"inoremap <expr> <C-b>  pumvisible() ? "\<PageUp>" : "\<Left>"
inoremap <C-b>  <Left>
" <C-a>: Move to head+.
inoremap <expr> <C-a>
      \ search('^\s\s*\%#', 'bcn') ? "\<C-o>g0" : "\<C-o>g^"
" <C-e>: Move to end.
"inoremap <C-e>  <End>

" }}}

" Visual: "{{{
"
" Set title of the window to the value of 'titlestring'.
set title
" Enable 256 color terminal.
set t_Co=256
" Color scheme (Don't override colorscheme.)
"if s:is_term && (!exists('g:colors_name') || has('vim_starting'))
"  colorscheme solarized
"endif
" Number of screen lines to use for the command-line.
set cmdheight=1
" Show (partial) command in the last line of the screen.
set showcmd
" Minimal number of screen lines to keep above and below the cursor.
set scrolloff=2
" Disable bell.
set visualbell t_vb=
" A fullwidth character is displayed in vim properly.
silent! set ambiwidth=double

if has('conceal')
  set conceallevel=2 concealcursor=ni
endif

" Show the line and column number of the cursor position.
"set ruler

" When a bracket is inserted, briefly jump to the matching one.
set showmatch matchtime=3
" Highlight a pair of <>.
set matchpairs& matchpairs+=<:>

" When a last line is long, do not omit it in @.
set display& display+=lastline

" The height of popup menu.
set pumheight=15

" colorcolumn.
" http://hanschen.org/2012/10/24/
" http://stackoverflow.com/questions/2447109/showing-a-different-background-colour-in-vim-past-80-characters
if exists('+colorcolumn')
  function! s:get_colorcolumns(start)
    let end = a:start + 255
    return (a:start == 0) ?
          \ '' : join(range(a:start, end), ',')
  endfunction

  if has('vim_starting')
    let &colorcolumn = s:get_colorcolumns(79)
  endif

  " Toggle colorcolumn.
  nnoremap <silent> [toggle]cc
        \ :<C-u>let &colorcolumn =
        \   empty(&colorcolumn) ? <SID>get_colorcolumns(79) : ''<CR>
endif

let s:listchars = {
      \   'classic' : 'tab:>-,trail:-,eol:$,extends:>,precedes:<,nbsp:%',
      \   'modern'  : 'tab:▸ ,trail:›,precedes:«,extends:»,nbsp:␣'
      \ }

if has('vim_starting')  " Don't reset twice on reloading.
  " Indicate tab, wrap, trailing spaces and eol or not.
  set list
  " Strings to use in 'list' mode and for the :list command.
  let &listchars = s:is_unicode ?
        \ s:listchars['modern'] : s:listchars['classic']

  " Line number.
  if (v:version >= 704)
    " Show relativenumber with absolute line number on cursor line.
    set relativenumber number
  else
    set number
    "set relativenumber
  endif

  " Lines longer than the width of the window will wrap.
  set wrap
  " Highlight cursor line.
  set cursorline
endif

" Highlight cursor line sensibly only current window.
autocmd MyAutoCmd WinEnter *
      \ let &l:cursorline = get(w:, 'save_cursorline', &cursorline)
autocmd MyAutoCmd WinLeave *
      \ let [w:save_cursorline, &l:cursorline] = [&l:cursorline, 0]

" Highlight cursor column sensibly only current window.
autocmd MyAutoCmd WinEnter *
      \ let &l:cursorcolumn = get(w:, 'save_cursorcolumn', &cursorcolumn)
autocmd MyAutoCmd WinLeave *
      \ let [w:save_cursorcolumn, &l:cursorcolumn] = [&l:cursorcolumn, 0]

" Current window colorcolumn.
autocmd MyAutoCmd WinEnter *
      \ let &l:colorcolumn = get(w:, 'save_colorcolumn', &colorcolumn)
autocmd MyAutoCmd WinLeave *
      \ let [w:save_colorcolumn, &l:colorcolumn] = [&l:colorcolumn, 0]

" }}}

" Status Line: "{{{
"
" Show statusline always.
set laststatus=2

" Set statusline.
"function! s:my_statusline()
"  let is_wide = (&columns >= 80)
"
"  let _ = []
"  " Paste mode Indicator.
"  let _ += [&paste ? (is_wide ? '[PASTE] ' : '[P]') : '']
"  " Buffer number.
"  let _ += ['[%2n]']
"  " File path / File name.
"  let _ += [is_wide ? ' %<%F' : '%<%t']
"  " Modified flag, Readonly flag, Help flag, Preview flag.
"  let _ += ['%m%r%h%w']
"  " Separation point between left and right, and Space.
"  let _ += ['%=  ']
"  " Filetype, Fileencoding, Fileformat.
"  let _ += [is_wide
"        \ ? printf('[%s][%s][%s]',
"        \          (strlen(&filetype) ? &filetype : 'no ft'),
"        \          (empty(&fileencoding) ? &encoding : &fileencoding),
"        \          &fileformat
"        \         )
"        \ : printf('[%s:%s:%s]', &filetype, &fileencoding, &fileformat)]
"  " Cursor position. (Numbers of lines in buffer)
"  let _ += [is_wide ? ' [%4l/%L:%3v]' : '[%3l:%2v]']
"  " Percentage through file in lines as in |CTRL-G|.
"  let _ += [' %3p%% ']
"
"  return join(_, '')
"endfunction
"
"let &statusline = '%!'.s:SID_PREFIX().'my_statusline()'

" }}}

" Highlight japanese zenkaku space. "{{{
"
function! s:highlight_zenkaku_space()
  highlight ZenkakuSpace term=underline ctermbg=64 guibg=#719e07
  match ZenkakuSpace /　/
endfunction
autocmd MyAutoCmd VimEnter,WinEnter,ColorScheme *
      \ call s:highlight_zenkaku_space()

if s:is_reloading
  call s:highlight_zenkaku_space()
endif

" }}}

" Encoding commands: "{{{
"
" Reopen as each encodings
command! -bang -bar -complete=file -nargs=? Utf8
      \ edit<bang> ++enc=utf-8 <args>
command! -bang -bar -complete=file -nargs=? Iso2022jp
      \ edit<bang> ++enc=iso-2022-jp <args>
command! -bang -bar -complete=file -nargs=? Cp932
      \ edit<bang> ++enc=cp932 <args>
command! -bang -bar -complete=file -nargs=? Eucjp
      \ edit<bang> ++enc=euc-jp <args>
command! -bang -bar -complete=file -nargs=? Utf16
      \ edit<bang> ++enc=ucs-2le <args>
command! -bang -bar -complete=file -nargs=? Utf16be
      \ edit<bang> ++enc=ucs-2 <args>

" Change encoding commands
command! ChgEncUtf8      setlocal fileencoding=utf-8
command! ChgEncSjis      setlocal fileencoding=sjis
command! ChgEncEucjp     setlocal fileencoding=euc-jp
command! ChgEncIso2022jp setlocal fileencoding=iso-2202-jp
command! ChgEncCp932     setlocal fileencoding=cp932

" }}}

" While entering insert mode, disable hlsearch temporary. {{{
"
autocmd MyAutoCmd InsertEnter * setlocal nohlsearch
autocmd MyAutoCmd InsertLeave * setlocal hlsearch

" }}}

" On diff mode, diffupdate automatically when insert leave. {{{
"
autocmd MyAutoCmd InsertLeave *
      \ if &diff | diffupdate | echo 'diffupdated' | endif

" }}}

" Automatic paste disable. {{{
"
autocmd MyAutoCmd InsertLeave *
      \ if &paste | set nopaste mouse=a | echo 'nopaste' | endif

" }}}

" Restore cursor position. {{{
"
function! s:restore_cursor_position()
  if line("'\"") > 1 && line("'\"") <= line("$")
    execute 'normal! g`"'
  endif
endfunction

autocmd MyAutoCmd BufReadPost * call s:restore_cursor_position()

" }}}

" Plugin: "{{{
"
" neocomplete.vim {{{

if neobundle#tap('neocomplete.vim')
  call neobundle#config({
        \   'autoload' : {
        \     'insert' : 1,
        \ }})

  function! neobundle#tapped.hooks.on_source(bundle)
    " Use neocomplete.
    let g:neocomplete#enable_at_startup = 1
    " Use smartcase.
    let g:neocomplete#enable_smart_case = 1
    " Use fuzzy completion.
    let g:neocomplete#enable_fuzzy_completion = 1
    " Set minimum syntax keyword length.
    let g:neocomplete#sources#syntax#min_keyword_length = 3

    " mappings {{{
    " <CR>: Close popup and save indent.
    imap <expr> <CR>
          \ neocomplete#smart_close_popup() . "\<Plug>(smartinput_CR)"
    " For no insert <CR> key.
    "imap <expr> <CR> pumvisible() ?
    "      \ neocomplete#close_popup() : "\<Plug>(smartinput_CR)"

    " <Tab>: completion.
    inoremap <expr> <Tab>  pumvisible() ? "\<C-n>" : "\<Tab>"
    " <Shift-Tab>: Reverse completion.
    inoremap <expr> <S-Tab>  pumvisible() ? "\<C-p>" : "\<C-h>"

    " <C-g>: Undo completion.
    inoremap <expr><C-g>  neocomplete#undo_completion()
    " <C-l>: Complete common string.
    inoremap <expr><C-l>  neocomplete#complete_common_string()

    " <C-h>, <BS>: Close popup and delete backward char.
    imap <expr> <C-h>
          \ neocomplete#smart_close_popup() . "\<Plug>(smartinput_C-h)"
    imap <expr> <BS>
          \ neocomplete#smart_close_popup() . "\<Plug>(smartinput_BS)"

    " <C-e>: Close popup and move to end.
    inoremap <expr> <C-e>  neocomplete#close_popup() . "\<End>"
    " <C-y>: paste.
    "inoremap <expr> <C-y>
    "      \ pumvisible() ? neocomplete#close_popup() : "\<C-r>\""

    " Filename completion.
    "inoremap <expr> <C-x><C-f>
    "      \ neocomplete#start_manual_complete('filename_complete')

    " }}}
  endfunction

  call neobundle#untap()
endif

" }}}

" neocomplcache.vim {{{

if neobundle#tap('neocomplcache.vim')
  call neobundle#config({
        \   'autoload' : {
        \     'insert' : 1,
        \ }})

  function! neobundle#tapped.hooks.on_source(bundle)
    " Launches neocomplcache automatically on vim startup.
    let g:neocomplcache_enable_at_startup = 1
    " AutoCompPop like behavior.
    "let g:neocomplcache_enable_auto_select = 1
    " The number of candidates in popup menu. (Default: 100)
    "let g:neocomplcache_max_list = 20
    " Close preview window automatically.
    let g:neocomplcache_enable_auto_close_preview = 1
    " Use smartcase.
    let g:neocomplcache_enable_smart_case = 1
    " Define dictionary.
    let g:neocomplcache_dictionary_filetype_lists = {
          \ 'default' : '',
          \ 'vimshell' : expand('~/.vimshell/command-history')
          \ }
    let g:neocomplcache_vim_completefuncs = {
          \ 'Ref' : 'ref#complete',
          \ 'Unite' : 'unite#complete#source',
          \ 'VimShell' : 'vimshell#complete'
          \ }

    " mappings {{{
    " <CR>: Close popup and save indent.
    imap <expr> <CR>
          \ neocomplcache#smart_close_popup() . "\<Plug>(smartinput_CR)"
    " For no inserting <CR> key.
    "imap <expr> <CR>  pumvisible() ?
    "      \ neocomplcache#close_popup() : "\<Plug>(smartinput_CR)"

    " <Tab>: completion.
    inoremap <expr> <Tab>  pumvisible() ? "\<C-n>" : "\<Tab>"
    " <Shift-Tab>: Reverse completion.
    inoremap <expr> <S-Tab>  pumvisible() ? "\<C-p>" : "\<C-h>"

    " <C-g>: Undo completion.
    inoremap <expr> <C-g>  neocomplcache#undo_completion()
    " <C-l>: Complete common string.
    inoremap <expr> <C-l>  neocomplcache#complete_common_string()

    " <C-h>, <BS>: Close popup and delete backward char.
    imap <expr> <C-h>
          \ neocomplcache#smart_close_popup() . "\<Plug>(smartinput_C-h)"
    imap <expr> <BS>
          \ neocomplcache#smart_close_popup() . "\<Plug>(smartinput_BS)"

    " <C-e>: Close popup and move to end.
    inoremap <expr> <C-e>  neocomplcache#close_popup() . "\<End>"
    " <C-y>: paste.
    "inoremap <expr> <C-y>
    "      \ pumvisible() ? neocomplcache#close_popup() : "\<C-r>\""

    " Filename completion.
    inoremap <expr> <C-x><C-f>
          \ neocomplcache#start_manual_complete('filename_complete')

    " }}}
  endfunction

  call neobundle#untap()
endif

" }}}

" neosnippet.vim {{{

if neobundle#tap('neosnippet.vim')
  call neobundle#config({
        \   'autoload' : {
        \     'insert' : 1,
        \ }})

  function! neobundle#tapped.hooks.on_source(bundle)
    " Plugin key-mappings.
    imap <C-k>  <Plug>(neosnippet_expand_or_jump)
    smap <C-k>  <Plug>(neosnippet_expand_or_jump)

    " Honza's Snippets.
    let snippets_dir = [expand('~/.vim/bundle/vim-snippets/snippets')]
    " User-defined snippet files directory.
    let snippets_dir += [expand('~/.vim/snippets')]

    let g:neosnippet#snippets_directory = join(snippets_dir, ',')

    " Enable preview window feature in neosnippet candidates.
    "let g:neosnippet#enable_preview = 1
    " If you are using neosnippet with neocomplcache, I recommend this config:
    " let g:neocomplcache_enable_auto_close_preview = 1

    " Enable snipMate compatibility feature.
    let g:neosnippet#enable_snipmate_compatibility = 1
  endfunction

  call neobundle#untap()
endif

" }}}

" emmet-vim {{{

if neobundle#tap('emmet-vim')
  call neobundle#config({
        \   'autoload' : {
        \     'filetypes' : ['html', 'css']
        \ }})

  function! neobundle#tapped.hooks.on_source(bundle)
    let g:user_emmet_leader_key = has('gui_running') ? '<C-Space>' : '<C-@>'
    let g:user_emmet_settings = {
          \   'lang' : 'ja',
          \   'indentation' : "\t",
          \   'html' : {
          \     'filters' : 'html',
          \   },
          \   'css' : {
          \     'filters' : 'fc',
          \   },
          \ }
    let g:emmet_html5 = 1
  endfunction

  call neobundle#untap()
endif

" }}}

" eregex.vim {{{

if neobundle#tap('eregex.vim')
  call neobundle#config({
        \   'autoload' : {
        \     'commands' : ['E2v', 'M', 'S', 'G', 'V']
        \ }})

  "nnoremap /  :M/
  "nnoremap ?  :M?
  nnoremap ,/  :M/
  nnoremap ,?  :M?

  function! neobundle#tapped.hooks.on_source(bundle)
    " Default disable.
    let g:eregex_default_enable = 0
  endfunction

  call neobundle#untap()
endif

" }}}

" NERDTree {{{

" NERDTreeToggle
"nnoremap <silent> <Space>f
"      \ :<C-u>NERDTreeToggle<CR>
" Disables display of the 'Bookmarks' and 'help'.
"let g:NERDTreeMinimalUI = 1
" Display hidden files (i.e. "dot files").
"let g:NERDTreeShowHidden = 1

" }}}

" unite.vim {{{

" The height of unite window it's split horizontally.
autocmd MyAutoCmd VimEnter,VimResized * let g:unite_winheight = &lines/2

" Unite prefix key.
nmap <Space>u  [unite]
nnoremap [unite]  <Nop>

" Unite source.
nnoremap <silent> [unite]u
      \ :<C-u>Unite source<CR>
" Buffers. (Unite buffer)
nnoremap <silent> [unite]b
      \ :<C-u>Unite buffer -buffer-name=Buffers<CR>
" Files. (Unite file)
nnoremap <silent> [unite]f
      \ :<C-u>UniteWithBufferDir file -buffer-name=Files<CR>
" Recently used files. (Unite file_mru)
nnoremap <silent> [unite]r
      \ :<C-u>Unite file_mru -buffer-name=Recent<CR>
" Registers. (Unite register)
nnoremap <silent> [unite]p
      \ :<C-u>Unite register -buffer-name=Registers<CR>
" Marks. (Unite mark)
nnoremap <silent> [unite]m
      \ :<C-u>Unite mark -buffer-name=Marks<CR>
" All (Unite buffer file_mru bookmark file)
nnoremap <silent> [unite]a
      \ :<C-u>Unite buffer file_mru bookmark file
      \ -buffer-name=All -hide-source-names<CR>
" Unite outline
nnoremap <silent> <Space>-
      \ :<C-u>Unite outline -buffer-name=Outline<CR>
" TweetVim
nnoremap <silent> [unite]t
      \ :<C-u>Unite tweetvim -buffer-name=TweetVim<CR>

let bundle = neobundle#get('unite.vim')
  function! bundle.hooks.on_source(bundle)

    " Unite buffer will be in Insert Mode immediately.
    let g:unite_enable_start_insert = 1
    " Split position.
    "let g:unite_split_rule = 'botright'
    " Pretty prompt
    let g:unite_prompt = "(*'-')> "

    " unite-build: error or warning markup icon (enabled only in GVim).
    let g:unite_build_error_icon =
          \ expand('~/.vim/signs/err.').(s:is_windows ? 'bmp' : 'png')
    let g:unite_build_warning_icon =
          \ expand('~/.vim/signs/warn.').(s:is_windows ? 'bmp' : 'png')

    autocmd MyAutoCmd FileType unite
          \ call s:on_FileType_unite()
    function! s:on_FileType_unite()
      silent! syntax clear IndentLine

      " <C-w>: Deletes a path upward.
      imap <buffer> <C-w>  <Plug>(unite_delete_backward_path)
      " <Tab>: Goes to the next candidate, or goes to the top from the bottom.
      "imap <buffer> <Tab>  <Plug>(unite_select_next_line)

      " <Esc-Esc>: Exit unite buffer.
      nmap <buffer> <Esc><Esc>  <Plug>(unite_exit)
      imap <buffer> <Esc><Esc>  <Esc><Plug>(unite_exit)
    endfunction

    " unite-action quicklook
    if executable('qlmanage')
      let quicklook = {
            \   'description' : 'qlmanage -p {word}',
            \   'is_selectable' : 1,
            \   'is_quit' : 0,
            \ }
      function! quicklook.func(candidates)
        for l:candidate in a:candidates
          call system('qlmanage -p '.l:candidate.action__path)
        endfor
      endfunction
      call unite#custom_action('openable', 'quicklook', quicklook)
      unlet quicklook
    endif

    " Use ag in unite grep source.
    " See: http://qiita.com/items/c8962f9325a5433dc50d
    if executable('ag')
      let g:unite_source_grep_command = 'ag'
      let g:unite_source_grep_default_opts = '--nocolor --nogroup --column'
      let g:unite_source_grep_recursive_opt = ''
      "let g:unite_source_grep_max_candidates = 200
    endif

  endfunction
unlet bundle

" Unite search
nnoremap <silent> [unite]/
      \ :<C-u>Unite line/fast -buffer-name=Search
      \ -start-insert -auto-preview -no-split<CR>

let g:unite_source_menu_menus = {}

let g:unite_source_menu_menus.shortcut = {
      \ 'description' : 'Useful shortcuts.',
      \ 'command_candidates' : [
      \     ['Edit vimrc', 'edit $MYVIMRC'],
      \     ['Edit gvimrc', 'edit $MYGVIMRC'],
      \     ['Reload vimrc', 'source $MYVIMRC'],
      \     ['NeoBundle', 'Unite source -input=neobundle\ '],
      \     ['NeoBundleUpdate',
      \             'Unite neobundle/update -log -no-start-insert -wrap'],
      \     ['VimShell shortcuts', 'Unite menu:vimshell'],
      \     ['Encoding', 'Unite menu:encoding'],
      \     ['Outline vertical', 'Unite outline
      \             -no-quit -vertical -winwidth=30 -no-start-insert'],
      \     ['unite-output:message', 'Unite output:message'],
      \     ['tig', 'Unite tig -no-start-insert'],
      \     ['All mappings', 'Unite output:map|map!|lmap -no-start-insert'],
      \     ['Unite Beautiful Attack', 'Unite -auto-preview colorscheme'],
      \     ['transparency',
      \             'Unite -auto-preview -no-start-insert transparency'],
      \     ['Nyancat!!', 'Nyancat2'],
      \     ['Check system uptime', '!uptime'],
      \     ['Check system swap file', '!du -hc /var/vm/swapfile*'],
      \     ['Tweet', 'TweetVimSay'],
      \     ['earthquake.gem', 'VimShellInteractive earthquake'],
      \ ]}
nnoremap <silent> [unite]e
      \ :<C-u>Unite menu:shortcut -buffer-name=Shortcut<CR>

let g:unite_source_menu_menus.vimshell = {
      \ 'description' : 'VimShellInteractive shortcuts.',
      \ 'command_candidates' : [
      \     [' 1. irb (Ruby)', 'VimShellInteractive irb'],
      \     [' 2. pry (Ruby)', 'VimShellInteractive pry'],
      \     [' 3. python', 'VimShellInteractive python'],
      \     [' 4. Perl', 'VimShellInteractive perl -de 1'],
      \     [' 5. php', 'VimShellInteractive php -a'],
      \     [' 6. MySQL', 'VimShellInteractive mysql -u root -p'],
      \     [' 7. R', 'VimShellInteractive R'],
      \     [' 8. VimShell', 'VimShell'],
      \     [' 9. VimShellPop', 'VimShellPop'],
      \     ['10. VimShellSendString', 'VimShellSendString'],
      \ ]}
nnoremap <silent> [unite]s
      \ :<C-u>Unite menu:vimshell -buffer-name=VimShell<CR>

let g:unite_source_menu_menus.encoding = {
      \ 'description' : 'Open with a specific character code again.',
      \ 'command_candidates' : [
      \     ['UTF-8', 'Utf8'],
      \     ['ISO-2022-JP', 'Iso2022jp'],
      \     ['CP932', 'Cp932'],
      \     ['EUC-JP', 'Eucjp'],
      \     ['UTF-16', 'Utf16'],
      \     ['UTF-16-BE', 'Utf16be'],
      \ ]}

let g:unite_source_menu_menus.unite = {
      \ 'description' : 'Start unite sources',
      \ 'command_candidates' : [
      \     ['colorscheme',
      \             'Unite colorscheme -auto-preview -no-start-insert'],
      \     ['outline', 'Unite outline -no-start-insert'],
      \     ['mark', 'Unite mark -no-start-insert'],
      \     ['build', 'Unite build -no-start-insert'],
      \     ['transparency',
      \             'Unite transparency -auto-preview -no-start-insert'],
      \     ['', ''],
      \     ['', ''],
      \ ]}

" }}}

" SOLARIZED {{{

" Disable Solarized Menu.
let g:solarized_menu = 0
" Visibility of `listchars' (normal, high, low)
let g:solarized_visibility = 'low'
" Toggle background key (Light or Dark)
call togglebg#map('<F5>')

function! s:set_colorscheme_nicely()
  let background = 'dark'
  let colorscheme = 'hybrid'
  let g:solarized_termcolors = 256
  let g:Powerline_colorscheme = 'default'

  if exists('$ITERM_PROFILE') && ($ITERM_PROFILE =~? 'solarized')
    let colorscheme = 'solarized'
    let g:solarized_termcolors = 16
    let g:Powerline_colorscheme = 'solarized16'

    if ($ITERM_PROFILE =~? 'light')
      let background = 'light'
      let g:Powerline_colorscheme = 'solarized'
    endif
  endif

  let &background = background
  execute 'colorscheme' colorscheme
endfunction
if s:is_term && has('vim_starting')
  call s:set_colorscheme_nicely()
endif

" }}}

" vim-smartchr {{{

let bundle = neobundle#get('vim-smartchr')
  function! bundle.hooks.on_source(bundle)

    "inoremap <expr> =  smartchr#one_of(' = ', ' == ', ' === ', '=')
    inoremap <expr> ,  smartchr#one_of(', ', ',')

    augroup MyAutoCmd
      "autocmd FileType vim
      "      \ inoremap <expr> :  smartchr#one_of(' : ', ':')
    augroup END

    "inoremap <expr> :  smartchr#one_of(': ', ' : ', ':')
    "inoremap <buffer> <expr> .  smartchr#loop('.',  ' . ',  '..', '...')

    "augroup MyAutoCmd
    "  autocmd FileType css inoremap <expr> :  smartchr#one_of(':')
    "augroup END
    augroup MyAutoCmd
      autocmd FileType R
            \ inoremap <buffer><expr> <  smartchr#one_of('<', '<-', '<<')
    augroup END

  endfunction
unlet bundle

" }}}

" vim-indent-guides {{{

if neobundle#tap('vim-indent-guides')
  call neobundle#config({
        \   'autoload' : {
        \     'mappings' : [['n', '<Plug>IndentGuidesToggle']],
        \ }})

  nmap <silent> <Leader>ig  <Plug>IndentGuidesToggle

  function! neobundle#tapped.hooks.on_source(bundle)
    "let g:indent_guides_enable_on_vim_startup = 1
    let g:indent_guides_color_change_percent = 30
    let g:indent_guides_guide_size = 1
  endfunction

  call neobundle#untap()
endif

" }}}

" netrw.vim "{{{
"
" Tree style listing.
"let g:netrw_liststyle = 3
" Change from left splitting to right splitting.
"let g:netrw_altv = 1
" Change from above splitting to below splitting.
"let g:netrw_alto = 1
" Hiding files pattern. (Regular expression, comma separated.)
"let g:netrw_list_hide = '.DS_Store'

" }}}

" vim-powerline {{{
"
if neobundle#tap('vim-powerline')
  "let g:Powerline_symbols = 'fancy'    " Requires a patched font.
  "let g:Powerline_cache_enabled = 0
  let g:Powerline_stl_path_style = 'short'
  let g:Powerline_dividers_override = s:is_windows ?
        \ ['', '', '', '<'] : ['', '', '', "\u276e"]
  let g:Powerline_symbols_override = {
        \   'BRANCH' : '',
        \   'LINE' : ''
        \ }

  function! s:update_powerline()
    if !exists(':PowerlineReloadColorscheme')
      return
    endif

    let g:Powerline_colorscheme = (g:colors_name == 'solarized')
          \ ? ((&background == 'light') ? 'solarized' : 'solarized16')
          \ : 'default'
    "PowerlineClearCache
    PowerlineReloadColorscheme
  endfunction

  " Reload Powerline automatically after loading a color scheme.
  autocmd MyAutoCmd ColorScheme * silent call s:update_powerline()
  " Reload Powerline automatically when the Vim start-up.
  "autocmd MyAutoCmd VimEnter * silent call s:update_powerline()

  " Finalize Powerline. (Reset Powerline colorscheme for next time)
  if s:is_term && exists('$ITERM_PROFILE')
    autocmd MyAutoCmd VimLeave * call s:set_colorscheme_nicely()
          \| silent call s:update_powerline()
  endif

  " No need to show mode due to Powerline.
  set noshowmode

  call neobundle#untap()
endif

" }}}

" vim-airline {{{

if neobundle#tap('vim-airline')
  set noshowmode
  "let g:airline_theme = 'powerlineish'
  let g:airline_left_sep = ''
  let g:airline_right_sep = ''
  "let g:airline_left_sep = '▶'
  "let g:airline_right_sep = '◀'
  let g:unite_force_overwrite_statusline = 0
  let g:vimfiler_force_overwrite_statusline = 0

  call neobundle#untap()
endif

" }}}

" vimshell.vim {{{

silent! noremap <silent> <Space>r
      \ :<C-u>echo '<Space-r>: Not defined.'<CR>

let bundle = neobundle#get('vimshell.vim')
  function! bundle.hooks.on_source(bundle)

    noremap <silent> <Space>r
          \ :VimShellSendString<CR>

    " Prompt.
    function! s:vimshell_my_prompt()
      return s:is_windows
            \ ? printf('%s@%s %s',
            \          $USERNAME,
            \          hostname(),
            \          fnamemodify(getcwd(), ':~')
            \   )
            \ : printf('%s@%s %s',
            \          $USER,
            \          substitute(hostname(), '\..*', '', ''),
            \          fnamemodify(getcwd(), ':~')
            \   )
    endfunction

    "let g:vimshell_user_prompt = s:SID_PREFIX().'vimshell_my_prompt()'
    "let g:vimshell_prompt = "(*'_')> "
    "let g:vimshell_secondary_prompt = '> '

    if executable('zsh') && filereadable(expand('~/.zsh/.zsh_history'))
      " Use zsh history in vimshell/history source.
      let g:unite_source_vimshell_external_history_path =
            \ expand('~/.zsh/.zsh_history')
    endif

    autocmd MyAutoCmd FileType vimshell
          \ call s:on_FileType_vimshell()
    function! s:on_FileType_vimshell()
      " Aliases
      call vimshell#set_alias('ls', 'ls -G')
      call vimshell#set_alias('ll', 'ls -alFG')
      call vimshell#set_alias('la', 'ls -AG')
      call vimshell#set_alias('l',  'ls -CFG')
      call vimshell#set_alias('sl',  'ls')
      call vimshell#set_alias('cl', 'clear')
      call vimshell#set_alias('edit', 'vim --split=tabedit $$args')
      call vimshell#set_alias('quicklook', 'qlmanage -p $$args')

      call vimshell#hook#add('chpwd', 'my_chpwd', s:vimshell_hooks.chpwd)
      call vimshell#hook#add('emptycmd', 'my_emptycmd',
            \                s:vimshell_hooks.emptycmd)
    endfunction

    let s:vimshell_hooks = {}
    function! s:vimshell_hooks.chpwd(args, context)
      if len(split(glob('*'), '\n')) < 100
        call vimshell#execute('ls')
      else
        call vimshell#execute('echo "Many files."')
      endif
    endfunction
    function! s:vimshell_hooks.emptycmd(cmdline, context)
      call vimshell#set_prompt_command('clear')
      return 'clear'
    endfunction

  endfunction
unlet bundle

" }}}

" quickrun.vim {{{

if neobundle#tap('vim-quickrun')
  call neobundle#config({
        \   'autoload' : {
        \     'mappings' : [['nx', '<Plug>(quickrun)']],
        \     'commands' : [
        \         { 'name' : 'QuickRun',
        \           'complete' : 'customlist,quickrun#complete' },
        \ ]}})

  nmap <silent> <Leader>r  <Plug>(quickrun)
  xmap <silent> <Leader>r  <Plug>(quickrun)

  function! neobundle#tapped.hooks.on_source(bundle)
    nnoremap <expr><silent> <C-c>
          \ quickrun#is_running() ? quickrun#sweep_sessions() : "\<C-c>"

    let g:quickrun_config = {}
    let g:quickrun_config._ = {
          \   'runner' : 'vimproc',
          \   'runner/vimproc/updatetime' : 1000,
          \   'outputter' : 'buffer',
          \   'outputter/buffer/close_on_empty' : 1,
          \   'split' : 'below',
          \   'hook/time/enable' : 1,
          \   'running_mark' : "(*'_')> じっこうちゅう...",
          \ }
    "let g:quickrun_config.markdown = {
    "      \   'outputter' : 'browser'
    "      \ }

    " View html file on Web browser.
    if s:is_mac && executable('open')
      let g:quickrun_config.html = {
            \   'command' : 'open',
            \   'outputter' : 'null',
            \ }
    endif
    if executable('xdg-open')
      let g:quickrun_config.html = {
            \   'command' : 'xdg-open',
            \   'outputter' : 'null',
            \ }
    endif

    " Preview markdown file using QuickLook(Requires a QLMarkdown).
    if s:is_mac && executable('qlmanage')
      let g:quickrun_config.markdown = {
            \   'command' : 'qlmanage',
            \   'cmdopt' : '-p',
            \   'outputter' : 'null',
            \ }
    endif
  endfunction

  call neobundle#untap()
endif

" }}}

" vimfiler.vim {{{

if neobundle#tap('vimfiler.vim')
  call neobundle#config({
        \   'depends' : 'Shougo/unite.vim',
        \   'autoload' : {
        \     'explorer' : 1,
        \     'commands' : [
        \         { 'name' : 'VimFiler',
        \           'complete' : 'customlist,vimfiler#complete' },
        \         'VimFilerBufferDir',
        \ ]}})

  nnoremap <silent> <Space>e
        \ :<C-u>VimFiler -buffer-name=VimFiler -quit<CR>
  nnoremap <silent> <Space>f
        \ :<C-u>VimFilerBufferDir -buffer-name=VimFiler
        \ -split -simple -winwidth=30 -no-quit -toggle<CR>

  function! neobundle#tapped.hooks.on_source(bundle)
    " Use vimfiler as default explorer like netrw.
    let g:vimfiler_as_default_explorer = 1

    let g:vimfiler_detect_drives = s:is_windows
          \ ? ['C:/', 'D:/', 'E:/', 'F:/', 'G:/', 'H:/',
          \    'I:/', 'J:/', 'K:/', 'L:/', 'M:/', 'N:/']
          \ : split(glob('/mnt/*'), '\n') + split(glob('/media/*'), '\n') +
          \   split(glob('/Volumes/*'), '\n') + split(glob('/Users/*'), '\n')

    if s:is_unicode
      " Like Textmate icons.
      let g:vimfiler_tree_leaf_icon = ' '
      let g:vimfiler_tree_opened_icon = '▾'
      let g:vimfiler_tree_closed_icon = '▸'
      let g:vimfiler_readonly_file_icon = '▹'
      let g:vimfiler_file_icon = '-'
      let g:vimfiler_marked_file_icon = '✓'
    endif

    autocmd MyAutoCmd FileType vimfiler
          \ call s:on_FileType_vimfiler()
    function! s:on_FileType_vimfiler()
      " VimFiler settings. (Key mapping... etc)
      silent! syntax clear IndentLine
    endfunction
  endfunction

  call neobundle#untap()
endif

" }}}

" indentLine {{{

if neobundle#tap('indentLine')
  let g:indentLine_char = s:is_unicode ? '¦' : '|'
  let g:indentLine_showFirstIndentLevel = 1
  let g:indentLine_indentLevel = 20
  "let g:indentLine_noConcealCursor = 1
  let g:indentLine_fileTypeExclude = ['help']

  if s:is_reloading && exists(':IndentLinesReset')
    IndentLinesReset
  endif

  " Toggle indentLines.
  nnoremap <silent> [toggle]il
        \ :<C-u>IndentLinesToggle<CR>

  call neobundle#untap()
endif

" }}}

" vim-ref {{{

if neobundle#tap('vim-ref')
  call neobundle#config({
        \   'autoload' : {
        \     'commands' : [
        \         { 'name' : 'Ref',
        \           'complete' : 'customlist,ref#complete' },
        \ ]}})

  function! neobundle#tapped.hooks.on_source(bundle)
    let g:ref_source_webdict_sites = {
          \ 'alc' : {
          \   'url' : 'http://eow.alc.co.jp/%s',
          \   'keyword_encoding' : 'utf-8',
          \   'cache' : '0',
          \   'line' : 32,
          \ }}

    "function! g:ref_source_webdict_sites.alc.filter(output)
    "  return join(split(a:output, "\n")[32:], "\n")
    "endfunction

    let g:ref_source_webdict_sites.default = 'alc'
  endfunction

  call neobundle#untap()
endif

" }}}

" vim-smartinput {{{

let bundle = neobundle#get('vim-smartinput')
  function! bundle.hooks.on_source(bundle)

    " Define fallback mappings.
    call smartinput#map_to_trigger('i', '<Plug>(smartinput_BS)',
          \                        '<BS>',
          \                        '<BS>')
    call smartinput#map_to_trigger('i', '<Plug>(smartinput_C-h)',
          \                        '<BS>',
          \                        '<C-h>')
    call smartinput#map_to_trigger('i', '<Plug>(smartinput_CR)',
          \                        '<Enter>',
          \                        '<Enter>')
    "call smartinput#map_to_trigger('i', '<Plug>(smartinput_C-j)',
    "      \                        '<Enter>',
    "      \                        '<C-j>')
    "call smartinput#map_to_trigger('i', '<Plug>(smartinput_NL)',
    "      \                        '<Enter>',
    "      \                        '<NL>')
    "call smartinput#map_to_trigger('i', '<Plug>(smartinput_Return)',
    "      \                        '<Enter>',
    "      \                        '<Return>')

    call smartinput#map_to_trigger('c', '<Plug>(smartinput_NL)',
          \                        '<Enter>',
          \                        '<C-j>')
    call smartinput#map_to_trigger('c', '<Plug>(smartinput_C-h)',
          \                        '<BS>',
          \                        '<C-h>')
    call smartinput#map_to_trigger('c', '<Plug>(smartinput_CR)',
          \                        '<Enter>',
          \                        '<Return>')

  endfunction
unlet bundle

" }}}

" vim-submode {{{

if neobundle#tap('vim-submode')
  call submode#enter_with('winsize', 'n', '', '<C-w>>', '<C-w>>')
  call submode#enter_with('winsize', 'n', '', '<C-w><', '<C-w><')
  call submode#enter_with('winsize', 'n', '', '<C-w>+', '<C-w>+')
  call submode#enter_with('winsize', 'n', '', '<C-w>-', '<C-w>-')
  call submode#map('winsize', 'n', '', '>', '<C-w>>')
  call submode#map('winsize', 'n', '', '<', '<C-w><')
  call submode#map('winsize', 'n', '', '+', '<C-w>+')
  call submode#map('winsize', 'n', '', '-', '<C-w>-')

  call neobundle#untap()
endif

" }}}

" Others {{{
"
" Extended '%' command matching (e.g. HTML tags, if/else/endif, etc.)
runtime macros/matchit.vim

" showmarks.vim
"let g:showmarks_include =
"      \ 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ'

" colorizer.vim
if neobundle#tap('colorizer')
  call neobundle#config({
        \   'autoload' : {
        \     'mappings' : [['n', '<Plug>Colorizer']]
        \ }})

  nmap <silent> <Leader>tc  <Plug>Colorizer

  call neobundle#untap()
endif

" vim-visualstar
if neobundle#tap('vim-visualstar')
  call neobundle#config({
        \   'autoload' : {
        \     'mappings' : [
        \       ['x', '<Plug>(visualstar-*)'], ['x', '<Plug>(visualstar-#)'],
        \       ['x', '<Plug>(visualstar-g*)'], ['x', '<Plug>(visualstar-g#)'],
        \ ]}})

  xmap *  <Plug>(visualstar-*)N
  xmap #  <Plug>(visualstar-#)N
  xmap g*  <Plug>(visualstar-g*)N
  xmap g#  <Plug>(visualstar-g#)N

  call neobundle#untap()
endif

" vim-surround
if neobundle#tap('vim-surround')
  call neobundle#config({
        \   'autoload' : {
        \     'mappings' : [
        \       ['n', '<Plug>Dsurround'], ['n', '<Plug>Csurround'],
        \       ['n', '<Plug>Ysurround'], ['n', '<Plug>YSurround'],
        \       ['n', '<Plug>Yssurround'], ['n', '<Plug>YSsurround'],
        \       ['n', '<Plug>YSsurround'], ['x', '<Plug>VSurround'],
        \       ['x', '<Plug>VgSurround'],
        \ ]}})

  nmap ds   <Plug>Dsurround
  nmap cs   <Plug>Csurround
  nmap ys   <Plug>Ysurround
  nmap yS   <Plug>YSurround
  nmap yss  <Plug>Yssurround
  nmap ySs  <Plug>YSsurround
  nmap ySS  <Plug>YSsurround
  xmap S    <Plug>VSurround
  xmap gS   <Plug>VgSurround

  call neobundle#untap()
endif

" vim-toggle
if neobundle#tap('vim-toggle')
  call neobundle#config({
        \   'autoload' : {
        \     'mappings' : [['n', '<Plug>ToggleN']],
        \ }})

  nmap <silent> +  <Plug>ToggleN

  call neobundle#untap()
endif

" vim-expand-region
if neobundle#tap('vim-expand-region')
  call neobundle#config({
        \   'autoload' : {
        \     'mappings' : [
        \       ['x', '<Plug>(expand_region_expand)'],
        \       ['x', '<Plug>(expand_region_shrink)']
        \ ]}})

  vmap +  <Plug>(expand_region_expand)
  vmap _  <Plug>(expand_region_shrink)

  call neobundle#untap()
endif

" vim-niceblock
if neobundle#tap('vim-niceblock')
  call neobundle#config({
        \   'autoload' : {
        \     'mappings' : [
        \       ['x', '<Plug>(niceblock-I)'], ['x', '<Plug>(niceblock-A)']
        \ ]}})

  xmap I  <Plug>(niceblock-I)
  xmap A  <Plug>(niceblock-A)

  call neobundle#untap()
endif

" open-browser.vim
if neobundle#tap('open-browser.vim')
  call neobundle#config({
        \   'autoload' : {
        \     'function_prefix' : 'openbrowser',
        \     'mappings' : [['nx', '<Plug>(openbrowser-smart-search)']],
        \ }})

  "let g:netrw_nogx = 1  " Disable netrw's gx mapping.
  nmap gx  <Plug>(openbrowser-smart-search)
  vmap gx  <Plug>(openbrowser-smart-search)

  call neobundle#untap()
endif

" VimCalc
let g:VCalc_WindowPosition = 'bottom'

" vim-R-plugin
let vimrplugin_screenplugin = 0

" Filetype vim.
"let g:vim_indent_cont = 0

" vim-signify
let g:signify_vcs_list = ['git']

" }}}

" }}}

" File type settings. {{{
"
augroup MyAutoCmd
  "autocmd BufNewFile,BufRead *.md setlocal filetype=markdown
  "autocmd BufNewFile,BufRead *.coffee setlocal filetype=coffee
  "autocmd BufNewFile,BufRead *.go setlocal filetype=go
augroup END

autocmd MyAutoCmd FileType help
      \ call s:on_FileType_help()
function! s:on_FileType_help()
  nnoremap <buffer> <CR>  <C-]>
  nnoremap <buffer> <BS>  <C-o>
endfunction

" }}}

" Enable omni completion {{{
"
augroup MyAutoCmd
  autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
  autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
  "autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
  autocmd FileType php setlocal omnifunc=phpcomplete#CompletePHP
  "autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
  autocmd FileType ruby setlocal omnifunc=rubycomplete#Complete
  autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
augroup END

" }}}

" Commands: "{{{
"
" Toggle listchars strings {{{

command! ToggleListcharsStrings let &listchars =
      \ (&listchars ==# s:listchars['classic']) ?
      \   s:listchars['modern'] : s:listchars['classic']

" }}}

" Toggle options {{{

function! s:toggle_option(option_name)
  execute 'setlocal' a:option_name.'!' a:option_name.'?'
endfunction

" }}}

" Toggle line number {{{

function! s:toggle_line_number()
  if exists('+relativenumber')
    if (v:version >= 704)
      " Toggle between relative with absolute on cursor line and no numbers.
      if (!&l:number && !&l:relativenumber)
        setlocal relativenumber number
      else
        setlocal norelativenumber nonumber
      endif
    else
      " Toggle between absolute => relative => no numbers.
      execute 'setlocal' (&l:number ==# &l:relativenumber) ?
            \ 'number! number?' : 'relativenumber! relativenumber?'
    endif
  else
    " Toggle between number and nonumber.
    call s:toggle_option('number')
  endif
endfunction

" }}}

" }}}

" Others: "{{{
"
" Change cursor shape for iTerm2.
" See: http://blog.remora.cx/2012/10/spotlight-cursor-line.html
" See: https://gist.github.com/1195581
if s:is_term
  if exists('$TMUX')
    let &t_SI = "\ePtmux;\e\e]50;CursorShape=1\x7\e\\"
    let &t_EI = "\ePtmux;\e\e]50;CursorShape=0\x7\e\\"
  elseif &term =~ 'screen'
    let &t_SI = "\eP\e]50;CursorShape=1\x7\e\\"
    let &t_EI = "\eP\e]50;CursorShape=0\x7\e\\"
  elseif &term =~ 'xterm'
    let &t_SI = "\e]50;CursorShape=1\x7"
    let &t_EI = "\e]50;CursorShape=0\x7"
  endif
endif

" Change the current directory to the current working directory on Vim startup.
autocmd MyAutoCmd VimEnter * lcd %:p:h

" Editing binary file. See :help hex-editing
augroup BinaryXXD
  autocmd!
  autocmd BufReadPre   *.bin let &binary=1
  autocmd BufReadPost  * if &binary | silent %!xxd -g 1
  autocmd BufReadPost  *   setlocal filetype=xxd | endif
  autocmd BufWritePre  * if &binary | %!xxd -r | endif
  autocmd BufWritePost * if &binary | silent %!xxd -g 1
  autocmd BufWritePost *   setlocal nomodified | endif
augroup END

" When do not include Japanese, use encoding for fileencoding.
" See: https://github.com/Shougo/shougo-s-github/blob/master/vim/.vimrc
function! s:ReCheck_FENC()
  let is_multi_byte = search("[^\x01-\x7e]", 'n', 100, 100)
  if &fileencoding =~# 'iso-2022-jp' && !is_multi_byte
    let &fileencoding = &encoding
  endif
endfunction
autocmd MyAutoCmd BufReadPost * call s:ReCheck_FENC()

" If true Vim master, use English help file?
set helplang& helplang=ja,en

" }}}

" Load platform-dependent and temporary config file: "{{{

if filereadable(expand('~/.vimrc.local'))
  source ~/.vimrc.local
endif

" }}}

" Finalize: "{{{
"
if s:is_reloading
  " Call on_source hook when reloading .vimrc.
  call neobundle#call_hook('on_source')
endif

" Must be written at the last. See :help 'secure'.
set secure

" }}}

" __END__
" vim: set fdm=marker ts=2 sw=2 sts=2 et:
