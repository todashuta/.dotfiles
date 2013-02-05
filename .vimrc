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
augroup MyAutoCommands
  autocmd!
augroup END

if s:is_windows
  " Windowsでディレクトリパスの区切り文字に / を使えるようにする
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
NeoBundle 'vim-scripts/VOoM'
NeoBundle 'scrooloose/nerdtree'
NeoBundle 'thinca/vim-quickrun'
NeoBundle 'h1mesuke/vim-alignta'
NeoBundle 'tpope/vim-surround'
NeoBundle 'troydm/easybuffer.vim'
NeoBundle 'vim-scripts/DirDo.vim'
NeoBundle 'kana/vim-smartchr'
NeoBundle 'kana/vim-submode'
NeoBundle 'glidenote/memolist.vim'
NeoBundle 'hallison/vim-markdown'
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
NeoBundleLazy 'thinca/vim-ref'
NeoBundleLazy 'gregsexton/VimCalc'
NeoBundleLazy 'mattn/calendar-vim'
NeoBundleLazy 'nathanaelkane/vim-indent-guides'
NeoBundleLazy 'skammer/vim-css-color'
NeoBundleLazy 'koron/nyancat-vim'

filetype plugin indent on    " Required!

" Installation check
NeoBundleCheck

" Enable syntax color
syntax enable

" plugin用設定ファイル読み込み
if filereadable(expand('~/.vimrc.plugin'))
  source ~/.vimrc.plugin
endif

" }}}

