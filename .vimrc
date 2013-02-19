" .vimrc
" https://github.com/todashuta/profiles

scriptencoding utf-8

" Initialize: "{{{
"

" Be IMproved.
set nocompatible

let s:is_windows = has('win16') || has('win32') || has('win64')
let s:is_cygwin = has('win32unix')
let s:is_mac = !s:is_windows && !s:is_cygwin
      \ && (has('mac') || has('macunix') || has('gui_macvim') ||
      \   (!executable('xdg-open') &&
      \     system('uname') =~? '^darwin'))
let s:is_linux = !s:is_windows && !s:is_cygwin && !s:is_mac &&
      \   system('uname') =~? 'linux'

" Reset all autocmd defined in this file.
augroup MyAutoCmd
  autocmd!
augroup END

if s:is_windows
  " Exchange path separator to slash on Windows.
  set shellslash
endif

" NeoBundle
if has('vim_starting')
  set runtimepath+=~/.vim/bundle/neobundle.vim/
endif

call neobundle#rc(expand('~/.vim/bundle/'))

" Github repos
NeoBundle 'Shougo/neocomplcache'
NeoBundle 'Shougo/unite.vim'
NeoBundle 'Shougo/vimfiler',
      \ { 'depends' : 'Shougo/unite.vim' }
NeoBundleLazy 'h1mesuke/unite-outline',
      \ { 'depends' : 'Shougo/unite.vim' }
NeoBundle 'Shougo/vimproc', {
      \ 'build' : {
      \     'windows' : 'make -f make_mingw32.mak',
      \     'cygwin' : 'make -f make_cygwin.mak',
      \     'mac' : 'make -f make_mac.mak',
      \     'unix' : 'make -f make_unix.mak',
      \    },
      \ }
NeoBundle 'altercation/vim-colors-solarized'
NeoBundle 'othree/eregex.vim'
NeoBundleLazy 'vim-scripts/VOoM', {
      \ 'autoload' : {
      \     'filetypes' : ['html','markdown','python','latex']
      \    },
      \ }
NeoBundle 'scrooloose/nerdtree'
NeoBundle 'thinca/vim-quickrun'
NeoBundle 'h1mesuke/vim-alignta'
NeoBundleLazy 'tpope/vim-surround', { 'autoload' : {
      \ 'insert' : 1,
      \ }}
"NeoBundle 'troydm/easybuffer.vim'
NeoBundle 'vim-scripts/DirDo.vim'
NeoBundleLazy 'kana/vim-smartchr', { 'autoload' : {
      \ 'insert' : 1,
      \ }}
NeoBundle 'kana/vim-submode'
NeoBundleLazy 'glidenote/memolist.vim', { 'autoload' : {
      \ 'commands' : ['MemoGrep','MemoList','MemoNew']
      \ }}
NeoBundleLazy 'hallison/vim-markdown', {
      \ 'autoload' : {
      \     'filetypes' : ['markdown']
      \    },
      \ }
"NeoBundle 'houtsnip/vim-emacscommandline'
NeoBundleLazy 'Shougo/vimshell', {
      \ 'depends' : 'Shougo/vimproc',
      \ 'autoload' : {
      \     'commands' : ['VimShell']
      \    },
      \ }
NeoBundleLazy 'mattn/zencoding-vim', {
      \ 'autoload' : {
      \     'filetypes' : ['html','css']
      \    },
      \ }
NeoBundleLazy 'thinca/vim-ref', { 'autoload' : {
      \ 'commands' : 'Ref'
      \ }}
NeoBundleLazy 'gregsexton/VimCalc', { 'autoload' : {
      \ 'commands' : 'Calc'
      \ }}
NeoBundleLazy 'mattn/calendar-vim', { 'autoload' : {
      \ 'commands' : ['Calendar','CalendarH']
      \ }}
NeoBundleLazy 'nathanaelkane/vim-indent-guides'
NeoBundleLazy 'skammer/vim-css-color'
NeoBundleLazy 'lilydjwg/colorizer'
NeoBundleLazy 'koron/nyancat-vim', { 'autoload' : {
      \ 'commands' : ['Nyancat','Nyancat2']
      \ }}
NeoBundleLazy 'hail2u/vim-css3-syntax', {
      \ 'autoload' : {
      \     'filetypes' : ['html','css']
      \    },
      \ }
NeoBundleLazy 'othree/html5.vim', {
      \ 'autoload' : {
      \     'filetypes' : ['html','css']
      \    },
      \ }
NeoBundleLazy 'kana/vim-smartinput', { 'autoload' : {
      \ 'insert' : 1,
      \ }}
NeoBundle 'kien/ctrlp.vim'
NeoBundleLazy 'basyura/TweetVim', { 'depends' :
      \ ['basyura/twibill.vim','tyru/open-browser.vim'],
      \ 'autoload' : { 'commands' : 'TweetVimHomeTimeline' }}
NeoBundle 'Lokaltog/vim-powerline'

filetype plugin indent on    " Required!

" Installation check
NeoBundleCheck

" Enable syntax color
syntax enable

" }}}

" General: "{{{
"
" エンコードをUTF-8にする
set encoding=utf-8
" カーソルの上下に表示する行数(大きな数字を指定するとカーソルが真ん中になる)
set scrolloff=2

" A history of ":" commands, and a history of previous search patterns.
set history=1000

" Enable backspace delete indent and newline.
set backspace=indent,eol,start
" カーソルを行頭、行末で止まらないようにする
set whichwrap=b,s,h,l,<,>,[,]
" 矩形選択で行末を超えてブロックを選択可能にする
set virtualedit& virtualedit+=block

" 横分割したら新規ウィンドウは下にする
set splitbelow
" 縦分割したら新規ウィンドウは右にする
set splitright

" Use clipboard register. (i.e. Use OS's clipboard.)
set clipboard& clipboard+=unnamed

" Enable modeline.
set modeline

" Enable the use of the mouse.
set mouse=a
set guioptions& guioptions+=a
set ttymouse=xterm2

" Indicates a fast terminal connection.
set ttyfast

" Don't redraw while macro executing.
set lazyredraw

"}}}

" File,Backup: "{{{
"
" 編集中でも他のファイルを開けるようにする
set hidden
" 他で書き換えられたら自動で読み直す
set autoread
" バックアップファイルを作らない
set nobackup
" スワップファイル作らない
set noswapfile

"}}}

" Indent,Tab: "{{{
"

" 新しい行のインデントを現在行と同じにする
"set autoindent
" 新しい行を作ったときに高度な自動インデントを行う
set smartindent
" タブで表示される空白の数
set tabstop=4
" Tab押下時に4文字分移動(Tabかスペースかは別の設定)
set softtabstop=4
" インデントの各段階に使われる空白の数
set shiftwidth=4
" タブの代わりに空白文字を挿入する
"set expandtab
" Smart insert tab setting.
"set smarttab
" Disable auto wrap.
autocmd MyAutoCmd FileType * setlocal textwidth=0

"}}}

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

" wildmenu: コマンドライン補完を強化されたものにする
set wildmenu
" 共通部まで補完,一覧,順番
set wildmode=longest,list,full
" wildmenu補完で除外するパターン
set wildignore&
set wildignore+=.DS_Store
"set wildignore+=*~,*.swp,*.tmp
"set wildignore+=*.bmp,*.gif,*.ico,*.jpg,*.png

"}}}

" Key Mappings: "{{{
"

" Move cursor by display line.
noremap j gj
noremap k gk
noremap gj j
noremap gk k

" Clear highlight of search results.
nnoremap <ESC><ESC> :nohlsearch<CR>

" Move to the first non-blank characters of the screen line.
noremap gh g^
" Move to the last characters of the screen line.
noremap gl g$

" Centering search result and open fold.
nnoremap n nzzzv
nnoremap N Nzzzv
"nnoremap * *zzzv
"nnoremap # #zzzv
nnoremap g* g*zzzv
nnoremap g# g#zzzv

" Don't move on *
nnoremap * *<C-o>

" Don't move on #
nnoremap # #<C-o>

" Centering <C-o>, <C-i>
nnoremap <C-o> <C-o>zz
nnoremap <C-i> <C-i>zz

" Input support the parentheses.
"inoremap {{ {}<LEFT>
"inoremap [[ []<LEFT>
"inoremap (( ()<LEFT>
"inoremap << <><LEFT>
"inoremap "" ""<LEFT>
"inoremap '' ''<LEFT>

" html,xmlの閉じタグを自動挿入
if exists('&omnifunc')
  autocmd MyAutoCmd FileType xml,html inoremap <buffer> </ </<C-x><C-o>
endif

" ブラウザのようにSpaceでページ送り、Shift-Spaceで逆向き
"noremap <Space> <PageDown>
"noremap <S-Space> <PageUp>

" タブ切り替え
nnoremap <C-Tab>   gt
nnoremap <C-S-Tab> gT

" バッファの切り替え
"nnoremap <C-Tab>  :bn<CR>
"nnoremap <C-S-Tab>  :bp<CR>

" ;でコマンド入力(;と:を入れ替え)
noremap ; :
noremap : ;

" ノーマルモードでも改行だけできるようにする
"nnoremap <CR> i<CR><ESC>

" ビジュアルモードでインデント変更後も選択を継続する
vnoremap < <gv
vnoremap > >gv

" ノーマルモードのインデントの操作をビジュアルモードと同様にする
nnoremap < <<
nnoremap > >>

" Shiftキー + 矢印キーで分割ウインドウのサイズを調節
nnoremap <silent> <S-Left>  :wincmd <<CR>
nnoremap <silent> <S-Right> :wincmd ><CR>
nnoremap <silent> <S-Up>    :wincmd -<CR>
nnoremap <silent> <S-Down>  :wincmd +<CR>

" Yで行末までヤンク
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

" Quick edit and reload .vimrc
nnoremap <silent> <Space>.  :<C-u>tabedit $MYVIMRC<CR>
nnoremap <silent> <Space>g. :<C-u>tabedit $MYGVIMRC<CR>
nnoremap <silent> <Space>s. :<C-u>source $MYVIMRC
                             \ \| if has('gui_running')
                             \ \|   source $MYGVIMRC
                             \ \| endif <CR>

" Toggle wrap
nnoremap <silent> <Space>w
      \ :<C-u>setlocal wrap!
      \ \|    setlocal wrap?<CR>

" Toggle number
"nnoremap <silent> <Space>n
"      \ :<C-u>setlocal number!
"      \ \|    setlocal number?<CR>
nnoremap <silent> <Space>n
      \ :<C-u>call ChangeLineNumberMode()<CR>

" Release Space Key for Mappings below. (not required)
nnoremap <Space> <Nop>

" レジスタの内容を確認
nnoremap <Space>r :<C-u>registers<CR>

" マークの内容を確認
nnoremap <Space>m :<C-u>marks<CR>

" :helpを3倍の速度で引く
nnoremap <C-h> :<C-u>help<Space>

" :close
nnoremap <Space>c :<C-u>close<CR>

" PasteToggle
"nnoremap <Space>p :<C-u>
"set pastetoggle=<Space>p
"nnoremap <Space>p :<C-u>setlocal paste mouse=<CR>
nnoremap <silent> <Space>p
      \ :<C-u>call ToggleOption('paste')<CR>:set mouse=<CR>

" 画面分割
nnoremap <Space>S :<C-u>split<CR>
"nnoremap <Space>sp :<C-u>split<CR>
nnoremap <Space>V :<C-u>vsplit<CR>
"nnoremap <Space>v :<C-u>vsplit<CR>

nnoremap q <Nop>
"nnoremap Q q
nnoremap K <Nop>
"nnoremap qK K

"noremap <Space>j <C-f>
"noremap <Space>k <C-b>

" コピーした文字で繰り返し上書きペーストする
vnoremap <silent> <C-p> "0p<CR>

"}}}

" Visual: "{{{

" Set title of the window to the value of 'titlestring'.
set title
" Enable 256 color terminal.
set t_Co=256
" Color scheme
colorscheme solarized
" Number of screen lines to use for the command-line.
set cmdheight=1
" Show (partial) command in the last line of the screen.
set showcmd
" Disable bell.
set t_vb=
set visualbell

" Show the line and column number of the cursor position, separated by a comma.
"set ruler
" Show line number.
set number
" Show line number relative to the line with the cursor.
"set relativenumber

" 閉じ括弧が入力されたとき、対応する括弧を表示する
set showmatch
" <>のカッコをマッチ対象にする
set matchpairs& matchpairs+=<:>
" showmatchの瞬間強調時間
set matchtime=3

" 画面幅で折り返す
set wrap

" {数字}列目を強調表示
"if exists('&colorcolumn')
"  set colorcolumn=80
"endif

" colorcolumn+
" http://hanschen.org/2012/10/24/
" http://stackoverflow.com/questions/2447109/showing-a-different-background-colour-in-vim-past-80-characters
"if exists('&colorcolumn')
"  "autocmd MyAutoCmd InsertEnter * setlocal colorcolumn=80
"  autocmd MyAutoCmd InsertEnter * execute "setlocal colorcolumn=".join(range(81,335),',')
"  autocmd MyAutoCmd InsertLeave * setlocal colorcolumn=""
"endif

if exists('&colorcolumn')
  autocmd MyAutoCmd BufEnter,VimResized * call s:ColorcolumnPlus()
  function! s:ColorcolumnPlus()
    if &columns >= 85
      execute "setlocal colorcolumn=".join(range(81,335),',')
    else
      setlocal colorcolumn=""
    endif
  endfunction
endif

" Indicate tab, wrap, trailing spaces and eol or not.
set list
" Strings to use in 'list' mode and for the :list command.
if s:is_windows
  set listchars=tab:>-,trail:-,eol:$,extends:>,precedes:<
else
  set listchars=tab:▸\ ,trail:›,precedes:«,extends:»
  "set listchars=tab:▸\ ,trail:･,eol:¬,precedes:«,extends:»
  "set listchars=tab:▸\ ,trail:›,eol:¬,precedes:«,extends:»
  "set listchars=tab:▸\ ,trail:›,eol:↲,precedes:«,extends:»
  "set listchars=tab:▸\ ,trail:›,eol:⏎,precedes:«,extends:»
endif

" カーソルのあるところでだけ行ハイライト(フォーカスが外れたらハイライトオフ)
autocmd MyAutoCmd WinEnter * setlocal cursorline
autocmd MyAutoCmd WinLeave * setlocal nocursorline
setlocal cursorline

"}}}

" Status Line: "{{{
"
" ステータスラインを常に表示
set laststatus=2

" Set statusline.
"function! s:my_statusline()
"  if &columns >= 80    " Long version
"    let &statusline = ''
"    let &statusline .= '%{&paste ? "  [PASTE]" : ""}'  " Paste mode Indicator
"    let &statusline .= ' [%2n]'         " Buffer number
"    let &statusline .= ' %<%F'          " Full path to the file in the buffer.
"    let &statusline .= '%m%r%h%w'       " Modified flag, Readonly flag, Help flag, Preview flag
"    let &statusline .= '%= '            " Separation point between left and right, and Space.
"    let &statusline .= ' [%{strlen(&ft) ? &ft : "no ft"}]
"                        \[%{(&fenc == "" ? &enc : &fenc)}]
"                        \[%{&fileformat}]'
"    let &statusline .= ' [%4l/%L:%3v]'  " Line number / Number of lines in buffer, Virtual column number.
"    let &statusline .= ' %3p%% '        " Percentage through file in lines as in |CTRL-G|.
"  else                 " Short version
"    let &statusline = ''
"    let &statusline .= '%{&paste ? "[P]" : ""}'  " Paste mode Indicator
"    let &statusline .= '%<%t'         " File name of file in the buffer.
"    let &statusline .= '%m%r%h%w'     " Modified flag, Readonly flag, Help flag, Preview flag
"    let &statusline .= '%= '          " Separation point between left and right, and Space.
"    let &statusline .= '[%{&filetype}:%{&fileencoding}:%{&fileformat}]'
"    let &statusline .= '[%3l:%2v]'    " Line number, Virtual column number.
"    let &statusline .= '%3p%%'        " Percentage through file in lines as in |CTRL-G|.
"  endif
"endfunction
"
"autocmd MyAutoCmd VimEnter,VimResized * call s:my_statusline()

"}}}

" 全角スペースのハイライト(正規表現でマッチさせて背景色を変える): "{{{
"
if has('syntax')
  syntax enable
  function! s:HighlightZenkakuSpace()
    highlight ZenkakuSpace term=underline ctermbg=64 guibg=#719e07
    match ZenkakuSpace /　/
  endfunction
  autocmd MyAutoCmd VimEnter,WinEnter,ColorScheme * call s:HighlightZenkakuSpace()
endif

"}}}

" Encoding commands: "{{{
"
" Reopen as each encodings
command! Utf8      edit ++encoding=utf-8
command! Sjis      edit ++encoding=sjis
command! Eucjp     edit ++encoding=euc-jp
command! Iso2022jp edit ++encoding=iso-2202-jp
command! Cp932     edit ++encoding=cp932

" Change encoding commands
command! ChgEncUtf8      set fileencoding=utf-8
command! ChgEncSjis      set fileencoding=sjis
command! ChgEncEucjp     set fileencoding=euc-jp
command! ChgEncIso2022jp set fileencoding=iso-2202-jp
command! ChgEncCp932     set fileencoding=cp932

"}}}

" 開いているバッファのディレクトリに自動で移動: "{{{

autocmd MyAutoCmd BufEnter * lcd %:p:h

"}}}

" 挿入モード時、ステータスラインの色を変更 {{{
" https://github.com/fuenor/vim-statusline/blob/master/insert-statusline.vim
"
" 挿入モード時の色指定 (SOLARIZEDに合わせてる)
""if !exists('g:hi_insert')
""  let g:hi_insert = 'highlight StatusLine
""        \ guifg=#073642 guibg=#b58900 gui=none
""        \ ctermfg=235   ctermbg=136   cterm=none
""        \ '
""endif
""
""" Linux等でESC後にすぐ反映されない場合、次行以降のコメントを解除してください
"" if has('unix') && !has('gui_running')
""   " ESC後にすぐ反映されない場合
""   inoremap <silent> <ESC> <ESC>
""   inoremap <silent> <C-[> <ESC>
"" endif
""
""if has('syntax')
""  augroup InsertHook
""    autocmd!
""    autocmd InsertEnter * call s:StatusLine('Enter')
""    autocmd InsertLeave * call s:StatusLine('Leave')
""  augroup END
""endif
""
""let s:slhlcmd = ''
""function! s:StatusLine(mode)
""  if a:mode == 'Enter'
""    silent! let s:slhlcmd = 'highlight ' . s:GetHighlight('StatusLine')
""    silent exec g:hi_insert
""  else
""    highlight clear StatusLine
""    silent exec s:slhlcmd
""  endif
""endfunction
""
""function! s:GetHighlight(hi)
""  redir => hl
""  exec 'highlight '.a:hi
""  redir END
""  let hl = substitute(hl, '[\r\n]', '', 'g')
""  let hl = substitute(hl, 'xxx', '', '')
""  return hl
""endfunction

" }}}

" When enter insert mode, disable hlsearch temporary. {{{
"
autocmd MyAutoCmd InsertEnter * setlocal nohlsearch
autocmd MyAutoCmd InsertLeave * setlocal hlsearch

"}}}

" Automatic diffupdate on diff mode {{{
"
autocmd MyAutoCmd InsertLeave *
      \ if &diff | diffupdate | echo 'diffupdated' | endif

"}}}

" Automatic paste disable {{{
"
autocmd MyAutoCmd InsertLeave *
      \ if &paste | set nopaste mouse=a | echo 'nopaste' | endif

"}}}

"------------------------------------------------------------------------------
" Plugin: "{{{
"

" neocomplcache.vim {{{

" Launches neocomplcache automatically on vim startup.
let g:neocomplcache_enable_at_startup = 1
" <CR>: Close popup and save indent.
inoremap <expr><CR> neocomplcache#smart_close_popup() . "\<CR>"
" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
" <Shift-TAB>: Reverse completion.
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
" AutoCompPop like behavior.
"let g:neocomplcache_enable_auto_select = 1
" The number of candidates in popup menu. (Default: 100)
"let g:neocomplcache_max_list = 20
" <C-g>: Undo completion.
inoremap <expr><C-g> neocomplcache#undo_completion()
" <C-l>: Complete common string.
inoremap <expr><C-l> neocomplcache#complete_common_string()
" <C-h>, <BS>: Close popup and delete backward char.
"inoremap <expr><C-h> neocomplcache#smart_close_popup()."\<C-h>"
"inoremap <expr><BS> neocomplcache#smart_close_popup()."\<BS>"

"}}}

" zencoding.vim {{{

"let g:user_zen_leader_key = '<C-y>'
let g:user_zen_leader_key = '<C-e>'
let g:user_zen_settings = {
      \ 'lang' : 'ja',
      \ }

"}}}

" eregex.vim {{{

nnoremap / :M/
nnoremap ? :M?
nnoremap ,/ /
nnoremap ,? ?

"}}}

" NERDTree {{{

" NERDTreeToggle
"noremap <C-N><C-N> :NERDTreeToggle<CR>
noremap <Space>f  :<C-u>NERDTreeToggle<CR>
" Disables display of the 'Bookmarks' and 'help'.
let NERDTreeMinimalUI = 1
" Display hidden files (i.e. "dot files").
let NERDTreeShowHidden = 1

"}}}

" unite.vim {{{

" 入力モードで開始する
"let g:unite_enable_start_insert = 1
" バッファ一覧
noremap <C-U><C-B> :Unite buffer<CR>
" ファイル一覧
noremap <C-U><C-F> :UniteWithBufferDir -buffer-name=files file<CR>
" 最近使ったファイルの一覧
noremap <C-U><C-R> :Unite file_mru<CR>
" レジスタ一覧
noremap <C-U><C-Y> :Unite -buffer-name=register register<CR>
" ファイルとバッファ
noremap <C-U><C-U> :Unite buffer file_mru<CR>
" 全部
noremap <C-U><C-A> :UniteWithBufferDir -buffer-name=files buffer file_mru bookmark file<CR>
" ESCキーを3回押すと終了する
"au FileType unite nnoremap <silent> <buffer> <ESC><ESC><ESC> :q<CR>
"au FileType unite inoremap <silent> <buffer> <Esc><Esc><ESC> <Esc>:q<CR>
" C-U 二連打で終了する
autocmd MyAutoCmd FileType unite nnoremap <silent> <buffer> <C-U><C-U> :q<CR>
autocmd MyAutoCmd FileType unite inoremap <silent> <buffer> <C-U><C-U> <Esc>:q<CR>

nnoremap <Space>b :<C-u>Unite buffer<CR>
nnoremap <Space>y :<C-u>Unite -buffer-name=register register<CR>
nnoremap <Space>u :<C-u>UniteWithBufferDir -buffer-name=files buffer file_mru bookmark file<CR>
"autocmd MyAutoCmd FileType unite nnoremap <silent><buffer> <Space>u :<C-u>q<CR>
autocmd MyAutoCmd FileType unite imap <buffer> <C-w> <Plug>(unite_delete_backward_path)

"}}}

" SOLARIZED {{{

" Visibility of `listchars' (normal, high, low)
let g:solarized_visibility='low'
" Toggle background key (Light or Dark)
call togglebg#map("<F5>")
" On iTerm2, distinguish the settings by $ITERM_PROFILE
if !has('gui_running')
  if $ITERM_PROFILE =~? 'solarized' && $ITERM_PROFILE =~? 'light'
    let g:solarized_termcolors=16
    set background=light
    colorscheme solarized
    let g:Powerline_colorscheme = 'solarized'
  elseif $ITERM_PROFILE =~? 'solarized' && $ITERM_PROFILE =~? 'dark'
    let g:solarized_termcolors=16
    set background=dark
    colorscheme solarized
    let g:Powerline_colorscheme = 'solarized16'
  else
    let g:solarized_termcolors=256
    set background=light
    colorscheme solarized
    "colorscheme jellybeans
    let g:Powerline_colorscheme = 'default'
  endif
endif

"}}}

" vim-smartchr {{{

inoremap <expr> = smartchr#one_of(' = ', ' == ', ' === ', '=')
inoremap <expr> , smartchr#one_of(', ', ',')
inoremap <expr> : smartchr#one_of(': ', ' : ', ':')
inoremap <buffer> <expr> . smartchr#loop('.',  ' . ',  '..', '...')

augroup MyAutoCmd
  autocmd FileType css inoremap <expr> : smartchr#one_of(':')
augroup END

"}}}

" indent-guides {{{

" indent-guidesを最初から有効にする
"let g:indent_guides_enable_on_vim_startup = 1
" 色の変化の幅
let g:indent_guides_color_change_percent = 30
" ガイド幅
let g:indent_guides_guide_size = 1

"}}}

" netrw.vim (標準のファイラ) 設定: "{{{
"
" ディレクトリ閲覧をツリー形式にする
"let g:netrw_liststyle = 3
" 'v'でファイルを開くときに右側に開く
let g:netrw_altv = 1
" 'o'でファイルを開くときに下側に開く
let g:netrw_alto = 1
" CVSと.で始まるファイルは表示しない
"let g:netrw_list_hide = 'CVS,\(^\|\s\s\)\zs\.\S\+'

"}}}

" vim-powerline {{{
"
"let g:Powerline_symbols = 'fancy'            " Requires a patched font.
"let g:Powerline_colorscheme = 'solarized'    " light
"let g:Powerline_colorscheme = 'solarized16'  " dark
"let g:Powerline_cache_enabled = 0
let g:Powerline_stl_path_style = 'relative'
let g:Powerline_dividers_override = ['', '', '', '❮']
let g:Powerline_symbols_override = {
      \ 'LINE': '',
      \ }
"call Pl#Theme#ReplaceSegment('lineinfo', 'scrollpercent')
"call Pl#Theme#ReplaceSegment('scrollpercent', 'lineinfo')

" CUI上でESC後すぐに反映させる
if has('unix') && !has('gui_running')
  inoremap <silent> <ESC> <ESC>
  inoremap <silent> <C-[> <ESC>
  vnoremap <silent> <ESC> <ESC>
  vnoremap <silent> <C-[> <ESC>
endif

"}}}

" Others {{{

" Expand the jump functions of % command (e.g. HTML tags, if/else/endif, etc.)
runtime macros/matchit.vim

"}}}

"}}}

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

"}}}

" Commands: "{{{
"
" ToggleListChars {{{

function! ToggleListChars()
  if &listchars=~ '^tab:>-'
    "set listchars=tab:▸\ ,trail:›,eol:¬,precedes:«,extends:»
    set listchars=tab:▸\ ,trail:›,precedes:«,extends:»
  else
    set listchars=tab:>-,trail:-,eol:$,extends:>,precedes:<
  endif
endfunction

command! ToggleListChars :call ToggleListChars()

"}}}

" Toggle options {{{

function! ToggleOption(option_name)
  execute 'setlocal' a:option_name.'!'
  execute 'setlocal' a:option_name.'?'
endfunction

"}}}

" Toggle number {{{

if exists('&relativenumber')
  function! ChangeLineNumberMode()
    if &number == 0 && &relativenumber == 0
      set number | set number?
    elseif &number == 1
      set relativenumber | set relativenumber?
    elseif &relativenumber == 1
      set norelativenumber
      "set relativenumber?
      echo 'nonumber norelativenumber'
    endif
  endfunction
else
  function! ChangeLineNumberMode()
    set number! | set number?
  endfunction
endif

"}}}

"}}}

" Others: "{{{
"

" Editing binary file.
" See :help hex-editing
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

"}}}

" Load local and temporary config file: "{{{

if filereadable(expand('~/.vimrc.local'))
  source ~/.vimrc.local
endif

"}}}

" Finalize: "{{{

if !exists('s:loaded_vimrc')
  let s:loaded_vimrc = 1
endif

" See :help secure
set secure

" }}}

" vim: set fdm=marker ts=2 sw=2 sts=2 et:
" end of .vimrc
