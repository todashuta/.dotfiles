" .vimrc
" https://github.com/todashuta/profiles

" Initialize: "{{{
"

" Be IMproved.
set nocompatible

" NeoBundle
if has('vim_starting')
  set runtimepath+=~/.vim/bundle/neobundle.vim/
endif

call neobundle#rc(expand('~/.vim/bundle/'))

" Github repos
NeoBundleLazy 'koron/nyancat-vim'
NeoBundle 'Shougo/neocomplcache'
NeoBundleLazy 'mattn/zencoding-vim', {
      \ 'autoload' : {
      \     'filetypes' : ['html','css']
      \    }
      \ }
NeoBundle 'thinca/vim-quickrun'
NeoBundleLazy 'gregsexton/VimCalc'
NeoBundleLazy 'nathanaelkane/vim-indent-guides'
NeoBundleLazy 'thinca/vim-ref'
NeoBundleLazy 'mattn/calendar-vim'
NeoBundle 'altercation/vim-colors-solarized'
NeoBundle 'houtsnip/vim-emacscommandline'
NeoBundle 'othree/eregex.vim'
NeoBundle 'tpope/vim-surround'
NeoBundle 'Shougo/unite.vim'
NeoBundle 'h1mesuke/vim-alignta'
NeoBundleLazy 'h1mesuke/unite-outline',
      \ { 'depends' : 'Shougo/unite.vim' }
NeoBundle 'vim-scripts/VOoM'
NeoBundleLazy 'skammer/vim-css-color'
NeoBundle 'scrooloose/nerdtree'
NeoBundle 'troydm/easybuffer.vim'
NeoBundle 'vim-scripts/DirDo.vim'
NeoBundle 'Shougo/vimfiler',
      \ { 'depends' : 'Shougo/unite.vim' }
NeoBundle 'Shougo/vimproc', {
      \ 'build' : {
      \     'windows' : 'make -f make_mingw32.mak',
      \     'cygwin' : 'make -f make_cygwin.mak',
      \     'mac' : 'make -f make_mac.mak',
      \     'unix' : 'make -f make_unix.mak',
      \    },
      \ }
NeoBundle 'Shougo/vimshell'

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
" Windowsでディレクトリパスの区切り文字に / を使えるようにする
set shellslash
" カーソルの上下に表示する行数(大きな数字を指定するとカーソルが真ん中になる)
set scrolloff=2

" ヒストリーの保存数
set history=1000

" バックスペースでインデントや改行を削除できるようにする
set backspace=indent,eol,start
" カーソルを行頭、行末で止まらないようにする
set whichwrap=b,s,h,l,<,>,[,]
" 矩形選択で行末を超えてブロックを選択可能にする
set virtualedit+=block

" 横分割したら新規ウィンドウは下にする
set splitbelow
" 縦分割したら新規ウィンドウは右にする
set splitright

" OSのクリップボードを使用
set clipboard+=unnamed
" ヤンクした文字はシステムのクリップボードに入れる
set clipboard=unnamed

" modelineを有効にする
set modeline

" ターミナルでマウスを有効化
set mouse=a
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

" カンマのあとに自動でスペースを追加
"inoremap , ,<Space>

" 閉じタグを自動挿入 {{{
augroup AutoCloseTag
  autocmd!
  autocmd FileType xml,html inoremap <buffer> </ </<C-x><C-o>
augro END
"}}}

" ブラウザのようにspaceでページ送り、Shift-spaceで逆向き
noremap <Space> <C-f>
noremap <S-Space> <C-b>

" Control-Spaceで次のバッファ
noremap <C-Space> :bn<CR>

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

" Shiftキー + 矢印キーで分割ウインドウのサイズを調節
nnoremap <silent> <S-Left>  :wincmd <<CR>
nnoremap <silent> <S-Right> :wincmd ><CR>
nnoremap <silent> <S-Up>    :wincmd -<CR>
nnoremap <silent> <S-Down>  :wincmd +<CR>

" Yで行末までヤンク
nnoremap Y y$

"}}}

" Visual: "{{{

" 256色対応
set t_Co=256
" コマンドラインの高さ
set cmdheight=1
" 入力中のコマンドを表示
set showcmd
" ビジュアルベル使用
set visualbell

" ルーラー表示(ステータスライン変えてるため無意味)
"set ruler
" 行番号を表示する
set number

" 閉じ括弧が入力されたとき、対応する括弧を表示する
set showmatch
" <>のカッコをマッチ対象にする
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
"set listchars=tab:▸\ ,trail:›,eol:↲,precedes:«,extends:»
"set listchars=tab:▸\ ,trail:›,eol:⏎,precedes:«,extends:»
set listchars=tab:▸\ ,trail:›,eol:¬,precedes:«,extends:»

" カーソルのある行をハイライト(フォーカスが外れたらハイライトオフ)
autocmd WinEnter *  setlocal cursorline
autocmd WinLeave *  setlocal nocursorline
set cursorline

"}}}

" Status Line: "{{{
"
" ステータスラインを常に表示
set laststatus=2

" ステータスラインの表示 ([フルパス]  [ファイルタイプ:エンコード:改行コード] [カーソル位置/総行数] [%行位置])
set statusline=%<%F%m%r%h%w%=\ \ [%Y:%{&fileencoding}:%{&ff}][%3l/%L,%3v]%3p%%

" 挿入モードとノーマルモードでステータスラインのカラーを変更
"au InsertEnter * hi StatusLine guifg=#ccdc90 guibg=#2E4340 gui=none ctermfg=White ctermbg=Black cterm=none
"au InsertLeave * hi StatusLine guifg=#2E4340 guibg=#ccdc90 gui=none ctermfg=Black ctermbg=White cterm=none

"}}}

" 全角スペースのハイライト(正規表現でマッチさせて背景色を変えている): "{{{
"

scriptencoding utf-8
augroup highlightZenkakuSpace
  autocmd!
  autocmd Colorscheme * highlight ZenkakuSpace term=underline ctermbg=DarkGreen guibg=DarkGreen
  "autocmd VimEnter,WinEnter * match ZenkakuSpace /\t\|\s\+$\|　/
  autocmd VimEnter,WinEnter * match ZenkakuSpace /　/
augroup END
colorscheme default

"}}}

" Encoding commands: "{{{
"
" Open encoding commands
command! Utf8 edit ++enc=utf-8
command! Sjis edit ++enc=sjis
command! Eucjp edit ++enc=euc-jp
command! Iso2022jp edit ++enc=iso-2202-jp
command! Cp932 edit ++enc=cp932

" Change encoding commands
command! ChgencUtf8 set fenc=utf-8
command! ChgencSjis set fenc=sjis
command! ChgencEucjp set fenc=euc-jp
command! ChgencIso2022jp set fenc=iso-2202-jp
command! ChgencCp932 set fenc=cp932

"}}}

" 開いているバッファのディレクトリに自動で移動: "{{{

augroup grlcd
  autocmd!
  autocmd BufEnter * lcd %:p:h
augroup END

"}}}

" netrw.vim (標準のファイラ) 設定: "{{{

" ディレクトリ閲覧をツリー形式にする
"let g:netrw_liststyle = 3

" 'v'でファイルを開くときに右側に開く
let g:netrw_altv = 1

" 'o'でファイルを開くときに下側に開く
let g:netrw_alto = 1

" CVSと.で始まるファイルは表示しない
"let g:netrw_list_hide = 'CVS,\(^\|\s\s\)\zs\.\S\+'

"}}}

" Others: "{{{
"
" I don't use MODULA2.
autocmd BufNewFile,BufRead *.md set filetype=markdown

"}}}

" ローカル設定(~/.vimrc.local)があれば読み込む: "{{{

if filereadable(expand('~/.vimrc.local'))
  source ~/.vimrc.local
endif

"}}}

" vim: set fdm=marker ts=2 sw=2 sts=2 et:
" end of .vimrc
