" .vimrc
" https://github.com/todashuta/profiles

scriptencoding utf-8

" Initialize: "{{{
"
if has('vim_starting')
  " Don't reset twice on reloading - 'compatible' has SO many side effects.
  set nocompatible    " Be IMproved.
endif

let s:is_linux = has('unix') && (system('uname') =~? 'linux')
let s:is_windows = has('win16') || has('win32') || has('win64')
let s:is_cygwin = has('win32unix')
let s:is_mac = !s:is_windows && !s:is_cygwin
      \ && (has('mac') || has('macunix') || has('gui_macvim') ||
      \   (!executable('xdg-open') &&
      \     system('uname') =~? '^darwin'))

let s:cui_running = !has('gui_running')
let s:when_reloading_vimrc = !has('vim_starting')

" Use English interface.
if s:is_windows
  language message en
else
  language message C
endif

" Define <Leader>, <LocalLeader>
let g:mapleader = '\'
"let g:maplocalleader = ','

" Reset all autocmd defined in this file.
augroup MyAutoCmd
  autocmd!
augroup END

if s:is_windows && exists('+shellslash')
  " Use a forward slash as a path separator.
  set shellslash
endif

if !exists($MYGVIMRC)
  let $MYGVIMRC = expand('~/.gvimrc')
endif

" Set runtimepath.
if has('vim_starting')
  if s:is_windows
    set runtimepath+=~/.vim,~/.vim/after
  endif

  " Load neobundle.
  set runtimepath+=~/.vim/bundle/neobundle.vim
endif

" Initialize neobundle
call neobundle#rc(expand('~/.vim/bundle'))

" Github repositories.
if has('lua')
  NeoBundleLazy 'Shougo/neocomplete.vim', {
        \   'autoload' : {
        \     'insert' : 1,
        \ }}
else
  NeoBundleLazy 'Shougo/neocomplcache', {
        \   'autoload' : {
        \     'insert' : 1,
        \ }}
endif
NeoBundleLazy 'Shougo/neosnippet', {
      \   'autoload' : {
      \     'insert' : 1,
      \ }}
NeoBundleFetch 'honza/vim-snippets'
NeoBundle 'Shougo/unite.vim'
NeoBundleLazy 'Shougo/vimfiler', {
      \   'depends' : 'Shougo/unite.vim',
      \   'autoload' : {
      \     'explorer' : 1,
      \     'commands' : [
      \         { 'name' : 'VimFiler',
      \           'complete' : 'customlist,vimfiler#complete' },
      \         'VimFilerBufferDir',
      \ ]}}
NeoBundleLazy 'h1mesuke/unite-outline', {
      \   'depends' : 'Shougo/unite.vim',
      \   'autoload' : {
      \     'unite_sources' : 'outline'
      \ }}
NeoBundle 'ujihisa/unite-colorscheme', {
      \   'depends' : 'Shougo/unite.vim'
      \ }
NeoBundle 'ujihisa/unite-font', {
      \   'gui' : 1,
      \   'depends' : 'Shougo/unite.vim',
      \ }
NeoBundle 'Kocha/vim-unite-tig', {
      \   'depends' : 'Shougo/unite.vim'
      \ }
NeoBundleLazy 'tacroe/unite-mark', {
      \   'depends' : 'Shougo/unite.vim',
      \   'autoload' : {
      \     'unite_sources' : 'mark'
      \ }}
NeoBundle 'tsukkee/unite-help'
NeoBundleLazy 'Shougo/unite-build', {
      \   'depends' : 'Shougo/unite.vim',
      \   'autoload' : {
      \     'unite_sources' : 'build'
      \ }}
NeoBundleLazy 'Shougo/vimproc', {
      \   'autoload' : {
      \     'function_prefix' : 'vimproc'
      \   },
      \   'build' : {
      \     'windows' : 'make -f make_mingw32.mak',
      \     'cygwin' : 'make -f make_cygwin.mak',
      \     'mac' : 'make -f make_mac.mak',
      \     'unix' : 'make -f make_unix.mak',
      \ }}
NeoBundle 'altercation/vim-colors-solarized'
NeoBundleLazy 'othree/eregex.vim', {
      \   'autoload' : {
      \     'commands' : ['E2v', 'M', 'S', 'G', 'V']
      \ }}
NeoBundleLazy 'vim-scripts/VOoM', {
      \   'autoload' : {
      \     'filetypes' : ['html', 'markdown', 'python', 'latex']
      \ }}
"NeoBundle 'scrooloose/nerdtree'
NeoBundleLazy 'thinca/vim-quickrun', {
      \   'depends' : ['Shougo/vimproc'],
      \   'autoload' : {
      \     'mappings' : [['nx', '<Plug>(quickrun)']],
      \     'commands' : [
      \         { 'name' : 'QuickRun',
      \           'complete' : 'customlist,quickrun#complete' },
      \ ]}}
NeoBundleLazy 'tyru/open-browser.vim', {
      \   'autoload' : {
      \     'function_prefix' : 'openbrowser',
      \     'mappings' : [['nx', '<Plug>(openbrowser-smart-search)']],
      \ }}
NeoBundleLazy 'h1mesuke/vim-alignta', {
      \   'autoload' : {
      \     'commands' : ['Alignta', 'Align']
      \ }}
NeoBundleLazy 'tpope/vim-surround', {
      \   'autoload' : {
      \     'mappings' : [
      \       ['n', '<Plug>Dsurround'], ['n', '<Plug>Csurround'],
      \       ['n', '<Plug>Ysurround'], ['n', '<Plug>YSurround'],
      \       ['n', '<Plug>Yssurround'], ['n', '<Plug>YSsurround'],
      \       ['n', '<Plug>YSsurround'], ['x', '<Plug>VSurround'],
      \       ['x', '<Plug>VgSurround'],
      \ ]}}
"NeoBundle 'troydm/easybuffer.vim'
NeoBundle 'vim-scripts/DirDo.vim'
NeoBundleLazy 'kana/vim-smartchr', {
      \   'autoload' : {
      \     'insert' : 1,
      \ }}
"NeoBundle 'kana/vim-submode'
NeoBundleLazy 'glidenote/memolist.vim', {
      \   'autoload' : {
      \     'commands' : ['MemoGrep', 'MemoList', 'MemoNew']
      \ }}
NeoBundleLazy 'hallison/vim-markdown', {
      \   'autoload' : {
      \     'filetypes' : ['markdown']
      \ }}
"NeoBundle 'houtsnip/vim-emacscommandline'
NeoBundleLazy 'Shougo/vimshell', {
      \   'depends' : ['Shougo/vimproc', 'Shougo/unite.vim'],
      \   'autoload' : {
      \     'commands' : ['VimShell', 'VimShellPop', 'VimShellInteractive']
      \ }}
"NeoBundle 'supermomonga/vimshell-kawaii.vim'
NeoBundleLazy 'mattn/zencoding-vim', {
      \   'autoload' : {
      \     'filetypes' : ['html','css']
      \ }}
NeoBundleLazy 'thinca/vim-ref', {
      \   'autoload' : {
      \     'commands' : [
      \         { 'name' : 'Ref',
      \           'complete' : 'customlist,ref#complete' },
      \ ]}}
NeoBundleLazy 'mattn/calendar-vim', {
      \   'autoload' : {
      \     'commands' : ['Calendar', 'CalendarH']
      \ }}
NeoBundleLazy 'nathanaelkane/vim-indent-guides', {
      \   'autoload' : {
      \     'mappings' : [['n', '<Plug>IndentGuidesToggle']],
      \ }}
NeoBundleLazy 'skammer/vim-css-color', {
      \   'gui' : 1,
      \   'autoload' : {
      \     'filetypes' : ['html', 'css']
      \ }}
NeoBundleLazy 'lilydjwg/colorizer', {
      \   'autoload' : {
      \     'mappings' : [['n', '<Plug>Colorizer']]
      \ }}
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
NeoBundle 'Lokaltog/vim-powerline'
NeoBundleLazy 'thinca/vim-painter', {
      \   'autoload' : {
      \     'commands' : 'PainterStart'
      \ }}
NeoBundleLazy 'thinca/vim-scouter', {
      \   'autoload' : {
      \     'commands' : [
      \         { 'name' : 'Scouter', 'complete' : 'file' }
      \ ]}}
NeoBundleLazy 'thinca/vim-visualstar', {
      \   'autoload' : {
      \     'mappings' : [
      \       ['x', '<Plug>(visualstar-*)'], ['x', '<Plug>(visualstar-#)'],
      \       ['x', '<Plug>(visualstar-g*)'], ['x', '<Plug>(visualstar-g#)'],
      \ ]}}
"NeoBundle 'vim-scripts/ShowMarks'
"NeoBundle 'Lokaltog/vim-easymotion'
NeoBundleLazy 'taku-o/vim-toggle', {
      \   'autoload' : {
      \     'mappings' : [['n', '<Plug>ToggleN']],
      \ }}
NeoBundleLazy 'ujihisa/neco-look', {
      \   'autoload' : {
      \     'insert' : 1
      \ }}
NeoBundleLazy 'airblade/vim-gitgutter', {
      \   'autoload' : {
      \     'commands' : ['GitGutterEnable']
      \ }}
NeoBundleLazy 'kchmck/vim-coffee-script', {
      \   'autoload' : {
      \     'filetypes' : ['coffee']
      \ }}
NeoBundleLazy 'vim-scripts/Vim-R-plugin'
NeoBundleLazy 'itchyny/thumbnail.vim', {
      \   'autoload' : {
      \     'commands' : ['Thumbnail'],
      \ }}
NeoBundleLazy 'Shougo/vinarise', {
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
NeoBundleLazy 'terryma/vim-expand-region', {
      \   'autoload' : {
      \     'mappings' : [
      \       ['x', '<Plug>(expand_region_expand)'],
      \       ['x', '<Plug>(expand_region_shrink)']
      \ ]}}
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
NeoBundle 'thinca/vim-unite-history'
NeoBundle 'osyo-manga/unite-filetype'

if has('python')
  NeoBundleLazy 'gregsexton/VimCalc', {
        \   'autoload' : {
        \     'commands' : 'Calc'
        \ }}
endif

if executable('ag')
  NeoBundle 'rking/ag.vim'
endif

"if executable('mdfind')
"  NeoBundle 'choplin/unite-spotlight',
"        \ { 'depends' : 'Shougo/unite.vim' }
"endif

if has('conceal')
  NeoBundle 'Yggdroot/indentLine'
endif

" Local plugins directory like pathogen. (For develop plugins, etc.)
"NeoBundleLocal ~/bundle

" Disable netrw.vim
let g:loaded_netrwPlugin = 1

filetype plugin indent on    " Required!

" Installation check
NeoBundleCheck

" Enable syntax color
syntax enable

" }}}

" General: "{{{
"
" Use the UTF-8 encoding inside Vim.
set encoding=utf-8
" Minimal number of screen lines to keep above and below the cursor.
set scrolloff=2

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

" Enable the use of the mouse.
" See: http://yskwkzhr.blogspot.jp/2013/02/use-mouse-on-terminal-vim.html
if has('mouse')
  set mouse=a
  if has('mouse_sgr')
    set ttymouse=sgr
  elseif v:version > 703 || v:version is 703 && has('patch632')
    set ttymouse=sgr
  else
    set ttymouse=xterm2
  endif
endif

" Indicates a fast terminal connection.
set ttyfast

" Don't redraw while macro executing.
set lazyredraw

" All windows not same size after split or close.
set noequalalways

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
" Number of spaces that a <Tab> in the file counts for.
set tabstop=4
" Number of spaces to use for each step of (auto)indent.
set shiftwidth=4
" Expand tab to spaces.
"set expandtab
" See :help softtabstop
set softtabstop=4
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

if has('vim_starting')  " Don't reset twice on reloading.
  " Highlight search results.
  set hlsearch
endif

" Command-line completion operates in an enhanced mode.
set wildmenu
" Complete Longest common string, List all matches and complete the next full match.
set wildmode=longest,list,full
" These patterns is ignored when completing file or directory names.
"set wildignore&
"set wildignore+=.DS_Store
"set wildignore+=*~,*.swp,*.tmp
"set wildignore+=*.bmp,*.gif,*.ico,*.jpg,*.png
" These extensions get a lower priority when multiple files match a wildcard.
set suffixes&
set suffixes+=.DS_Store
"set suffixes+=.tmp,.bmp,.gif,.ico,.jpg,.png

" }}}

" Key Mappings: "{{{
"
inoremap <Esc>  <Esc>`^

" Move cursor by display line.
noremap j gj
noremap k gk
noremap gj j
noremap gk k

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
nnoremap n nzzzv
nnoremap N Nzzzv

" Don't move on *
nnoremap * *N
" Don't move on #
nnoremap # #N
" Don't move on g*
nnoremap g* g*N
" Don't move on g#
nnoremap g# g#N

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
nnoremap gl gt
nnoremap gh gT

" Enter ';' to use command-line (Swap ':' and ';').
noremap ; :
noremap : ;

" Enable <CR> to line break in Normal Mode.
"nnoremap <CR> i<CR><Esc>
" <Space-CR>: line break.
nnoremap <Space><CR>  i<CR><Esc>

" Visual shifting (does not exit Visual mode)
xnoremap < <gv
xnoremap > >gv

" ノーマルモードのインデントの操作をビジュアルモードと同様にする
nnoremap < <<
nnoremap > >>

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
nnoremap Y y$

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
cnoremap <C-k> <C-\>e getcmdpos() == 1 ?
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

" Toggle number.
"nnoremap <silent> [toggle]n
"      \ :<C-u>call <SID>toggle_option('number')<CR>

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

" Toggle Paste.
nnoremap <silent> [toggle]p
      \ :<C-u>call <SID>toggle_option('paste')<CR>:set mouse=<CR>

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

nnoremap q <Nop>
nnoremap Q q
nnoremap K <Nop>
"nnoremap qK K

" Disable dangerous ZZ.
nnoremap ZZ  :<C-u>echoerr 'ZZ is disabled.'<CR>
" Disable dangerous ZQ.
nnoremap ZQ  :<C-u>echoerr 'ZQ is disabled.'<CR>

" Moving cursor to other windows.
nnoremap <silent> <Space>h  :<C-u>wincmd h<CR>
nnoremap <silent> <Space>j  :<C-u>wincmd j<CR>
nnoremap <silent> <Space>k  :<C-u>wincmd k<CR>
nnoremap <silent> <Space>l  :<C-u>wincmd l<CR>

" コピーした文字で繰り返し上書きペーストする
"xnoremap P  "0p
" visual mode <Space-p>: Paste from the last yank.
xnoremap <Space>p  "0p

" x, X: Delete into the blackhole register to not clobber the last yank.
nnoremap x  "_x
nnoremap X  "_X

" c: Change into the blackhole register to not clobber the last yank.
nnoremap c  "_c

" (visual mode) v: Start Visual mode linewise.
xnoremap v  V

" Settings for markdown
"autocmd MyAutoCmd FileType markdown call s:markdown_settings()
"function! s:markdown_settings()
"  " 行頭か行頭からいくつかのタブの後だったら'-, +, *, >'に半角スペースを足す
"  inoremap <buffer><expr> -  search('^\t*\%#', 'bcn') ? '- ' : '-'
"  inoremap <buffer><expr> +  search('^\t*\%#', 'bcn') ? '+ ' : '+'
"  inoremap <buffer><expr> *  search('^\t*\%#', 'bcn') ? '* ' : '*'
"  inoremap <buffer><expr> >  search('^\t*\%#', 'bcn') ? '> ' : '>'
"endfunction

" <C-f>, <C-b>: page move.
"inoremap <expr> <C-f>  pumvisible() ? "\<PageDown>" : "\<Right>"
inoremap <C-f>  <Right>
"inoremap <expr> <C-b>  pumvisible() ? "\<PageUp>" : "\<Left>"
inoremap <C-b>  <Left>
" <C-a>: Move to head+.
inoremap <expr> <C-a>
      \ search('^\s\s*\%#', 'bcn') ? '<C-o>g0' : '<C-o>g^'
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
"if s:cui_running && (!exists('g:colors_name') || has('vim_starting'))
"  colorscheme solarized
"endif
" Number of screen lines to use for the command-line.
set cmdheight=1
" Show (partial) command in the last line of the screen.
set showcmd
" Disable bell.
set visualbell t_vb=

" Show the line and column number of the cursor position.
"set ruler

" When a bracket is inserted, briefly jump to the matching one.
set showmatch
set matchtime=3
" Highlight a pair of <>.
set matchpairs& matchpairs+=<:>

" When a last line is long, do not omit it in @.
set display& display+=lastline

" The height of popup menu.
set pumheight=15

" colorcolumn
"let s:my_colorcolumn = join(range(79, 334), ',')
" http://hanschen.org/2012/10/24/
" http://stackoverflow.com/questions/2447109/showing-a-different-background-colour-in-vim-past-80-characters

" Disable colorcolumn automatically when narrow width of window.
"if exists('&colorcolumn')
"  autocmd MyAutoCmd BufEnter,VimResized,WinEnter *
"        \ let &colorcolumn = (winwidth(0) >= 85) ?
"        \   (join(range(79, 334), ',')) : 0
"endif  " MEMO: winwidth(0) or &columns ??

" Toggle colorcolumn.
if exists('&colorcolumn')
  nnoremap <silent> [toggle]cc
        \ :<C-u>let &colorcolumn =
        \   (&colorcolumn == 0) ? (join(range(79, 334), ',')) : 0 <CR>
endif

if has('vim_starting')  " Don't reset twice on reloading.
  if exists('&colorcolumn')
    " Highlight columns.
    let &colorcolumn = join(range(79, 334), ',')
  endif
  " Show line number.
  set number
  " Show line number relative to the line with the cursor.
  "set relativenumber
  " Lines longer than the width of the window will wrap.
  set wrap
  " Indicate tab, wrap, trailing spaces and eol or not.
  set list
endif

" Strings to use in 'list' mode and for the :list command.
let s:listchars_classic = 'tab:>-,trail:-,eol:$,extends:>,precedes:<,nbsp:%'
let s:listchars_modern  = 'tab:▸ ,trail:›,precedes:«,extends:»'
if has('vim_starting')
  let &listchars = s:is_windows ? (s:listchars_classic) : (s:listchars_modern)
endif
" Example...
"   'tab:▸ ,trail:･,eol:¬,precedes:«,extends:»'
"   'tab:▸ ,trail:›,eol:¬,precedes:«,extends:»'
"   'tab:▸ ,trail:›,eol:↲,precedes:«,extends:»'
"   'tab:▸ ,trail:›,eol:⏎,precedes:«,extends:»'

" Highlight cursor line.
set cursorline

" Highlight cursor line sensibly only current window.
autocmd MyAutoCmd WinEnter *
      \ let &l:cursorline =
      \ (!exists('w:my_cursorline_state') || w:my_cursorline_state == 1)?
      \ 1 : 0
autocmd MyAutoCmd WinLeave *
      \  let w:my_cursorline_state = (&l:cursorline == 1)?  1 : 0
      \| setlocal nocursorline

" Highlight cursor column sensibly only current window.
autocmd MyAutoCmd WinEnter *
      \ let &l:cursorcolumn =
      \ (!exists('w:my_cursorcolumn_state') || w:my_cursorcolumn_state == 0)?
      \ 0 : 1
autocmd MyAutoCmd WinLeave *
      \  let w:my_cursorcolumn_state = (&l:cursorcolumn == 1)? 1 : 0
      \| setlocal nocursorcolumn

" }}}

" Status Line: "{{{
"
" Show status line always.
set laststatus=2

" Set statusline.
""function! s:my_statusline()
""  if &columns >= 80    " Long version
""    let &statusline = ''
""    let &statusline .= '%{&paste ? "\ \ [PASTE]" : ""}'  " Paste mode Indicator
""    let &statusline .= ' [%2n]'         " Buffer number
""    let &statusline .= ' %<%F'          " Full path to the file in the buffer.
""    let &statusline .= '%m%r%h%w'       " Modified flag, Readonly flag, Help flag, Preview flag
""    let &statusline .= '%= '            " Separation point between left and right, and Space.
""    let &statusline .= ' [%{strlen(&ft) ? &ft : "no ft"}]
""                        \[%{(&fenc == "" ? &enc : &fenc)}]
""                        \[%{&fileformat}]'
""    let &statusline .= ' [%4l/%L:%3v]'  " Line number / Number of lines in buffer, Virtual column number.
""    let &statusline .= ' %3p%% '        " Percentage through file in lines as in |CTRL-G|.
""  else                 " Short version
""    let &statusline = ''
""    let &statusline .= '%{&paste ? "[P]" : ""}'  " Paste mode Indicator
""    let &statusline .= '%<%t'         " File name of file in the buffer.
""    let &statusline .= '%m%r%h%w'     " Modified flag, Readonly flag, Help flag, Preview flag
""    let &statusline .= '%= '          " Separation point between left and right, and Space.
""    let &statusline .= '[%{&filetype}:%{&fileencoding}:%{&fileformat}]'
""    let &statusline .= '[%3l:%2v]'    " Line number, Virtual column number.
""    let &statusline .= '%3p%%'        " Percentage through file in lines as in |CTRL-G|.
""  endif
""endfunction
""
""autocmd MyAutoCmd VimEnter,VimResized * call s:my_statusline()

"autocmd MyAutoCmd VimEnter,VimResized *
"      \ let &statusline = (winwidth(0) >= 80) ?
"      \   s:statusline_long : s:statusline_short

" }}}

" Highlight japanese zenkaku space. "{{{
"
if has('syntax')
  syntax enable
  function! s:highlight_zenkaku_space()
    highlight ZenkakuSpace term=underline ctermbg=64 guibg=#719e07
    match ZenkakuSpace /　/
  endfunction
  autocmd MyAutoCmd VimEnter,WinEnter,ColorScheme *
      \ call s:highlight_zenkaku_space()
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
    execute "normal! g`\""
  endif
endfunction

autocmd MyAutoCmd BufReadPost * call s:restore_cursor_position()

" }}}

" Plugin: "{{{
"
" neocomplcache.vim {{{
if neobundle#is_installed('neocomplcache')

  " Launches neocomplcache automatically on vim startup.
  let g:neocomplcache_enable_at_startup = 1

  let bundle = neobundle#get('neocomplcache')
    function! bundle.hooks.on_source(bundle)

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
            \ 'Unite' : 'unite#complete_source',
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
  unlet bundle

endif
" }}}

" neocomplete.vim {{{
if neobundle#is_installed('neocomplete.vim')

  " Use neocomplete.
  let g:neocomplete#enable_at_startup = 1

  let bundle = neobundle#get('neocomplete.vim')
    function! bundle.hooks.on_source(bundle)

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
  unlet bundle

endif
" }}}

" neosnippet.vim {{{

let bundle = neobundle#get('neosnippet')
  function! bundle.hooks.on_source(bundle)

    " Plugin key-mappings.
    imap <C-k>  <Plug>(neosnippet_expand_or_jump)
    smap <C-k>  <Plug>(neosnippet_expand_or_jump)

    " For snippet_complete marker.
    if has('conceal')
      set conceallevel=2 concealcursor=i
    endif

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
unlet bundle

" }}}

" zencoding.vim {{{

"let bundle = neobundle#get('zencoding-vim')
"  function! bundle.hooks.on_source(bundle)

    let g:user_zen_leader_key = has('gui_running') ? '<C-Space>' : '<C-@>'
    let g:user_zen_settings = {
          \   'lang' : 'ja',
          \   'indentation' : "\t",
          \   'html' : {
          \     'filters' : 'html',
          \     'empty_element_suffix' : '>',
          \   },
          \   'css' : {
          \     'filters' : 'fc',
          \   },
          \ }

"  endfunction
"unlet bundle

" }}}

" eregex.vim {{{

" Default disable.
let g:eregex_default_enable = 0

"nnoremap /  :M/
"nnoremap ?  :M?
nnoremap ,/  :M/
nnoremap ,?  :M?

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

    function! s:unite_my_settings()
      " <C-w>: Deletes a path upward.
      imap <buffer> <C-w>  <Plug>(unite_delete_backward_path)
      " <Tab>: Goes to the next candidate, or goes to the top from the bottom.
      "imap <buffer> <Tab>  <Plug>(unite_select_next_line)

      " ESCキーを2回押すと終了する
      nmap <buffer> <Esc><Esc>  <Plug>(unite_exit)
      imap <buffer> <Esc><Esc>  <Esc><Plug>(unite_exit)
    endfunction
    autocmd MyAutoCmd FileType unite call s:unite_my_settings()

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
      \             'Unite neobundle/update -log -no-start-insert'],
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

" Visibility of `listchars' (normal, high, low)
let g:solarized_visibility = 'low'
" Toggle background key (Light or Dark)
call togglebg#map('<F5>')

" If you use a iTerm besides use solarized iTerm profiles,
" separate the config 'light' from 'dark' by $ITERM_PROFILE.
function! s:judge_background_and_colorschemes()
  let g:solarized_termcolors = ($ITERM_PROFILE =~? 'solarized') ? '16' : '256'

  if exists('$ITERM_PROFILE') && ($ITERM_PROFILE =~? 'solarized')
    let &background = ($ITERM_PROFILE =~? 'light') ? 'light' : 'dark'
    let g:Powerline_colorscheme = ($ITERM_PROFILE =~? 'light') ?
          \ 'solarized' : 'solarized16'
    colorscheme solarized
  else
    set background=dark
    let g:Powerline_colorscheme = 'default'
    colorscheme hybrid
  endif
endfunction
if s:cui_running && (!exists('g:colors_name') || has('vim_starting'))
  call s:judge_background_and_colorschemes()
endif

" }}}

" vim-smartchr {{{

let bundle = neobundle#get('vim-smartchr')
  function! bundle.hooks.on_source(bundle)

    "inoremap <expr> =  smartchr#one_of(' = ', ' == ', ' === ', '=')
    "inoremap <expr> ,  smartchr#one_of(', ', ',')

    "inoremap <expr> :  smartchr#one_of(': ', ' : ', ':')
    "inoremap <buffer> <expr> .  smartchr#loop('.',  ' . ',  '..', '...')

    "augroup MyAutoCmd
    "  autocmd FileType css inoremap <expr> :  smartchr#one_of(':')
    "augroup END

  endfunction
unlet bundle

" }}}

" vim-indent-guides {{{

nmap <silent> <Leader>ig  <Plug>IndentGuidesToggle

" indent-guidesを最初から有効にする
"let g:indent_guides_enable_on_vim_startup = 1
" 色の変化の幅
let g:indent_guides_color_change_percent = 30
" ガイド幅
let g:indent_guides_guide_size = 1

" }}}

" netrw.vim "{{{
"
" Tree style listing.
"let g:netrw_liststyle = 3
" 'v'でファイルを開くときに右側に開く
"let g:netrw_altv = 1
" 'o'でファイルを開くときに下側に開く
"let g:netrw_alto = 1
" CVSと.で始まるファイルは表示しない
"let g:netrw_list_hide = 'CVS,\(^\|\s\s\)\zs\.\S\+'

" }}}

" vim-powerline {{{
"
"let g:Powerline_symbols = 'fancy'            " Requires a patched font.
"let g:Powerline_colorscheme = 'solarized'    " light
"let g:Powerline_colorscheme = 'solarized16'  " dark
"let g:Powerline_cache_enabled = 0
let g:Powerline_stl_path_style = 'short'
if s:is_windows
  let g:Powerline_dividers_override = ['', '', '', '<']
else
  let g:Powerline_dividers_override = ['', '', '', '❮']
endif
let g:Powerline_symbols_override = {
      \ 'LINE': '',
      \ }
"call Pl#Theme#ReplaceSegment('lineinfo', 'scrollpercent')
"call Pl#Theme#ReplaceSegment('scrollpercent', 'lineinfo')

" CUI上でESC後すぐに反映させる
if has('unix') && s:cui_running
  inoremap <silent> <Esc>  <Esc>`^
  inoremap <silent> <C-[>  <Esc>`^
endif

function! s:sync_powerline_colorscheme()
  if exists(':PowerlineReloadColorscheme')
    let g:Powerline_colorscheme = (g:colors_name == 'solarized') ?
        \ ((&background == 'light') ? 'solarized' : 'solarized16') : 'default'
    "PowerlineClearCache
    PowerlineReloadColorscheme
  endif
endfunction

" Reload Powerline automatically after loading a color scheme.
autocmd MyAutoCmd ColorScheme * silent call s:sync_powerline_colorscheme()
" Reload Powerline automatically when the Vim start-up.
"autocmd MyAutoCmd VimEnter * silent call s:sync_powerline_colorscheme()

" Finalize Powerline. (Reset Powerline colorscheme for next time)
if s:cui_running && exists('$ITERM_PROFILE')
  autocmd MyAutoCmd VimLeave * call s:judge_background_and_colorschemes()
        \| silent call s:sync_powerline_colorscheme()
endif

" No need to show mode due to Powerline.
set noshowmode

" }}}

" vimshell {{{

noremap <silent> <Space>r
      \ :VimShellSendString<CR>

let bundle = neobundle#get('vimshell')
  function! bundle.hooks.on_source(bundle)

    " Prompt.
    function! VimShellMyPromptString()
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

    let g:vimshell_user_prompt = 'VimShellMyPromptString()'
    let g:vimshell_prompt = "(*'_')> "
    let g:vimshell_secondary_prompt = '> '

    if executable('zsh') && filereadable(expand('~/.zsh/.zsh_history'))
      " Use zsh history in vimshell/history source.
      let g:unite_source_vimshell_external_history_path =
            \ expand('~/.zsh/.zsh_history')
    endif

    autocmd MyAutoCmd FileType vimshell call s:vimshell_settings()
    function! s:vimshell_settings()
      " Aliases
      call vimshell#set_alias('ls', 'ls -G')
      call vimshell#set_alias('ll', 'ls -alFG')
      call vimshell#set_alias('la', 'ls -AG')
      call vimshell#set_alias('l',  'ls -CFG')
      call vimshell#set_alias('sl',  'ls')
      call vimshell#set_alias('cl', 'clear')
      call vimshell#set_alias('edit', 'vim --split=tabedit $$args')
      call vimshell#set_alias('quicklook', 'qlmanage -p $$args')

      let s:vimshell_hooks = {}
      function! s:vimshell_hooks.chpwd(args, context)
        if len(split(glob('*'), '\n')) < 100
          call vimshell#execute('ls')
        else
          call vimshell#execute('echo "Many files."')
        endif
      endfunction
      call vimshell#hook#add('chpwd', 'my_chpwd', s:vimshell_hooks.chpwd)
    endfunction

  endfunction
unlet bundle

" }}}

" quickrun.vim {{{

nmap <silent> <Leader>r  <Plug>(quickrun)

nnoremap <expr><silent> <C-c>  neobundle#is_sourced('vim-quickrun')
      \ ? (quickrun#is_running() ? quickrun#sweep_sessions() : "\<C-c>")
      \ : "\<C-c>"

let bundle = neobundle#get('vim-quickrun')
  function! bundle.hooks.on_source(bundle)

    let g:quickrun_config = {}
    let g:quickrun_config._ = {
          \   'runner' : 'vimproc',
          \   'runner/vimproc/updatetime' : 1000,
          \   'outputter' : 'buffer',
          \   'outputter/buffer/close_on_empty' : 1,
          \   'split' : 'below',
          \   'hook/time/enable' : 1,
          \   'running_mark' : '(*''_'')> じっこうちゅう...',
          \ }
    "let g:quickrun_config.markdown = {
    "      \   'outputter' : 'browser'
    "      \ }

    if s:is_mac
      " Preview markdown file using QuickLook(Requires a QLMarkdown).
      if executable('qlmanage')
        let g:quickrun_config.markdown = {
              \   'command' : 'qlmanage',
              \   'cmdopt' : '-p',
              \   'outputter' : 'null',
              \ }
      endif

      " View html file on Web browser using 'open' command.
      let g:quickrun_config.html = {
            \   'runner' : 'system',
            \   'command' : 'open',
            \   'outputter' : 'null',
            \ }
    endif

  endfunction
unlet bundle

" }}}

" VimFiler {{{

" Use vimfiler as default explorer like netrw.
let g:vimfiler_as_default_explorer = 1

let bundle = neobundle#get('vimfiler')
  function! bundle.hooks.on_source(bundle)
    if !s:is_windows
      " Like Textmate icons.
      let g:vimfiler_tree_leaf_icon = ' '
      let g:vimfiler_tree_opened_icon = '▾'
      let g:vimfiler_tree_closed_icon = '▸'
      let g:vimfiler_readonly_file_icon = '▹'
      let g:vimfiler_file_icon = '-'
      let g:vimfiler_marked_file_icon = '✓'
    endif

    autocmd MyAutoCmd FileType vimfiler call s:vimfiler_my_settings()
    function! s:vimfiler_my_settings()
      " VimFiler settings. (Key mapping... etc)
    endfunction
  endfunction
unlet bundle

nnoremap <silent> <Space>e
      \ :<C-u>VimFiler -buffer-name=VimFiler -quit<CR>
nnoremap <silent> <Space>f
      \ :<C-u>VimFilerBufferDir -buffer-name=VimFiler
      \ -split -simple -winwidth=30 -no-quit -toggle<CR>

" }}}

" indentLine {{{

let g:indentLine_char = '¦'
let g:indentLine_showFirstIndentLevel = 1
let g:indentLine_indentLevel = 20
"let g:indentLine_noConcealCursor = 1

if s:when_reloading_vimrc && exists(':IndentLinesReset')
  IndentLinesReset
endif

" Toggle indentLines.
nnoremap <silent> [toggle]il
      \ :<C-u>IndentLinesToggle<CR>

" }}}

" open-browser.vim {{{

"let g:netrw_nogx = 1  " Disable netrw's gx mapping.
nmap gx  <Plug>(openbrowser-smart-search)
vmap gx  <Plug>(openbrowser-smart-search)

" }}}

" vim-ref {{{

let bundle = neobundle#get('vim-ref')
  function! bundle.hooks.on_source(bundle)

    let g:ref_source_webdict_sites = {
          \ 'alc' : {
          \   'url' : 'http://eow.alc.co.jp/%s',
          \   'keyword_encoding' : 'utf-8',
          \   'cache' : '0',
          \   'line' : 32,
          \ }}

    "function! ref_source_webdict_sites.alc.filter(output)
    "  return join(split(a:output, "\n")[32:], "\n")
    "endfunction

    let g:ref_source_webdict_sites.default = 'alc'

  endfunction
unlet bundle

" }}}

" vim-visualstar {{{

xmap *  <Plug>(visualstar-*)N
xmap #  <Plug>(visualstar-#)N
xmap g*  <Plug>(visualstar-g*)N
xmap g#  <Plug>(visualstar-g#)N

" }}}

" vim-surround {{{

nmap ds  <Plug>Dsurround
nmap cs  <Plug>Csurround
nmap ys  <Plug>Ysurround
nmap yS  <Plug>YSurround
nmap yss <Plug>Yssurround
nmap ySs <Plug>YSsurround
nmap ySS <Plug>YSsurround
xmap S   <Plug>VSurround
xmap gS  <Plug>VgSurround

" }}}

" vim-expand-region {{{

vmap +  <Plug>(expand_region_expand)
vmap -  <Plug>(expand_region_shrink)

" }}}

" vim-smartinput {{{

let bundle = neobundle#get('vim-smartinput')
  function! bundle.hooks.on_source(bundle)

    call smartinput#map_to_trigger('i',
          \ '<Plug>(smartinput_BS)', '<BS>', '<BS>')
    call smartinput#map_to_trigger('i',
          \ '<Plug>(smartinput_C-h)', '<BS>', '<C-h>')
    call smartinput#map_to_trigger('i',
          \ '<Plug>(smartinput_CR)', '<Enter>', '<Enter>')
    "call smartinput#map_to_trigger('i',
    "      \ '<Plug>(smartinput_C-j)', '<Enter>', '<C-j>')
    "call smartinput#map_to_trigger('i',
    "      \ '<Plug>(smartinput_NL)', '<Enter>', '<NL>')
    "call smartinput#map_to_trigger('i',
    "      \ '<Plug>(smartinput_Return)', '<Enter>', '<Return>')

    call smartinput#map_to_trigger('c',
          \ '<Plug>(smartinput_NL)', '<Enter>', '<C-j>')
    call smartinput#map_to_trigger('c',
          \ '<Plug>(smartinput_C-h)', '<BS>', '<C-h>')
    call smartinput#map_to_trigger('c',
          \ '<Plug>(smartinput_CR)', '<Enter>', '<Return>')

  endfunction
unlet bundle

" }}}

" Others {{{
"
" Expand the jump functions of % command (e.g. HTML tags, if/else/endif, etc.)
runtime macros/matchit.vim

" showmarks.vim
"let g:showmarks_include =
"      \ 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ'

" colorizer.vim
nmap <silent> <Leader>tc  <Plug>Colorizer

" vim-toggle
nmap <silent> +  <Plug>ToggleN

" VimCalc
let g:VCalc_WindowPosition = 'bottom'

" vim-R-plugin
let vimrplugin_screenplugin = 0

" }}}

" }}}

" File type settings. {{{
"
augroup MyAutoCmd
  "autocmd BufNewFile,BufRead *.coffee setlocal filetype=coffee
  autocmd BufNewFile,BufRead *.go setlocal filetype=go
augroup END

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
      \ (&listchars == s:listchars_classic) ?
      \   (s:listchars_modern) : (s:listchars_classic)

" }}}

" Toggle options {{{

function! s:toggle_option(option_name)
  execute 'setlocal' a:option_name.'!' a:option_name.'?'
endfunction

" }}}

" }}}

" Others: "{{{
"
" Change cursor shape.
" See: http://blog.remora.cx/2012/10/spotlight-cursor-line.html
" See: https://gist.github.com/1195581
if s:cui_running
  if exists('$TMUX')
    let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
    let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"
  elseif &term =~ 'screen'
    let &t_SI = "\eP\e]50;CursorShape=1\x7\e\\"
    let &t_EI = "\eP\e]50;CursorShape=0\x7\e\\"
  elseif &term =~ 'xterm'
    let &t_SI = "\e]50;CursorShape=1\x7"
    let &t_EI = "\e]50;CursorShape=0\x7"
  endif
endif

" Change the current directory to the current buffer's directory.
"autocmd MyAutoCmd BufEnter * lcd %:p:h

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

" I don't want to use Modula-2 syntax to *.md.
autocmd MyAutoCmd BufNewFile,BufRead *.md setlocal filetype=markdown

" If true Vim master, use English help file.
set helplang& helplang=en,ja

if exists('&relativenumber')
  " Toggle number with relativenumber.
  nnoremap <silent> [toggle]n  :<C-u>exe'set'&nu==&rnu?'nu!':'rnu!'<CR>
else
  " Toggle number.
  nnoremap <silent> [toggle]n  :<C-u>call <SID>toggle_option('number')<CR>
endif

" Toggle mouse.
nnoremap <silent> [toggle]m
      \ :<C-u>exe'set'&mouse=='a'?'mouse=':'mouse=a'<CR>:set mouse?<CR>

" }}}

" Load platform-dependent and temporary config file: "{{{

if filereadable(expand('~/.vimrc.local'))
  source ~/.vimrc.local
endif

" }}}

" Finalize: "{{{
"
if s:when_reloading_vimrc
  " Call on_source hook when reloading .vimrc.
  call neobundle#call_hook('on_source')
endif

" Must be written at the last. See :help 'secure'.
set secure

" }}}

" __END__
" vim: set fdm=marker ts=2 sw=2 sts=2 et:
