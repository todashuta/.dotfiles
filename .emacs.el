;==============================
;== Emacs common settings... ==
;==============================
;; load-pathの追加
;(add-to-list 'load-path "~/Dropbox/dotfiles/emacs/site-lisp")
;(add-to-list 'load-path "~/.emacs.d/site-lisp")

;; 言語を日本語にする
(set-language-environment 'japanese)
;; 極力UTF-8とする
(prefer-coding-system 'utf-8 )

;; タイトルバーにフルパスを表示
(setq frame-title-format (format "%%f - Emacs@%s" (system-name)))

;; 行番号・桁番号をモードラインに表示する・しない設定
(line-number-mode t) ; 行番号。tなら表示、nilなら非表示
(column-number-mode t) ; 桁番号。tなら表示、nilなら非表示

;; モードラインに現在時刻を表示する
(display-time)

;; モードラインにバッテリ残量を表示
(display-battery-mode t)

;; 起動時のメッセージを表示しない
;; 「t」を「nil」にするとメッセージが表示される
(setq inhibit-startup-message t)

;; *.~ とかのバックアップファイル(変更前のファイル)
;; 「t」で作成、「nil」で作らない
(setq make-backup-files nil)

;; .#* とかのバックアップファイル(作業中ファイル)
;; 「t」で作成、「nil」で作らない
(setq auto-save-default nil)

;; 表示の行間を拡げる
(set-default 'line-spacing 7)

;; カーソルの場所を保存する
(require 'saveplace)
(setq-default save-place t)

;; エラー時にビープ音の代わりに画面の一部をフラッシュ
(setq visible-bell t)
;; エラー表示を全くなしにする(エラー音を鳴らす関数に空の関数を割り当てる)
(setq ring-bell-function 'ignore)

;; mark箇所の反転表示
(setq-default transient-mark-mode t)

;; C-hをバックスペースにする
(global-set-key "\C-h" 'delete-backward-char)

;; window左右分割時の画面外に出る文章を折り返す
(setq truncate-partial-width-windows nil)

;; カーソルのある行をハイライト
(defface hlline-face
  '((((class color)
      (background dark))
     ;;(:background "dark state gray"))
     (:background "gray10"
                  :underline "gray24"))
    (((class color)
      (background light))
     (:background "Green"
                  :underline nil))
    (t ()))
  "*Face used by hl-line.")
(setq hl-line-face 'hlline-face)
;(setq hl-line-face 'underline)
(global-hl-line-mode)

;; ファイルメニューに最近使ったファイルを表示
(require 'recentf)
(recentf-mode 1)

;; シフトキーで領域選択
;(setq pc-select-selection-keys-only t)
;(pc-selection-mode 1)

;; M-g で指定行へジャンプ
(global-set-key "\M-g" 'goto-line)

;; emacs -nw で起動した時にメニューバーを消す
(if window-system (menu-bar-mode 1) (menu-bar-mode -1))

;; 左に行番号表示(linum)
(require 'linum)
(global-linum-mode t)
(setq linum-format "%4d") ; 書式(予め4桁分スペースを作る)

;; マウスのホイールスクロールスピードを調節
;; 環境によっては機能しないことがある
(global-set-key [wheel-up] '(lambda () "" (interactive) (scroll-down 1)))
(global-set-key [wheel-down] '(lambda () "" (interactive) (scroll-up 1)))
(global-set-key [double-wheel-up] '(lambda () "" (interactive) (scroll-down 1)))
(global-set-key [double-wheel-down] '(lambda () "" (interactive) (scroll-up 1)))
(global-set-key [triple-wheel-up] '(lambda () "" (interactive) (scroll-down 1)))
(global-set-key [triple-wheel-down] '(lambda () "" (interactive) (scroll-up 1)))

;; フルスクリーン(Meta-returnでトグル)
;; 環境によって振舞いが異なる？
(defun toggle-fullscreen ()
  (interactive)
  (set-frame-parameter nil 'fullscreen (if (frame-parameter nil 'fullscreen)
                                           nil
                                           'fullboth)))
(global-set-key [(meta return)] 'toggle-fullscreen)

;; 対応する括弧をハイライト
(show-paren-mode 1)

;; 補完時に大文字小文字を区別しない
(setq completion-ignore-case t)
(setq read-file-name-completion-ignore-case t)

;; 部分一致の補完機能を使う (p-bでprint-bufferとか)
(partial-completion-mode t)

;; 補完可能なものを随時表示 (少しうるさい)
(icomplete-mode 1)

;; 行の先頭でC-kを一回押すだけで行全体を消去する (改行コード含ということ)
;(setq kill-whole-line t)

;; クリップボードをシステムと共有する (GUI上のみ)
(setq x-select-enable-clipboard t)

;; ペースト時にテキストの追加属性を無視 (画像がペーストされるのを防止)
(setq yank-excluded-properties t)

;; カーソルの点滅を止める
(blink-cursor-mode 0)

;; カーソル形状の変更
;(add-to-list 'default-frame-alist '(cursor-type . 'hollow)) ;; 中空カーソル

;; 矩形選択 sense-region
;; 選択中にC-SPCで矩形選択に移行
(require 'sense-region)
(sense-region-on)

;; C-x bでミニバッファにバッファ候補を表示
(iswitchb-mode t)
(iswitchb-default-keybindings)

;; "yes or no"を"y or n"に
(fset 'yes-or-no-p 'y-or-n-p)

;; 改行コードを表示
(setq eol-mnemonic-dos "(CRLF:dos)")
(setq eol-mnemonic-mac "(CR:mac)")
(setq eol-mnemonic-unix "(LF:unix)")

;; カーソルを物理行移動させる(physical-line.el)
(require 'physical-line)
(setq-default physical-line-mode t)

;; モードラインの色の設定
(set-face-background 'modeline "gray8")
(set-face-foreground 'modeline "LightSeaGreen")

;===========================================================

;====================================
;== jaspace.el を使った全角空白、タブ、改行表示モード
;== 切り替えは M-x jaspace-mode-on or -off
;====================================
(require 'jaspace)
;; 全角空白を表示させる。
;(setq jaspace-alternate-jaspace-string "□")
;; 改行記号を表示させる。
(setq jaspace-alternate-eol-string "↲\n")
;; タブ記号を表示。
;(setq jaspace-highlight-tabs t)  ; highlight tabs

;; EXPERIMENTAL: On Emacs 21.3.50.1 (as of June 2004) or 22.0.5.1, a tab
;; character may also be shown as the alternate character if
;; font-lock-mode is enabled.
;; タブ記号を表示。
;(setq jaspace-highlight-tabs ?&gt;) ; use ^ as a tab marker


;; tabを半角スペース4つにする
;(setq default-tab-width 4)


;; 1行ずつスクロール
(setq scroll-conservatively 35
      scroll-margin 0
      scroll-step 1)
(setq comint-scroll-show-maximum-output t) ;; for shell-mode
;===========================================================

;; end of file