" General: "{{{
"
" エンコードをUTF-8にする
set encoding=utf-8
" カーソルの上下に表示する行数(大きな数字を指定するとカーソルが真ん中になる)
set scrolloff=2

" ヒストリーの保存数
set history=1000

" バックスペースでインデントや改行を削除できるようにする
set backspace=indent,eol,start
" カーソルを行頭、行末で止まらないようにする
set whichwrap=b,s,h,l,<,>,[,]
" 矩形選択で行末を超えてブロックを選択可能にする
set virtualedit&
set virtualedit+=block

" 横分割したら新規ウィンドウは下にする
set splitbelow
" 縦分割したら新規ウィンドウは右にする
set splitright

" OSのクリップボードを使用
set clipboard&
set clipboard+=unnamed
" ヤンクした文字はシステムのクリップボードに入れる
set clipboard=unnamed

" modelineを有効にする
set modeline

" ターミナルでマウスを有効化
set mouse=a
set guioptions&
set guioptions+=a
set ttymouse=xterm2

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

"}}}

" Search: "{{{
"

" インクリメンタルサーチ
set incsearch
" ファイルの最後まで検索したら戻る
set wrapscan
" 検索時に大文字小文字を区別しない
set ignorecase
" 検索する文字に大文字が一つでもあった場合は区別する
set smartcase

" 検索文字の強調表示
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

" 表示行単位で移動する
noremap j gj
noremap k gk
noremap gj j
noremap gk k

" ESC二回押しで検索ハイライトを消去
nnoremap <ESC><ESC> :nohlsearch<CR>

" ghで物理行頭に移動
noremap gh g^
" glで物理行末に移動
noremap gl g$

" 検索の候補を中央に表示
nmap n nzz
nmap N Nzz
nmap * *zz
nmap # #zz
nmap g* g*zz
nmap g# g#zz

" カッコの入力補助
"inoremap {{ {}<LEFT>
"inoremap [[ []<LEFT>
"inoremap (( ()<LEFT>
"inoremap << <><LEFT>
"inoremap "" ""<LEFT>
"inoremap '' ''<LEFT>

" html,xmlの閉じタグを自動挿入 {{{
augroup AutoCloseTag
  autocmd!
  autocmd FileType xml,html inoremap <buffer> </ </<C-x><C-o>
augroup END
"}}}

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
"noremap <CR> i<CR><ESC>

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

" don't move on *
nnoremap * *<C-o>

" Quick edit and reload .vimrc
nnoremap <silent> <Space>.  :<C-u>edit $MYVIMRC<CR>
nnoremap <silent> <Space>s. :<C-u>source $MYVIMRC<CR>

" Toggle wrap
nnoremap <silent> <Space>w
      \ :<C-u>setlocal wrap!
      \ \|    setlocal wrap?<CR>

" Toggle number
nnoremap <silent> <Space>n
      \ :<C-u>setlocal number!
      \ \|    setlocal number?<CR>

" レジスタの内容を確認
nnoremap <Space>r  :<C-u>registers<CR>

" マークの内容を確認
nnoremap <Space>m  :<C-u>marks<CR>

" :helpを3倍の速度で引く
nnoremap <C-h>  :<C-u>help<Space>

" :close
nnoremap <Space>c  :<C-u>close<CR>

"}}}

" Visual: "{{{

" 256色対応
set t_Co=256
" カラースキーム
colorscheme solarized
" コマンドラインの高さ
set cmdheight=1
" 入力中のコマンドを表示
set showcmd
" ベル無効化
set t_vb=
set visualbell

" ルーラー表示(ステータスライン変えてるため無意味)
"set ruler
" 行番号を表示する
set number
" 相対的な行番号の表示
"set relativenumber

" 閉じ括弧が入力されたとき、対応する括弧を表示する
set showmatch
" <>のカッコをマッチ対象にする
set matchpairs&
set matchpairs+=<:>
" showmatchの瞬間強調時間
set matchtime=3

" 画面幅で折り返す
set wrap

" {数字}列目を強調表示
if exists('&colorcolumn')
  set colorcolumn=80
endif

" タブ文字、行末など不可視文字を表示する
set list
" listで表示される文字のフォーマット
if s:is_windows
  set listchars=tab:>-,trail:-,eol:$,extends:>,precedes:<
else
  set listchars=tab:▸\ ,trail:›,eol:¬,precedes:«,extends:»
  "set listchars=tab:▸\ ,trail:›,eol:↲,precedes:«,extends:»
  "set listchars=tab:▸\ ,trail:›,eol:⏎,precedes:«,extends:»
endif

" カーソルのある行をハイライト(フォーカスが外れたらハイライトオフ)
augroup MyAutoCommands
  autocmd WinEnter * :setlocal cursorline
  autocmd WinLeave * :setlocal nocursorline
augroup END
set cursorline

"}}}

" Status Line: "{{{
"
" ステータスラインを常に表示
set laststatus=2

" ステータスラインの表示 ([フルパス]  [ファイルタイプ:エンコード:改行コード] [カーソル位置/総行数] [%行位置])
set statusline=%<%F%m%r%h%w%=\ \ [%Y:%{&fileencoding}:%{&ff}][%3l/%L,%3v]%3p%%

"}}}

" 全角スペースのハイライト(正規表現でマッチさせて背景色を変える): "{{{
"
if has('syntax')
  syntax enable
  function! ActivateInvisibleIndicator()
    highlight ZenkakuSpace term=underline ctermbg=64 guibg=#719e07
    match ZenkakuSpace /　/
  endfunction
  augroup MyAutoCommands
    autocmd BufEnter,VimEnter,WinEnter * call ActivateInvisibleIndicator()
    autocmd ColorScheme * call ActivateInvisibleIndicator()
  augroup END
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

augroup grlcd
  autocmd!
  autocmd BufEnter * lcd %:p:h
augroup END

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

" 挿入モード時、ステータスラインの色を変更 {{{
" https://github.com/fuenor/vim-statusline/blob/master/insert-statusline.vim
"
" 挿入モード時の色指定 (SOLARIZEDに合わせてる)
if !exists('g:hi_insert')
  let g:hi_insert = '
      \ highlight StatusLine
        \ guifg=#073642 guibg=#b58900 gui=none
        \ ctermfg=235   ctermbg=136   cterm=none
        \ '
endif

" Linux等でESC後にすぐ反映されない場合、次行以降のコメントを解除してください
 if has('unix') && !has('gui_running')
   " ESC後にすぐ反映されない場合
   inoremap <silent> <ESC> <ESC>
   inoremap <silent> <C-[> <ESC>
 endif

if has('syntax')
  augroup InsertHook
    autocmd!
    autocmd InsertEnter * call s:StatusLine('Enter')
    autocmd InsertLeave * call s:StatusLine('Leave')
  augroup END
endif

let s:slhlcmd = ''
function! s:StatusLine(mode)
  if a:mode == 'Enter'
    silent! let s:slhlcmd = 'highlight ' . s:GetHighlight('StatusLine')
    silent exec g:hi_insert
  else
    highlight clear StatusLine
    silent exec s:slhlcmd
  endif
endfunction

function! s:GetHighlight(hi)
  redir => hl
  exec 'highlight '.a:hi
  redir END
  let hl = substitute(hl, '[\r\n]', '', 'g')
  let hl = substitute(hl, 'xxx', '', '')
  return hl
endfunction

" }}}

" 挿入モードに入ったとき一時的に検索のハイライトをオフにする {{{

augroup MyAutoCommands
  autocmd InsertEnter * :setlocal nohlsearch
  autocmd InsertLeave * :setlocal hlsearch
augroup END

"}}}

" Auto diffupdate on diff mode {{{
"
if &diff
  augroup AutoDiffUpdate
    autocmd!
    autocmd InsertLeave * :diffupdate
  augroup END
endif

"}}}

" Others: "{{{
"
" I don't use MODULA2.
augroup MyAutoCommands
  autocmd BufNewFile,BufRead *.md set filetype=markdown
augroup END

"}}}

" ローカル設定(~/.vimrc.local)があれば読み込む: "{{{

if filereadable(expand('~/.vimrc.local'))
  source ~/.vimrc.local
endif

"}}}

" Finalize {{{

if !exists('s:loaded_vimrc')
  let s:loaded_vimrc = 1
endif

" }}}

" vim: set fdm=marker ts=2 sw=2 sts=2 et:
" end of .vimrc
