" .gvimrc
" https://github.com/todashuta/profiles

" OS別Gvim設定

"{{{ For Mac
if has('gui_macvim')
  set guifont=Ricty:h18  " フォントの設定(for MacVim)
  set transparency=4     " 透明度の指定 (for MacVim:透明化する場合は、「環境設定」「詳細」の「実験的レンダラを使用する」「インラインインプットメソッドを使用する」の両方をチェックすること)
  colorscheme solarized  " 色テーマ指定
  set background=light   " 色テーマの傾向
  syntax enable          " 色付け有効化
  set noimdisable        " (KaoriYa)入力モードから抜ける時、自動で日本語入力をオフ
  set imdisableactivate  " (KaoriYa)挿入モードで自動的に日本語入力をONにしない
"}}}

"{{{ For Windows
elseif has('win32') || has('win64')
  set guifont=Ricty:h14  " フォントの設定(for Windows)
  set transparency=235   " 透明度の指定 (for Windows: 1~255; 200代がオススメ)
  colorscheme solarized  " 色テーマ指定
  set background=dark    " 色テーマの傾向
  syntax enable          " 色付け有効化
  set iminsert=0         " 挿入モード開始時のIMオフ
  set imsearch=0         " 検索開始時のIMオフ
  " 挿入モードでのIME状態を記憶させない
  inoremap <silent> <ESC> <ESC>:set iminsert=0<CR>
"}}}

"{{{ For Linux/Ubuntu
else
  set guifont=Ricty\ 12  " フォントの設定(for Linux)
  colorscheme zenburn    " 色テーマ指定
  set background=dark    " 色テーマの傾向
  syntax enable          " 色付け有効化
endif
"}}}

"{{{ Common settings
set antialias             " アンチエイリアス有効化
if exists('&ambiwidth')
  set ambiwidth=double    " 全角記号でカーソルがずれないようにする
endif
set guioptions-=T         " ツールバー非表示
set guioptions=e          " tabをGUIにする
"set showtabline=2         " タブを常に表示
set guicursor=a:blinkon0  " カーソルを点滅させない
set mousefocus            " マウス移動によるフォーカス切り替え有効化
"set lines=24              " 縦幅
"set columns=80            " 横幅
" IMのON/OFFでカーソルの色を変える
hi CursorIM  guifg=black  guibg=red  gui=NONE  ctermfg=black  ctermbg=white  cterm=reverse
"}}}

"{{{ スクロールバーなし
set guioptions-=r  " ウインドウ右側
set guioptions-=R  " 分割されたウインドウ右側
set guioptions-=l  " ウインドウ左側
set guioptions-=L  " 分割されたウインドウ左側
set guioptions-=b  " 水平スクロールバー
"}}}

"{{{ MacVimでアクティブ時と非アクティブ時の透明度を変える
augroup hack234
  autocmd!
  if has('mac')
    autocmd FocusGained * set transparency=4  " アクティブ時の透過率
    autocmd FocusLost * set transparency=30   " 非アクティブ時の透過率
  endif
augroup END
"}}}

" end of .gvimrc
