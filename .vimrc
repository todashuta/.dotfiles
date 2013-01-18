" .vimrc
" https://github.com/todashuta/profiles

" General {{{ -----------------------------------
set nocompatible                  " viとの互換モードをOFF
if filereadable(expand('~/.vimrc.plugin'))
	source ~/.vimrc.plugin        " plugin設定あれば読み込み
endif
set encoding=utf-8                " エンコードをUTF-8にする
set shellslash                    " Windowsでディレクトリパスの区切り文字に / を使えるようにする
set scrolloff=2                   " カーソルの上下に表示する行数(大きな数字を指定するとカーソルが真ん中になる)
augroup grlcd                     " 開いているバッファのディレクトリに自動で移動
	autocmd!
	autocmd BufEnter * lcd %:p:h
augroup END
set mouse=a                       " ターミナルでマウスを有効化
set guioptions+=a                 " 同上
set ttymouse=xterm2               " 同上
set history=50                    " ヒストリーの保存数
set backspace=indent,eol,start    " バックスペースでインデントや改行を削除できるようにする
set whichwrap=b,s,h,l,<,>,[,]     " カーソルを行頭、行末で止まらないようにする
set virtualedit+=block            " 矩形選択で行末を超えてブロックを選択可能にする
set splitbelow                    " 横分割したら新規ウィンドウは下にする
set splitright                    " 縦分割したら新規ウィンドウは右にする
set clipboard+=unnamed            " OSのクリップボードを使用
set clipboard=unnamed             " ヤンクした文字はシステムのクリップボードに入れる
set modeline                      " modelineを有効にする
"}}}

" File, Backup {{{ ------------------------------
set hidden                        " 編集中でも他のファイルを開けるようにする
set autoread                      " 他で書き換えられたら自動で読み直す
set nobackup                      " バックアップ取らない
set noswapfile                    " スワップファイル作らない
"}}}

" netrw (標準のファイラ) 設定 {{{ ---------------
"let g:netrw_liststyle = 3         " ディレクトリ閲覧をツリー形式にする
let g:netrw_altv = 1              " 'v'でファイルを開くときに右側に開く
let g:netrw_alto = 1              " 'o'でファイルを開くときに下側に開く

" CVSと.で始まるファイルは表示しない
"let g:netrw_list_hide = 'CVS,\(^\|\s\s\)\zs\.\S\+'
"}}}

" Indent, Tab {{{ -------------------------------
"set autoindent                    " 新しい行のインデントを現在行と同じにする
set smartindent                   " 新しい行を作ったときに高度な自動インデントを行う
set tabstop=4                     " タブで表示される空白の数
set softtabstop=4                 " Tab押下時に4文字分移動(Tabかスペースかは別の設定)
set shiftwidth=4                  " インデントの各段階に使われる空白の数
"set expandtab                     " タブの代わりに空白文字を挿入する
"}}}

" Search {{{ ------------------------------------
set incsearch                     " インクリメンタルサーチ
set wrapscan                      " ファイルの最後まで検索したら戻る
set ignorecase                    " 検索時に大文字小文字を区別しない
set smartcase                     " 検索する文字に大文字が一つでもあった場合は区別する
set wildmenu                      " コマンドライン補完を強化されたものにする
set wildmode=longest,list,full    " 共通部まで補完,一覧,順番
set hlsearch                      " 検索文字の強調表示
"}}}

" Key Remap {{{ ---------------------------------
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
inoremap , ,<Space>

" 閉じタグを自動挿入
augroup AutoCloseTag
	autocmd!
	autocmd FileType xml,html inoremap <buffer> </ </<C-x><C-o>
augro END

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
"}}}

" Visual {{{ ------------------------------------
set t_Co=256                " 256色対応
set cmdheight=1             " コマンドラインの高さ
set showcmd                 " 入力中のコマンドを表示
set visualbell              " ビジュアルベル使用
syntax on                   " 色づけをオン
"set ruler                   " ルーラー表示(ステータスライン変えてるため無意味)
set number                  " 行番号を表示する
set showmatch               " 閉じ括弧が入力されたとき、対応する括弧を表示する
set matchpairs+=<:>         " <>のカッコをマッチ対象にする
set matchtime=3             " showmatchの瞬間強調時間
set wrap                    " 画面幅で折り返す
if exists('&colorcolumn')
	set colorcolumn=80      " {数字}列目を強調表示
endif
set list                    " タブ文字、行末など不可視文字を表示する
" listで表示される文字のフォーマット
"set listchars=tab:▸\ ,trail:›,eol:↲,precedes:«,extends:»
"set listchars=tab:▸\ ,trail:›,eol:⏎,precedes:«,extends:»
set listchars=tab:▸\ ,trail:›,eol:¬,precedes:«,extends:»

" カーソルのある行をハイライト(フォーカスが外れたらハイライトオフ)
autocmd WinEnter *  setlocal cursorline
autocmd WinLeave *  setlocal nocursorline
set cursorline
"}}}

" Status Line {{{ -------------------------------
set laststatus=2            " ステータスラインを常に表示

" ステータスラインの表示 ([フルパス]  [ファイルタイプ:エンコード:改行コード] [カーソル位置/総行数] [%行位置])
set statusline=%<%F%m%r%h%w%=\ \ [%Y:%{&fileencoding}:%{&ff}][%3l/%L,%3v]%3p%%

" 挿入モードとノーマルモードでステータスラインのカラーを変更
"au InsertEnter * hi StatusLine guifg=#ccdc90 guibg=#2E4340 gui=none ctermfg=White ctermbg=Black cterm=none
"au InsertLeave * hi StatusLine guifg=#2E4340 guibg=#ccdc90 gui=none ctermfg=Black ctermbg=White cterm=none
"}}}

" 全角スペースのハイライト(正規表現でマッチさせて背景色を変えている) {{{
scriptencoding utf-8
augroup highlightZenkakuSpace
	autocmd!
	autocmd Colorscheme * highlight ZenkakuSpace term=underline ctermbg=DarkGreen guibg=DarkGreen
	"autocmd VimEnter,WinEnter * match ZenkakuSpace /\t\|\s\+$\|　/
	autocmd VimEnter,WinEnter * match ZenkakuSpace /　/
augroup END
colorscheme default
"}}}

" encoding commands {{{
command! Utf8 edit ++enc=utf-8
command! Sjis edit ++enc=sjis
command! Eucjp edit ++enc=euc-jp
command! Iso2022jp edit ++enc=iso-2202-jp
command! Cp932 edit ++enc=cp932
"}}}

" change encoding commands {{{
command! ChgencUtf8 set fenc=utf-8
command! ChgencSjis set fenc=sjis
command! ChgencEucjp set fenc=euc-jp
command! ChgencIso2022jp set fenc=iso-2202-jp
command! ChgencCp932 set fenc=cp932
"}}}

" ローカル設定(~/.vimrc.local)があればそれを読み込む {{{
if filereadable(expand('~/.vimrc.local'))
	source ~/.vimrc.local
endif
"}}}

" vim:foldmethod=marker
" end of .vimrc
