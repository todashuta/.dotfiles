"===========
"== vimrc ==
"===========

" General ---------------------------------------
set encoding=utf-8                  " エンコードをUTF-8にする
set nocompatible                    " viとの互換モードをOFF
set scrolloff=5                     " カーソルの上下に表示する行数(大きな数字を指定するとカーソルが真ん中になる)
let g:netrw_liststyle=3             " ディレクトリ閲覧をツリー形式にする
set autochdir                       " 現在ディレクトリを、開いているバッファのディレクトリにする
set mouse=a                         " 全モードでマウスを有効化
set history=50                      " ヒストリーの保存数
set backspace=indent,eol,start      " バックスペースでインデントや改行を削除できるようにする
set whichwrap=b,s,h,l,<,>,[,]       " カーソルを行頭、行末で止まらないようにする
set virtualedit+=block              " 矩形選択で行末を超えてブロックを選択可能にする
set clipboard+=unnamed              " クリップボードをシステムと共有する
"set lines=50                        " 縦幅
"set columns=150                     " 横幅

" File, Backup ----------------------------------
set hidden                          " 編集中でも他のファイルを開けるようにする
set autoread                        " 他で書き換えられたら自動で読み直す
set nobackup                        " バックアップ取らない
set noswapfile                      " スワップファイル作らない

" Indent, Tab -----------------------------------
"set autoindent                      " 新しい行のインデントを現在行と同じにする
"set smartindent                     " 新しい行を作ったときに高度な自動インデントを行う
set tabstop=4                       " タブで表示される空白の数
set softtabstop=4                   " Tab押下時に4文字分移動(Tabかスペースかは別の設定)
set shiftwidth=4                    " インデントの各段階に使われる空白の数
"set expandtab                       " タブの代わりに空白文字を挿入する

" Search ----------------------------------------
set incsearch                       " インクリメンタルサーチ
set nowrapscan                      " ファイルの最後まで検索したらそこでやめる
set ignorecase                      " 検索時に大文字小文字を区別しない
set smartcase                       " 検索する文字に大文字が一つでもあった場合は区別する
set wildmenu                        " コマンドライン補完を強化されたものにする
set hlsearch                        " 検索文字の強調表示

" Key Remap -------------------------------------
" 表示行単位で移動する
noremap j gj
noremap k gk
noremap gj j
noremap gk k

" ESC二回押しで検索ハイライトを消去
nnoremap <ESC><ESC> :nohlsearch<CR>

" ghで空白を飛ばした行頭に移動
noremap gh ^
" glで行末に移動
noremap gl $

nmap n nzz
nmap N Nzz
nmap * *zz
nmap # #zz
nmap g* g*zz
nmap g# g#zz

inoremap {} {}<LEFT>
inoremap [] []<LEFT>
inoremap () ()<LEFT>
inoremap <> <><LEFT>
inoremap "" ""<LEFT>
inoremap '' ''<LEFT>

" Visual ----------------------------------------
set t_Co=256                        " 256色対応
set showcmd                         " 入力中のコマンドを表示
set visualbell                      " ビジュアルベル使用
syntax on                           " 色づけをオン
set ruler                           " ステータスラインにカーソル位置を表示
set number                          " 行番号を表示する
set showmatch                       " 閉じ括弧が入力されたとき、対応する括弧を表示する
set matchtime=3                     " showmatchの瞬間強調時間
set wrap                            " 画面幅で折り返す
set colorcolumn=80                  " {数字}列目を強調表示
set list                            " タブ文字、行末など不可視文字を表示する
" listで表示される文字のフォーマット
set listchars=tab:▸\ ,trail:›,eol:↲,precedes:«,extends:»

" Status Line -----------------------------------
set laststatus=2                    " ステータスラインを常に表示

" ステータスラインの表示 ([フルパス]  [ファイルタイプ][改行コード][エンコード][カーソル位置][総行数])
set statusline=%F%m%r%h%w\%=[TYPE=%Y]\[FORMAT=%{&ff}]\[ENC=%{&fileencoding}]\ [POS=%04l,%04v][%p%%]\ [LEN=%L]

" 挿入モードとノーマルモードでステータスラインのカラーを変更(solarized-light用)
au InsertEnter * hi StatusLine guifg=#eee8d5 guibg=#586e75 gui=none ctermfg=White ctermbg=Black cterm=none
au InsertLeave * hi StatusLine guifg=#586e75 guibg=#eee8d5 gui=none ctermfg=Black ctermbg=White cterm=none

" カーソルのある行をハイライト
autocmd WinEnter *  setlocal cursorline
autocmd WinLeave *  setlocal nocursorline
set cursorline

" 全角スペースのハイライト(正規表現を使用している)
scriptencoding utf-8
augroup highlightIdegraphicSpace
  autocmd!
  autocmd ColorScheme * highlight IdeographicSpace term=underline ctermbg=DarkGreen guibg=DarkGreen
  autocmd VimEnter,WinEnter * match IdeographicSpace /　/
augroup END
colorscheme default

" encoding commands
command! Utf8 edit ++enc=utf-8
command! Sjis edit ++enc=sjis
command! Eucjp edit ++enc=euc-jp
command! Iso2022jp edit ++enc=iso-2202-jp
command! Cp932 edit ++enc=cp932
" change encoding commands
command! ChgencUtf8 set fenc=utf-8
command! ChgencSjis set fenc=sjis
command! ChgencEucjp set fenc=euc-jp
command! ChgencIso2022jp set fenc=iso-2202-jp
command! ChgencCp932 set fenc=cp932

" end of file
